import os
import pwd

import grp

JUDGER_WORKSPACE_BASE = "/judger/run"
LOG_BASE = "/log"

COMPILER_LOG_PATH = os.path.join(LOG_BASE, "compile.log")
JUDGER_RUN_LOG_PATH = os.path.join(LOG_BASE, "judger.log")
SERVER_LOG_PATH = os.path.join(LOG_BASE, "judge_server.log")

RUN_USER_UID = pwd.getpwnam("code").pw_uid
COMPILER_USER_UID = pwd.getpwnam("compiler").pw_uid
SPJ_USER_UID = pwd.getpwnam("spj").pw_uid

RUN_GROUP_GID = grp.getgrnam("code").gr_gid
COMPILER_GROUP_GID = grp.getgrnam("compiler").gr_gid
SPJ_GROUP_GID = grp.getgrnam("spj").gr_gid

RUN_USER_UID = 0
RUN_GROUP_GID = 0

TEST_CASE_DIR = "/test_case"
SPJ_SRC_DIR = "/judger/spj"
SPJ_EXE_DIR = "/judger/spj"
