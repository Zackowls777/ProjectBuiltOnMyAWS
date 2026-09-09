import {settings, env} from "../config";

export const backendUrlBase = settings[env].backendUrlBase;
export const frontendUrlBase = settings[env].frontendUrlBase;

export const frontendPath = {
  login: "/login",
  signup: "/sign-up",
  forgetPassword: "/forget-password",
  home: "/home",
  quant: "/quant",
  quantWithParam: "/quant?symbol={0}&start_day={1}&end_day={2}",
  channel: "/channel/{0}",
  section: "/section/{0}",
  ban: "/ban",
  problems: "/problems",
  submissions: "/submissions",
  problem: "/problem/",
  ladders: "/collections",
  quizzes: "/exams",
  quiz: "/exam/",
  quizProblem: "/exam-problem/",
  ladder: "/collection/",
  rank: "/rank",
  admin: {
    problems: '/admin/problems',
    problem: '/admin/problem/',
    users: '/admin/users',
    ladder: '/admin/ladder/',
    ladders: '/admin/ladders',
    permission: '/admin/permission'
  },
  teacher: {
    review: '/teacher/review',
    students: '/teacher/students',
    quizzesConfig: '/teacher/exams-config',
    quizScore: '/teacher/exam-score/',
    quizCheck: '/teacher/exam-check/'
  },
  account: '/account',
  payment: {
    paypal: {
      success: "/payment/paypal/success",
      cancel: "/payment/paypal/cancel",
    }
  },
};

export const backendPath = {
  user: {
    retrieveInfo: {path: "/user/retrieve", method: 'GET'},
    updateInfo: {path: "/user/update", method: 'POST'},
    signup: {path: "/user/signup", method: 'POST'},
    resetPassword: {path: "/user/reset-password", method: "POST"},
    uploadAvatar: {path: "/user/upload-avatar", method: "POST"},
    retrieveVerifyCode: {path: "/user/retrieve-verify-code", method: 'POST'},
    login: {path: "/user/login", method: 'POST'}
  },
  s3: {
    retrievePreSignedPutUrl: {path: "/s3/retrieve-pre-signed-s3-put-url", method: 'POST'},
    preSignS3Key: {path: "/s3/pre-sign-s3-key", method: 'POST'}
  },
  channel: {
    create: {path: "/channel/create", method: "POST"},
    update: {path: "/channel/update", method: "POST"},
    listChannelForCreator: {path: "/channel/list-for-creator", method: "GET"},
    listChannelByRecommendation: {path: "/channel/list-by-recommendation?page_number={0}&page_size={1}", method: "GET"},
    listChannelBySearch: {path: "/channel/list-by-search?page_number={0}&page_size={1}&search={2}", method: "GET"},
    retrieve: {path: "/channel/retrieve?channel_id={0}", method: "GET"}
  },
  channelSection: {
    listSectionForChannel: {path: "/channel-section/list-for-channel?channel_id={0}&page_number={1}&page_size={2}", method: 'GET'},
    listSectionByRecommendation: {path: "/channel-section/list-by-recommendation?page_number={0}&page_size={1}", method: "GET"},
    listSectionBySearch: {path: "/channel-section/list-by-search?page_number={0}&page_size={1}&search={2}", method: "GET"},
    create: {path: "/channel-section/create", method: "POST"},
    update: {path: "/channel-section/update", method: "POST"},
    retrieve: {path: "/channel-section/retrieve?channel_section_id={0}", method: "GET"}
  },
  order: {
    create: {path: "/order/create", method: "POST"},
    list: {path: "/order/list", method: "GET"},
    checkChannelAccessByPaidOrder: {path: "/order/check-channel-access-by-paid-order?channel_id={0}", method: 'GET'},
    cancel: {path: "/order/cancel", method: "POST"}
  },
  payment: {
    create: {path:"/payment/create", method: "POST"},
    paypal : {
      execute: {path: "/payment/paypal/execute?paymentId={0}&token={1}&PayerID={2}", method: "GET"},
      cancel: {path: "/payment/paypal/cancel?token={0}", method: "GET"},
    }
  },
  quant: {
    fetchStockData: {path: "/quant/fetch-stock-data?symbol={0}&start_day={1}&end_day={2}", method: "GET"},
    fetchSubmissionResult: {path: "/quant/fetch-submission-result?submission_id={0}", method: "GET"},
    submit: {path: "/quant/submit", method: "POST"}
  },
  problem: {
    list: {path: "/problem/list", method: "GET"},
    retrieve: {path: "/problem/retrieve/", method: "GET"},
    retrieveTestCaseInput: {path: "/problem/retrieve-test-case-input/", method: "GET"},
    collect: {path: '/problem/collect/', method: "GET"},
    achievementStatistic: {path: "/problem/achievement-statistic/", method: "GET"},
    listCollectedProblems: {path: "/problem/list-collected-problems", method: "GET"}
  },
  rank: {
    listAll: {path: "/rank/list-all", method: "GET"},
    listInternal: {path: "/rank/list-internal", method: "GET"},
  },
  language: {
    ideLanguages: {path: "/language/list/", method: "GET"},
    retrieveSolution: {path: "/language/retrieve-solution/", method: "GET"}
  },
  submission: {
    submit: {path: "/submission/submit", method: "POST"},
    runCode: {path: "/submission/run-code", method: "POST"},
    retrieveResult: {path: "/submission/retrieve-result/", method: "GET"},
    retrieveCode: {path: "/submission/retrieve-code/", method: "GET"},
    listOneProblem: {path: "/submission/list-one-problem/", method: "GET"},
    list: {path: "/submission/list", method: "GET"}
  },
  quiz: {
    list: {path: "/quiz/list", method: "GET"},
    participate: {path: "/quiz/participate", method: 'POST'},
    retrieve: {path: "/quiz/retrieve/", method: 'GET'},
    retrieveProblem: {path: '/quiz/retrieve-problem/', method: "GET"},
    submission: {
      submit: {path: "/quiz/submission/submit", method: "POST"},
      runCode: {path: "/quiz/submission/run-code", method: "POST"},
      retrieveResult: {path: "/quiz/submission/retrieve-result/", method: "GET"},
      retrieve: {path: "/quiz/submission/retrieve/", method: "GET"},
      listQuizSubmissions: {path: "/quiz/submission/list-quiz-submissions/", method: "GET"},
      listQuizProblemSubmissions: {path: "/quiz/submission/list-quiz-problem-submissions/", method: "GET"},
    }
  },
  tag: {
    list: {path: "/tag/list", method: "GET"}
  },
  company: {
    retrieve: {path: "/company/retrieve/", method: "GET"},
    list: {path: "/company/list", method: "GET"}
  },
  ladder: {
    retrieve: {path: "/collection/retrieve/", method: "GET"},
    list: {path: "/collection/list", method: "GET"}
  },
  admin: {
    permission: {
      list: {path: "/admin/permission/list", method: "GET"},
      create: {path: "/admin/permission/create", method: "POST"}
    },
    resourcePermission: {
      retrieve: {path: "/admin/resource-permissions/retrieve/", method: "GET"},
      createOrUpdate: {path: "/admin/resource-permissions/create-or-update", method: "POST"}
    },
    ladder: {
      list: {path: "/admin/ladder/list", method: "GET"},
      retrieve: {path: "/admin/ladder/retrieve/", method: "GET"},
      createOrUpdate: {path: "/admin/ladder/create-or-update", method: "POST"}
    },
    problem: {
      list: {path: "/admin/problem/list", method: "GET"},
      retrieve: {path: "/admin/problem/retrieve/", method: "GET"},
      create: {path: "/admin/problem/create", method: "POST"},
      update: {path: "/admin/problem/update", method: "POST"}
    },
    tag: {
      list: {path: "/admin/tag/list", method: "GET"},
      setTags: {path: "/admin/tag/set-tags", method: "POST"}
    },
    company: {
      list: {path: "/admin/company/list", method: "GET"},
      setCompanies: {path: "/admin/company/set-companies", method: "POST"}
    },
    language: {
      list: {path: "/admin/language/list/", method: "GET"},
      createOrUpdate: {path: "/admin/language/create", method: "GET"}
    },
    testCase: {
      list: {path: "/admin/test-case/list/", method: "GET"},
      create: {path: "/admin/test-case/create", method: "POST"},
      update: {path: "/admin/test-case/update/", method: "POST"},
      retrieve: {path: "/admin/test-case/retrieve/", method: "GET"},
    },
    user: {
      list: {path: "/admin/user/list", method: "GET"},
      add: {path: "/admin/user/add", method: "POST"},
      update: {path: "/admin/user/update", method: "POST"},
      retrievePermission: {path: "/admin/user/retrieve-permissions/", method: "GET"},
      addPermission: {path: "/admin/user/add-permission", method: "POST"},
      updatePermission: {path: "/admin/user/update-permission", method: "POST"},
      listTeachers: {path: "/admin/user/list-teachers", method: "GET"},
      retrieveAppointedTeachers: {path: "/admin/user/retrieve-appointed-teachers/", method: "GET"}
    }
  },
  teacher: {
    follow: {
      follow: {path: "/teacher/follow-user/follow", method: "POST"},
      listAllUsers: {path: "/teacher/follow-user/list-all-users", method: "GET"},
      listFollowers: {path: "/teacher/follow-user/list-followers", method: "GET"},
      checkSubmissions: {path: "/teacher/follow-user/list-submissions/", method: 'GET'},
      retrieveSubmissionCode: {path: "/teacher/follow-user/retrieve-submission-code/", method: 'GET'},
      checkQuizSubmissions: {path: "/teacher/follow-user/list-quiz-submissions/", method: 'GET'},
      retrieveQuizSubmissionCode: {path: "/teacher/follow-user/retrieve-quiz-submission-code/", method: 'GET'},
    },
    quiz: {
      list: {path: '/teacher/quiz/list', method: 'GET'},
      score: {path: '/teacher/quiz/score-quiz-submission', method: 'POST'},
      createOrUpdate: {path : '/teacher/quiz/create-or-update', method: 'POST'},
      listParticipantSubmissionsForScore: {path: '/teacher/quiz/list-participant-submissions-for-score/', method: 'GET'},
      listParticipantSubmissionsForCheck: {path: '/teacher/quiz/list-participant-submissions-for-check/', method: 'GET'},
      retrieveSubmission: {path: '/teacher/quiz/retrieve-quiz-submission/', method: 'GET'},
      listParticipants: {path: '/teacher/quiz/list-participants/', method: 'GET'},
      listProblems: {path: '/teacher/quiz/list-problems/', method: 'GET'}
    }
  }
};

export function getBackendUrl(path) {
  return backendUrlBase + path;
}

export function getFrontendUrl(path) {
  return frontendUrlBase + path;
}

export function getQueryVariable(variable)
{
       let query = window.location.search.substring(1);
       let vars = query.split("&");
       for (let i=0;i<vars.length;i++) {
               let pair = vars[i].split("=");
               if(pair[0] === variable){return decodeURI(pair[1]);}
       }
       return null;
}

export function getQueryVariableOrDefault(variable, defaultValue)
{
       const value = getQueryVariable(variable);
       if(value === null) {
         return defaultValue;
       }
       return value;
}
