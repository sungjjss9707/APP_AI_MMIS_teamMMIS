// 메뉴 데이터 ex) 부대찌개에 대한 데이터 형식
Map menuData = {
  // name을 id처럼 써도 상관없을 거 같습니다.
  "id": "1",
  "name": "부대찌개",
  "nutrition": {
    "칼로리": "100",
    "탄수화물": "100",
    "지방": "100",
    "단백질": "100",
    "나트륨": "100",
    "콜레스테롤": "100",
  },
  // 메뉴에 다음 알레르기성분이 포함이면, 1 아니면, 0 총 19종류
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

// 사용자 정보
Map userData = {
  "id": "1",
  "name": "홍길동",
  "militaryNumber": "12-33333",
  "password": null,
  "rank": "이병",
  "unit": "xx사단",
  "allergy": {
    "계란류": "1",
    "우유": "1",
  },
  "create": "2021-07-10T08:05:49.068049",
  "update": "2021-07-10T08:05:49.068049",
};

//관리자 정보
Map adminData = {
  "id": "1",
  "name": "관리자",
  "militaryNumber": "12-33333",
  "password": null,
  "rank": "7급",
  "unit": "xx사단",
  "create": "2021-07-10T08:05:49.068049",
  "update": "2021-07-10T08:05:49.068049",
};

//우리 부대 급식 자랑 정보
Map photoData = {
  "id": "1",
  "photo": "....jpg", //  여기 이미지 저장..
  "unit": "xx사단",
  "like": "0",
  "content": "내용",
  "writer": {
    "id": "1",
    "name": "홍길동",
    "militaryNumber": "12-33333",
    "password": null,
    "rank": "이병",
    "unit": "xx사단",
    "allergy": {
      "계란류": "1",
      "우유": "1",
    },
    "create": "2021-07-10T08:05:49.068049",
    "update": "2021-07-10T08:05:49.068049",
  },
  "comments": [
    {
      "content": "댓글 내용입니다.",
      //댓글 게시자
      "writer": {
        "id": "1",
        "name": "김경수",
        "militaryNumber": "12-33333",
        "password": null,
        "rank": "소위",
        "unit": "xx사단",
        "allergy": {"계란류": "1", "우유": "1"},
        "create": "2021-07-10T08:05:49.068049",
        "update": "2021-07-10T08:05:49.068049",
      },
    },
  ],
  "create": "2021-07-10T08:05:49.068049",
  "update": "2021-07-10T08:05:49.068049",
};

// 한끼 식단, 예를 들어 2021년 3월 7일 석식에 대한 식단을 나타냅니다.
//그리고 2021년 3월 19일 석식에 대한 데이터를 불러올 때,
//   /2021/03/19/석식/ 이런 식으로 얻을 수 있으면 편할 수 있을 거 같습니다.
Map dietData = {
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
      "allergy": {
        "계란류": "1",
        "우유": "1",
      },
    },
    {
      "id": "3",
      "name": "떡갈비",
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
};

//공지사항 데이터
Map notice = {
  "id": "3",
  "title": "제목입니다.",
  "content": "내용입니다.",
  "writer": {
    "id": "1",
    "name": "관리자",
    "militaryNumber": "12-33333",
    "password": null,
    "rank": "7급",
    "unit": "xx사단",
    "create": "2021-07-10T08:05:49.068049",
    "update": "2021-07-10T08:05:49.068049",
  },
  "create": "2021-07-10T08:05:49.068049",
  "update": "2021-07-10T08:05:49.068049",
};

//건의사항 데이터
Map suggestion = {
  "id": "3",
  "title": "제목입니다.",
  "content": "내용입니다.",
  //건의사항 게시자
  "writer": {
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
  //댓글입니다. 리스트로 해서, 여러 댓글을 담으면 됩니다.
  "comments": [
    {
      "content": "댓글 내용입니다.",
      //댓글 게시자
      "writer": {
        "id": "1",
        "name": "김경수",
        "militaryNumber": "12-33333",
        "password": null,
        "rank": "소위",
        "unit": "xx사단",
        "allergy": {"계란류": "1", "우유": "1"},
        "create": "2021-07-10T08:05:49.068049",
        "update": "2021-07-10T08:05:49.068049",
      },
    },
  ],
  "create": "2021-07-10T08:05:49.068049",
  "update": "2021-07-10T08:05:49.068049",
};

//설문조사
Map survey = {
  "id": "1",
  "title": "설문제목입니다.",
  "explain": "설문설명입니다",
  "questions": [
    {
      "id": "1",
      "text": "예시 질문입니다.",
      "type": "객관식",
      "isOptional": "yes",
      // 선지입니다.
      "options": [
        "매우 좋음",
        "좋음",
        "보통",
        "별로",
        "아주 별로",
      ],
    },
    {
      "id": "2",
      "text": "예시 질문입니다.",
      "type": "다수선택",
      "isOptional": "yes",
      // 선지입니다.
      "options": [
        "매우 좋음",
        "좋음",
        "보통",
        "별로",
        "아주 별로",
      ],
    },
    {
      "id": "3",
      "text": "예시 질문입니다.",
      "type": "단답식",
      "isOptional": "yes",
      // 선지입니다.
      "options": [],
    },
    {
      "id": "4",
      "text": "예시 질문입니다.",
      "type": "객관식",
      "isOptional": "no",
      // 선지입니다.
      "options": [],
    },
  ],
  "result": [
    [
      {
        "id": "1",
        "type": "객관식",
        "answer": [
          "매우좋음",
        ],
      },
      {
        "id": "2",
        "type": "다수선택",
        "answer": [
          "매우좋음",
          "좋음",
        ],
      },
      {
        "id": "3",
        "type": "객관식",
        "answer": [
          "3",
        ],
      },
      {
        "id": "4",
        "type": "단답형",
        "answer": [
          "단답형 답입니다.",
        ],
      }
    ],
  ],
  "create": "2021-07-10T08:05:49.068049",
  "update": "2021-07-10T08:05:49.068049",
};

// 식수 인원 관리
// 2021년 3월 19일 식수인원 관리에 대한 데이터를 불러올 때,
//  /2021/03/19/석식/ 이런 식으로 얻을 수 있으면 편할 수 있을 거 같습니다.
Map notEating = {
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
};