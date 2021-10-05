// II. 부대 공통 데이터(ex : 제 3사단만 쓰는 데이터)
//
// 1. 부대에 있는 모든 메뉴 데이터
// 1.1. 메뉴 다 받아오기(Get)
// * route : ex) menu/
// * request : header에 관리자 토큰,
// * response :
Map GetAllMenuData = {
  "code": "1",
  "msg": "success",
  "data": [
    {
      "name": "부대찌개",
      "nutrition": {
        "칼로리": "100",
        "탄수화물": "100",
        "지방": "100",
        "단백질": "100",
        "나트륨": "100",
        "콜레스테롤": "100",
      },
      "allergy": {
        "계란류": "0",
        "우유": "0",
        "메밀": "1",
        "땅콩": "1",
        "대두": "1",
        "밀": "1",
        "고등어": "0",
        "게": "1",
        "새우": "1",
        "돼지고기": "0",
        "복숭아": "1",
        "토마토": "0",
        "아황산류": "0",
        "호두": "0",
        "닭고기": "0",
        "쇠고기": "0",
        "오징어": "0",
        "조개류": "0",
        "잣": "0",
      },
    },
    {
      "name": "김치찌개",
      "nutrition": {
        "칼로리": "100",
        "탄수화물": "100",
        "지방": "100",
        "단백질": "100",
        "나트륨": "100",
        "콜레스테롤": "100",
      },
      "allergy": {
        "계란류": "0",
        "우유": "0",
        "메밀": "1",
        "땅콩": "1",
        "대두": "1",
        "밀": "1",
        "고등어": "0",
        "게": "1",
        "새우": "1",
        "돼지고기": "0",
        "복숭아": "1",
        "토마토": "0",
        "아황산류": "0",
        "호두": "0",
        "닭고기": "0",
        "쇠고기": "0",
        "오징어": "0",
        "조개류": "0",
        "잣": "0",
      },
    },
    // .......
  ]
};

// 1.2. 메뉴 정보 1개 받아오기(Get)
// * route : ex) menu/부대찌개 or menu/1
// * request : header에 유저 토큰 혹은 관리자 토큰,
// * response :
Map menuData = {
  "code": "1",
  "msg": "success",
  "data": {
    "name": "부대찌개",
    "nutrition": {
      "칼로리": "100",
      "탄수화물": "100",
      "지방": "100",
      "단백질": "100",
      "나트륨": "100",
      "콜레스테롤": "100",
    },
    "allergy": {
      "계란류": "0",
      "우유": "0",
      "메밀": "1",
      "땅콩": "1",
      "대두": "1",
      "밀": "1",
      "고등어": "0",
      "게": "1",
      "새우": "1",
      "돼지고기": "0",
      "복숭아": "1",
      "토마토": "0",
      "아황산류": "0",
      "호두": "0",
      "닭고기": "0",
      "쇠고기": "0",
      "오징어": "0",
      "조개류": "0",
      "잣": "0",
    },
  }
};

// 1.3. 메뉴 정보 추가하기(Post)
// * route : ex) menu/
// * request : header에 관리자 토큰, body에 이름, 영양정보, 알레르기
Map menuRequest = {
  "name": "김치찌개",
  "nutrition": {
    "칼로리": "100",
    "탄수화물": "100",
    "지방": "100",
    "단백질": "100",
    "나트륨": "100",
    "콜레스테롤": "100",
  },
  "allergy": {
    "계란류": "0",
    "우유": "0",
    "메밀": "1",
    "땅콩": "1",
    "대두": "1",
    "밀": "1",
    "고등어": "0",
    "게": "1",
    "새우": "1",
    "돼지고기": "0",
    "복숭아": "1",
    "토마토": "0",
    "아황산류": "0",
    "호두": "0",
    "닭고기": "0",
    "쇠고기": "0",
    "오징어": "0",
    "조개류": "0",
    "잣": "0",
  },
};
// * request :
Map menuDataResponse = {
  "code": "1",
  "msg": "success",
  "data": {
    "name": "김치찌개",
    "nutrition": {
      "칼로리": "100",
      "탄수화물": "100",
      "지방": "100",
      "단백질": "100",
      "나트륨": "100",
      "콜레스테롤": "100",
    },
    "allergy": {
      "계란류": "0",
      "우유": "0",
      "메밀": "1",
      "땅콩": "1",
      "대두": "1",
      "밀": "1",
      "고등어": "0",
      "게": "1",
      "새우": "1",
      "돼지고기": "0",
      "복숭아": "1",
      "토마토": "0",
      "아황산류": "0",
      "호두": "0",
      "닭고기": "0",
      "쇠고기": "0",
      "오징어": "0",
      "조개류": "0",
      "잣": "0",
    },
  }
};

// 2. 관리자 로그인, 회원가입
// 2.1. 관리자 회원가입(Post)
// * route : ex) join/
// * request :
Map adminJoin = {
  "id": "1",
  "name": "관리자",
  "militaryNumber": "12-33333",
  "password": "1234",
  "rank": "7급",
  "unit": "xx사단",
};
// * response : adminData
Map adminData = {
  "code": "1",
  "msg": "success",
  "data": {
    "id": "1",
    "name": "관리자",
    "militaryNumber": "12-33333",
    "password": null,
    "rank": "7급",
    "unit": "xx사단",
    "create": "2021-07-10T08:05:49.068049",
    "update": "2021-07-10T08:05:49.068049",
  }
};

// 2.2. 관리자 로그인(Post)군번을 입력, 비밀번호를 입력해서, 회원가입
// * route : ex) login/
// * request :
Map adminLogin = {
  "militaryNumber": "12-33333",
  "password": "1234",
};

// * response : header에 관리자토큰,
// body :
Map adminDataLogin = {
  "code": "1",
  "msg": "success",
  "data": {
    "id": "1",
    "name": "관리자",
    "militaryNumber": "12-33333",
    "password": null,
    "rank": "7급",
    "unit": "xx사단",
    "create": "2021-07-10T08:05:49.068049",
    "update": "2021-07-10T08:05:49.068049",
  }
};

// 3. 메뉴 관리
// 3.1. 식단 입력(Post)
// * route : ex) diet/
// * request : header에 관리자 토큰,
Map PostDiet = {
  "year": "2021",
  "month": "09",
  "day": "11",
  "time": "석식",
  "menus": [
    "김찌찌개",
    "밥",
  ],
};

// * response :
Map DietResponse = {
  "code": "1",
  "msg": "success",
  "data": {
    "id": "2",
    "menus": [
      {
        "name": "부대찌개",
        "nutrition": {
          "칼로리": "100",
          "탄수화물": "100",
          "지방": "100",
          "단백질": "100",
          "나트륨": "100",
          "콜레스테롤": "100",
        },
        //알레르기는 19종류 다 반영되어야 됨. 가독성 좋기 위해 몇 개만 썼음.
        "알레르기": {
          "계란류": "1",
          "우유": "1",
        },
      },
      {
        "id": "2",
        "name": "밥",
        "nutrition": {
          "칼로리": "100",
          "탄수화물": "100",
          "지방": "100",
          "단백질": "100",
          "나트륨": "100",
          "콜레스테롤": "100",
        },
        "allergy": {"계란류": "1", "우유": "1"},
      },
    ],
    "create": "2021-07-10T08:05:49.068049",
    "update": "2021-07-10T08:05:49.068049",
  },
};

// 3.2. 메뉴 수정(Put)
// * route : ex) diet/2021/3/14/석식
// * request :  header에 관리자 토큰,
// body :
Map putDiet = {
  "menus": [
    "김찌찌개",
    "찰밥",
  ],
};

// * response :
Map DietPutResponse = {
  "code": "1",
  "msg": "success",
  "data": {
    "id": "2",
    "menus": [
      {
        "name": "부대찌개",
        "nutrition": {
          "칼로리": "100",
          "탄수화물": "100",
          "지방": "100",
          "단백질": "100",
          "나트륨": "100",
          "콜레스테롤": "100",
        },
        //알레르기는 19종류 다 반영되어야 됨. 가독성 좋기 위해 몇 개만 썼음.
        "알레르기": {
          "계란류": "1",
          "우유": "1",
        },
      },
      {
        "id": "2",
        "name": "밥",
        "nutrition": {
          "칼로리": "100",
          "탄수화물": "100",
          "지방": "100",
          "단백질": "100",
          "나트륨": "100",
          "콜레스테롤": "100",
        },
        "allergy": {"계란류": "1", "우유": "1"},
      },
    ],
    "create": "2021-07-10T08:05:49.068049",
    "update": "2021-07-10T08:05:49.068049",
  },
};

// 3.3. 한 달 전체 메뉴 정보 가져오기(Get)
// * route : ex) diet/2021/3/
// * request : header에 관리자 토큰
// * response : 그 달에 있는 dietData의 collection(계층이 있게)
// 너무 길어져서 굳이 예시를 하지는 않겠습니다.

// 3.4. 하루 전체 메뉴 정보 가져오기(Get)
// * route : ex) diet/2021/3/14/
// * request : header에 관리자 토큰
// * response :그 날에 있는 dietData의 collection
// 너무 길어져서 굳이 예시를 하지는 않겠습니다.

// 3.5. 하루 시간 때의 메뉴 정보 가져오기(Get)
// * route : ex) diet/2021/3/14/석식
// * request : header에 관리자 토큰
// * response : dietData
// 너무 길어져서 굳이 예시를 하지는 않겠습니다.

// 4. 식수 인원 관리
// 4.1. 식수 인원 데이터 가져오기(Get)
// * route : noteating/2021/3/14/조식
// * request : header에 관리자 토큰
// * response :
Map numOfPeople = {
  "code": "1",
  "msg": "success",
  "data": {
    "id": "3",
    // 총인원은 default 값으로 100명 있으면 좋겠음.
    "totalNumberOfPeople": "100",
    "reason": {
      // 각 리스트에 불취식 신청한 사람들이 담김.
      "당직": [],
      "휴가": [
        {
          "id": "1",
          "name": "홍길동",
          "militaryNumber": "12-33333",
          "password": null,
          "rank": "이병",
          "unit": "xx사단",
          "allergy": {"계란류": "1", "우유": "1"},
          "create": "2021-07-10T08:05:49.068049",
          "update": "2021-07-10T08:05:49.068049",
        },
      ],
      "외출": [],
      "근무": [],
      "기타": [],
    },
  },
};

// 4.2. 총인원 수정하기(Put)
// * route : noteating/2021/3/14/조식
// * request : header에 관리자 토큰,
// body:
Map changeTotal = {
  "totalNumberOfPeople": "40",
};
// * response :
Map numOfPeopleChange = {
  "code": "1",
  "msg": "success",
  "data": {
    "id": "3",
    "totalNumberOfPeople": "40",
    "reason": {
      "당직": [],
      "휴가": [
        {
          "id": "1",
          "name": "홍길동",
          "militaryNumber": "12-33333",
          "password": null,
          "rank": "이병",
          "unit": "xx사단",
          "allergy": {"계란류": "1", "우유": "1"},
          "create": "2021-07-10T08:05:49.068049",
          "update": "2021-07-10T08:05:49.068049",
        },
      ],
      "외출": [],
      "근무": [],
      "기타": [],
    },
  },
};

// 4.3. 불취식 신청하기(Post)유저정보를 불취식 신청-사유 리스트에 저장합니다.
// * route : noteating/2021/3/14/조식
// * request : header에 유저토큰,
// * response :
Map SubmitNotEating = {
  "code": "1",
  "msg": "success",
  "data": {
    "id": "3",
    "totalNumberOfPeople": "40",
    "reason": {
      "당직": [],
      "휴가": [
        {
          "id": "1",
          "name": "홍길동",
          "militaryNumber": "12-33333",
          "password": null,
          "rank": "이병",
          "unit": "xx사단",
          "allergy": {"계란류": "1", "우유": "1"},
          "create": "2021-07-10T08:05:49.068049",
          "update": "2021-07-10T08:05:49.068049",
        },
        {
          "id": "1",
          "name": "고영희",
          "militaryNumber": "12-33333",
          "password": null,
          "rank": "병장",
          "unit": "xx사단",
          "allergy": {"계란류": "0", "우유": "1"},
          "create": "2021-07-10T08:05:49.068049",
          "update": "2021-07-10T08:05:49.068049",
        },
      ],
      "외출": [],
      "근무": [],
      "기타": [],
    },
  },
};

// 4.4. 불취식 신청 취소하기(Delete)
// * route : noteating/2021/3/14/조식/reason
// * request : header에 유저 토큰,
//body :
Map requestCancel = {
  "reason": "당직",
};

// * response :
Map CancelNotEating = {
  "code": "1",
  "msg": "success",
  "data": {
    "id": "3",
    "totalNumberOfPeople": "40",
    "reason": {
      "당직": [],
      "휴가": [
        {
          "id": "1",
          "name": "고영희",
          "militaryNumber": "12-33333",
          "password": null,
          "rank": "병장",
          "unit": "xx사단",
          "allergy": {"계란류": "0", "우유": "1"},
          "create": "2021-07-10T08:05:49.068049",
          "update": "2021-07-10T08:05:49.068049",
        },
      ],
      "외출": [],
      "근무": [],
      "기타": [],
    },
  },
};

// 5. 공지사항
// 5.1. 게시글 작성(Post)
// * route : notice/
// * request : header에 관리자 토큰,
// body :
Map NoticePost = {
  "title": "글제목",
  "content": "글내용",
};
// * response : notice(방금 올린 것)

// 5.2. 게시글 전체 목록보기(Get)사용자 또는 관리자가 게시글 목록을 불러옵니다.
// * route : notice/
// * request : header에 유저 토큰, 혹은 관리자 토큰
// * response : notice들의 collection
// 5.3. 게시글 1개 보기(Get)사용자 또는 관리자가 게시글 목록을 불러옵니다. * route : notice/1/* request : header에 유저 토큰, 혹은 관리자 토큰* response : notice
// 5.4. 게시글 수정(Put)관리자가 게시글을 수정합니다. * route : notice/1/* request : header에 관리자 토큰,body에 제목(title), 내용(content)* response : notice(수정된 데이터)
// 5.5. 게시글 삭제 관리자가 게시글을 삭제합니다. * route : notice/1/* request : header에 관리자 토큰* response : -
//
// 6.  건의사항
// 공지사항과 다르게 관리자가 답변을 달 수 있습니다.
// 6.1. 게시글 작성(Post)사용자가 새로운 게시글을 올립니다. * route : suggestion/* request : header에 사용자 토큰, body에 제목(title), 내용(content)* response : suggestion
// 6.2. 게시글 전체 목록보기(Get)사용자 또는 관리자가 게시글 목록을 불러옵니다.* route : suggestion/* request : header에 유저 토큰, 혹은 관리자 토큰* response : suggestion의 collection
// 6.3. 게시글 1개 보기(Get)사용자 또는 관리자가 게시글 목록을 불러옵니다. * route : suggestion/1* request : header에 유저 토큰, 혹은 관리자 토큰* response : suggestion
// 6.4. 게시글 수정(Post)사용자가 게시글을 수정합니다. * request : header에 사용자 토큰, body에 제목, 내용 * response : 생성시간, 업데이트 시간
// 6.5. 게시글에 댓글 달기(Post)관리자가 댓글을 답니다.* route : suggestion/comment* request : header에 관리자 토큰, body에 내용 (content)* response :  comment(suggestion 안에 데이터 형식 있음)
// 6.6. 답변 수정하기(Put)* route : suggestion/comment/1* request : header에 관리자 토큰, body에 내용 (content)* response : comment(suggestion 안에 데이터 형식 있음)
// 6.7. 게시글 삭제(Delete)* route : suggestion/1* request : header에 유저 혹은 관리자 토큰,* response : -
// 6.8. 답변 삭제(Delete)* route : suggestion/comment/1* request : header에 관리자 토큰,* response : -
// 7. 설문조사
// 설문조사는 설문조사 제목, 설문조사 설명, 질문으로 이루어져 있으며, 질문은 질문제목, 질문타입(객관식(1개 고름), 객관식(다수 고를 수 있음), 주관식), 객관식의 경우 선지, 질문 필수 여부(반드시 응답해야 되는지)로 이루어져 있습니다.
//
// 7.1. 설문조사 생성(Post)관리자가 설문조사를 생성합니다. * route : survey/* request : header에 관리자 토큰, body에 설문조사 제목(title), 설문조사 설명(explain), 설문조사 질문들(questions)* response : survey
// 7.2. 설문조사 전체 불러오기(Get)생성된 전체 설문조사를 불러옵니다. * route : survey/* request : header에 관리자 토큰* response : survey의 collection
// 7.3. 설문조사 1개 불러오기(Get)* route : survey/1/* request : header에 관리자 토큰* response : 설문조사 제목, 설문조사 질문, 설문조사 응답
// 7.4. 설문조사 제출하기(Put)* route : survey/1/result
// 	* request : header에 유저 토큰, body에 설문조사 응답결과(result)	* response : 제출 시간
// 7.5. 설문조사 삭제(Delete)관리자가 생성한 설문조사를 삭제합니다. * route : survey/1/* request : header에 관리자 토큰* response : -
