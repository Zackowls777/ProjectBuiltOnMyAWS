import hashlib
import json
import os
import shutil
import uuid
import _judger
from flask import Flask, request, Response

from compiler import Compiler
from config import (JUDGER_WORKSPACE_BASE, SPJ_SRC_DIR, SPJ_EXE_DIR, COMPILER_USER_UID, SPJ_USER_UID,
                    RUN_USER_UID, RUN_GROUP_GID, TEST_CASE_DIR)
from exception import TokenVerificationFailed, CompileError, SPJCompileError, JudgeClientError
from judge_client import JudgeClient
from utils import server_info, logger, token, ProblemIOMode
from tiingo_client import TiingoClient
from s3_client import S3Client

app = Flask(__name__)
DEBUG = os.environ.get("DEBUG") == "1"
app.debug = DEBUG
TIINGO_KEY = os.environ.get("TIINGO_KEY")
AWS_REGION_NAME = os.environ.get("AWS_REGION_NAME")
AWS_S3_ACCESS_KEY_ID = os.environ.get("AWS_S3_ACCESS_KEY_ID")
AWS_S3_SECRET_ACCESS_KEY = os.environ.get("AWS_S3_SECRET_ACCESS_KEY")
AWS_S3_WQS_BUCKET = os.environ.get("AWS_S3_WQS_BUCKET")


class InitSubmissionEnv(object):
    def __init__(self, judger_workspace, submission_id, init_test_case_dir=True):
        self.work_dir = os.path.join(judger_workspace, submission_id)
        self.init_test_case_dir = init_test_case_dir
        if init_test_case_dir:
            self.test_case_dir = os.path.join(self.work_dir, "test_case")
        else:
            self.test_case_dir = None

    def __enter__(self):
        try:
            os.mkdir(self.work_dir)
            if self.init_test_case_dir:
                os.mkdir(self.test_case_dir)
            os.chown(self.work_dir, COMPILER_USER_UID, RUN_GROUP_GID)
            os.chmod(self.work_dir, 0o711)
        except Exception as e:
            logger.exception(e)
            raise JudgeClientError("failed to create runtime dir")
        return self.work_dir, self.test_case_dir

    def __exit__(self, exc_type, exc_val, exc_tb):
        if not DEBUG:
            try:
                shutil.rmtree(self.work_dir)
            except Exception as e:
                logger.exception(e)
                raise JudgeClientError("failed to clean runtime dir")


class JudgeServer:
    @classmethod
    def ping(cls):
        data = server_info()
        data["action"] = "pong"
        return data

    @classmethod
    def judge(cls, language_config, src, max_cpu_time, max_memory, test_cases,
              output=False, io_mode=None):
        if not io_mode:
            io_mode = {"io_mode": ProblemIOMode.standard}

        # init
        compile_config = language_config.get("compile")
        run_config = language_config["run"]
        submission_id = str(uuid.uuid4())

        with InitSubmissionEnv(JUDGER_WORKSPACE_BASE, submission_id=submission_id, init_test_case_dir=True) as dirs:
            submission_dir, test_case_dir = dirs

            if compile_config:
                src_path = os.path.join(submission_dir, compile_config["src_name"])

                # write source code into file
                with open(src_path, "w", encoding="utf-8") as f:
                    f.write(src)
                os.chown(src_path, COMPILER_USER_UID, 0)
                os.chmod(src_path, 0o400)

                # compile source code, return exe file path
                exe_path = Compiler().compile(compile_config=compile_config,
                                              src_path=src_path,
                                              output_dir=submission_dir)
                try:
                    # Java exe_path is SOME_PATH/Main, but the real path is SOME_PATH/Main.class
                    # We ignore it temporarily
                    os.chown(exe_path, RUN_USER_UID, 0)
                    os.chmod(exe_path, 0o500)
                except Exception:
                    pass
            else:
                exe_path = os.path.join(submission_dir, run_config["exe_name"])
                with open(exe_path, "w", encoding="utf-8") as f:
                    f.write(src)

            info = {"test_case_number": len(test_cases), "test_cases": {}}

            s3_client = S3Client(AWS_REGION_NAME, AWS_S3_ACCESS_KEY_ID, AWS_S3_SECRET_ACCESS_KEY, AWS_S3_WQS_BUCKET)

            # write test case
            for index, item in enumerate(test_cases):
                index += 1
                item_info = {}

                input_name = str(uuid.uuid4()) + ".csv"
                item_info["input_name"] = input_name

                s3_client.download_csv(item["input"], os.path.join(test_case_dir, input_name))

                info["test_cases"][index] = item_info

            with open(os.path.join(test_case_dir, "info"), "w") as f:
                json.dump(info, f)

            judge_client = JudgeClient(run_config=language_config["run"],
                                       exe_path=exe_path,
                                       max_cpu_time=max_cpu_time,
                                       max_memory=max_memory,
                                       test_case_dir=test_case_dir,
                                       submission_dir=submission_dir,
                                       output=output,
                                       io_mode=io_mode)
            run_results = judge_client.run()

            cpu_time, memory = 0, 0
            for result in run_results:
                cpu_time = max(cpu_time, result['cpu_time'])
                memory = max(memory, result['memory'])
                def cut_data(data: str):
                    max_len = 1024 * 16
                    if len(data) > max_len:
                        return data[:max_len].strip() + " ...\nmore content"
                    return data
                output = cut_data(result.get("output", ""))
                error = cut_data(result.get("error", ""))
                return {
                    'cpu_time': cpu_time,
                    'memory': memory,
                    'result': result['result'],
                    'output': output,
                    'error': error
                }
            return {'cpu_time': cpu_time, 'memory': memory, 'output': "", 'result': _judger.RESULT_SUCCESS}

    @classmethod
    def fetch_stock_daily_data_as_s3_csv_key(cls, symbol, start_day, end_day):

        tiingo_client = TiingoClient(tiingo_key=TIINGO_KEY, symbol=symbol, start_day=start_day, end_day=end_day)

        s3_client = S3Client(AWS_REGION_NAME, AWS_S3_ACCESS_KEY_ID, AWS_S3_SECRET_ACCESS_KEY, AWS_S3_WQS_BUCKET)

        return s3_client.upload_dataframe_as_csv(tiingo_client.info())




@app.route('/', defaults={'path': ''})
@app.route('/<path:path>', methods=["POST"])
def server(path):
    logger.info(str(path))
    if path in ("ping", "judge", "fetch_stock_daily_data_as_s3_csv_key"):
        try:
            _token = request.headers.get("X-Judge-Server-Token")
            if _token != token:
                raise TokenVerificationFailed("invalid token")
            try:
                data = request.json
            except Exception:
                data = {}
            ret = {"err": None, "data": getattr(JudgeServer, path)(**data)}
        except (CompileError) as e:
            logger.exception(e)
            ret = {"err": e.__class__.__name__, "data": {"result": 6, "output": e.message}}
        except (TokenVerificationFailed, SPJCompileError, JudgeClientError) as e:
            logger.exception(e)
            ret = {"err": e.__class__.__name__, "data": {"result": 5, "output": e.message}}
        except Exception as e:
            logger.exception(e)
            ret = {"err": "JudgeClientError", "data": {"result": 5, "output": str(e)}}
    else:
        ret = {"err": "InvalidRequest", "data": "404"}
    return Response(json.dumps(ret), mimetype='application/json')


if DEBUG:
    logger.info("DEBUG=ON")

# gunicorn -w 4 -b 0.0.0.0:8080 server:app
if __name__ == "__main__":
    app.run(debug=DEBUG)
