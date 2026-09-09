import _judger
import hashlib
import json
import os
import shutil
from multiprocessing import Pool

import psutil

from config import TEST_CASE_DIR, JUDGER_RUN_LOG_PATH, RUN_USER_UID, SPJ_EXE_DIR, SPJ_USER_UID, SPJ_GROUP_GID, RUN_GROUP_GID
from exception import JudgeClientError
from utils import ProblemIOMode

SPJ_WA = 1
SPJ_AC = 0
SPJ_ERROR = -1


def _run(instance, test_case_file_id):
    return instance._judge_one(test_case_file_id)


class JudgeClient(object):
    def __init__(self, run_config, exe_path, max_cpu_time, max_memory, test_case_dir,
                 submission_dir, io_mode, output=False):
        self._run_config = run_config
        self._exe_path = exe_path
        self._max_cpu_time = max_cpu_time
        self._max_memory = max_memory
        self._max_real_time = self._max_cpu_time * 3
        self._test_case_dir = test_case_dir
        self._submission_dir = submission_dir

        self._pool = Pool(processes=psutil.cpu_count())
        self._test_case_info = self._load_test_case_info()

        self._output = output
        self._io_mode = io_mode

    def _load_test_case_info(self):
        try:
            with open(os.path.join(self._test_case_dir, "info")) as f:
                return json.load(f)
        except IOError:
            raise JudgeClientError("Test case not found")
        except ValueError:
            raise JudgeClientError("Bad test case config")

    def _get_test_case_file_info(self, test_case_file_id):
        return self._test_case_info["test_cases"][test_case_file_id]

    def _judge_one(self, test_case_file_id):
        test_case_info = self._get_test_case_file_info(test_case_file_id)
        in_file = os.path.join(self._test_case_dir, test_case_info["input_name"])

        if self._io_mode["io_mode"] == ProblemIOMode.file:
            user_output_dir = os.path.join(self._submission_dir, str(test_case_file_id))
            os.mkdir(user_output_dir)
            os.chown(user_output_dir, RUN_USER_UID, RUN_GROUP_GID)
            os.chmod(user_output_dir, 0o711)
            os.chdir(user_output_dir)
            # todo check permission
            user_output_file = os.path.join(user_output_dir, self._io_mode["output"])
            real_user_output_file = os.path.join(user_output_dir, "stdio.txt")
            error_file = os.path.join(user_output_dir, "error_stdio.txt")
            shutil.copyfile(in_file, os.path.join(user_output_dir, self._io_mode["input"]))
            kwargs = {"input_path": in_file, "output_path": real_user_output_file, "error_path": error_file}
        else:
            real_user_output_file = user_output_file = os.path.join(self._submission_dir, test_case_file_id + ".out")
            error_file = os.path.join(self._submission_dir, "error_" + test_case_file_id + ".out")
            kwargs = {"input_path": in_file, "output_path": real_user_output_file, "error_path": error_file}


        command = self._run_config["command"].format(exe_path=self._exe_path,
                                                     input_file_path=in_file,
                                                     exe_dir=os.path.dirname(self._exe_path),
                                                     max_memory=int(self._max_memory / 1024)).split(" ")

        env = ["PATH=" + os.environ.get("PATH", "")] + self._run_config.get("env", [])

        seccomp_rule = self._run_config["seccomp_rule"]
        if isinstance(seccomp_rule, dict):
            seccomp_rule = seccomp_rule[self._io_mode["io_mode"]]

        run_result = _judger.run(max_cpu_time=self._max_cpu_time,
                                 max_real_time=self._max_real_time,
                                 max_memory=self._max_memory,
                                 max_stack=128 * 1024 * 1024,
                                 max_output_size=1024 * 1024 * 32,
                                 max_process_number=_judger.UNLIMITED,
                                 exe_path=command[0],
                                 args=command[1::],
                                 env=env,
                                 log_path=JUDGER_RUN_LOG_PATH,
                                 seccomp_rule_name=seccomp_rule,
                                 uid=RUN_USER_UID,
                                 gid=RUN_GROUP_GID,
                                 memory_limit_check_only=self._run_config.get("memory_limit_check_only", 0),
                                 **kwargs)
        run_result["test_case"] = test_case_file_id

        if self._output:
            try:
                with open(real_user_output_file, "rb") as f:
                    run_result["output"] = f.read().decode("utf-8", errors="backslashreplace")
                with open(error_file, "rb") as f:
                    run_result["error"] = f.read().decode("utf-8", errors="backslashreplace")
            except Exception:
                run_result["output"] = ""
                run_result["error"] = ""

        return run_result

    def run(self):
        tmp_results = []
        results = []
        test_case_file_ids = []
        for test_case_file_id, _ in self._test_case_info["test_cases"].items():
            test_case_file_ids.append(int(test_case_file_id))
        test_case_file_ids.sort()
        for test_case_file_id in test_case_file_ids:
            tmp_results.append(self._pool.apply_async(_run, (self, str(test_case_file_id))))
        self._pool.close()
        self._pool.join()
        for item in tmp_results:
            results.append(item.get())
        return results

    def __getstate__(self):
        # http://stackoverflow.com/questions/25382455/python-notimplementederror-pool-objects-cannot-be-passed-between-processes
        self_dict = self.__dict__.copy()
        del self_dict["_pool"]
        return self_dict
