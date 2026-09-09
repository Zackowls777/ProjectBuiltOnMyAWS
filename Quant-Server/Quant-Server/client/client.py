import hashlib
import json

import requests


default_env = ["LANG=en_US.UTF-8", "LANGUAGE=en_US:en", "LC_ALL=en_US.UTF-8"]
py3_lang_config = {
    "compile": {
        "src_name": "solution.py",
        "exe_name": "__pycache__/solution.cpython-36.pyc",
        "max_cpu_time": 1000 * 30,
        "max_real_time": 5000,
        "max_memory": 512 * 1024 * 1024,
        "compile_command": "/usr/bin/python3 -m py_compile {src_path}",
    },
    "run": {
        "command": "/usr/bin/python3 {exe_path} {input_file_path}",
        "seccomp_rule": None, # "general"
        "env": ["PYTHONIOENCODING=UTF-8"] + default_env
    }
}

class JudgeServerClientError(Exception):
    pass


class JudgeServerClient(object):
    def __init__(self, token, server_base_url):
        self.token = hashlib.sha256(token.encode("utf-8")).hexdigest()
        self.server_base_url = server_base_url.rstrip("/")

    def _request(self, url, data=None):
        kwargs = {"headers": {"X-Judge-Server-Token": self.token,
                              "Content-Type": "application/json"}}
        if data:
            kwargs["data"] = json.dumps(data)
        try:
            response = requests.post(url, **kwargs)
            print(response)
            return response.json()
        except Exception as e:
            print(e)
            raise JudgeServerClientError(str(e))

    def ping(self):
        return self._request(self.server_base_url + "/ping")

    def judge(self, src, language_config, max_cpu_time, max_memory, test_cases=None, output=False):


        data = {
            "language_config": language_config,
            "src": src,
            "max_cpu_time": max_cpu_time,
            "max_memory": max_memory,
            "test_cases": test_cases,
            "output": output
        }
        return self._request(self.server_base_url + "/judge", data=data)

    def fetch_stock_daily_data_as_s3_csv_key(self, symbol, start_day, end_day):
        data = {
            "symbol": symbol,
            "start_day": start_day,
            "end_day": end_day
        }
        return self._request(self.server_base_url + "/fetch_stock_daily_data_as_s3_csv_key", data=data)


if __name__ == "__main__":
    token = "REPLACE_WITH_TOKEN"



    client = JudgeServerClient(token=token, server_base_url="http://47.115.230.116:8080")

    print("ping")
    print(client.ping(), "\n\n")

    # print("fetch_stock_daily_data_as_s3_csv_key")
    # print(client.fetch_stock_daily_data_as_s3_csv_key(symbol='QQQ', start_day='2023-1-1', end_day='2024-12-31'), "\n\n")

    print("judge")
    import uuid
    submission_id = str(uuid.uuid4())

    py3_src = """
import numpy
import pandas
import os
import sys

if __name__ == "__main__":
    df = pandas.read_csv(sys.argv[1])
    print(df.head())

"""

#     py3_src = '''
# import numpy as np
#
# from sklearn import linear_model
# from sklearn.metrics import mean_squared_error, r2_score
#
# x = np.linspace(0,10,50) # 0到10等间隔产生50个数
# b = 1
# noise = np.random.uniform(-2, 2, size=50)
# y= 5*x + b + noise
#
# lr = linear_model.LinearRegression()
#
#
# lr.fit(np.reshape(x,(-1,1)),np.reshape(y,(-1,1)))
#
# y_pred =lr.predict(np.reshape(x,(-1,1)))
#
# print("Mean squared error: %.2f" % mean_squared_error(np.reshape(y,(-1,1)), y_pred))
# print("Coefficient of determination: %.2f" % r2_score(np.reshape(y,(-1,1)), y_pred))
# print("Coefficients: ", lr.coef_)
# print("Intercept: ", lr.intercept_)
#
# '''

    test_cases = [{'input': 'csv/33afa619-f099-4974-8a74-6d6f4dc0a306.csv'}]

    res = client.judge(src=py3_src, language_config=py3_lang_config,
                       max_cpu_time=30 * 1000, max_memory=1024 * 1024 * 1024,
                       test_cases=test_cases, output=True)

    print(res)
