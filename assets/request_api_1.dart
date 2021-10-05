// I. 전체 군 공통 데이터
//
// 1. 전 부대에 있는 모든 메뉴 데이터
// 1.1. 메뉴 정보 1개 받아오기(Get)
// * request : headers에 유저 토큰 혹은 관리자 토큰,
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

// 1.2. 메뉴 정보 추가하기(Post)
// * route : ex) menu/
// * request : header에 관리자 토큰,
// body에
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
// * response :
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

// 2. 우리 부대 급식 자랑
// 2.1. 부대 급식 자랑
// * route : ex) photo/
// * request : header에 유저토큰
// * response : photoData 중 최근에 등록된 30개의 리스트
Map photoDatas = {
  "code": "1",
  "msg": "success",
  "data": [
    {
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
      "comment": [
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
    },
    {
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
      "comment": [
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
    },
    // ......
  ],
};
// 2.2. 사진이랑 정보 1세트 가져오기(Get)
// * route : ex) photo/1
// * request : header에 유저토큰
// * response :
Map photoData = {
  "code": "1",
  "msg": "success",
  "data": {
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
    "comment": [
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
  },
};

// 2.3. 사진 게시하기(Post).
// * route : ex) photo/1
// * request : header에 유저토큰
// body :
Map PhotoPostData = {
  "photo": ".....jpg",
};

// 	* response : photoData
Map PhotoPostDataResponse = {
  "code": "1",
  "msg": "success",
  "data": {
    "id": "4",
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
    "comment": [],
    "create": "2021-07-10T08:05:49.068049",
    "update": "2021-07-10T08:05:49.068049",
  },
};

// 2.4. 사진 삭제하기(Delete)* route : ex) photo/1
// * request : header에 유저토큰 혹은 관리자 토큰
// 	* response :
Map deletePhoto = {
  "code": 1,
  "msg": "삭제하기완료",
  "data": null,
};

// 2.5. 댓글 달기(Post) route : ex) photo/1/comments
// * request : header에 유저토큰 혹은 관리자 토큰
// 	* response :
Map addCommentData = {
  "code": "1",
  "msg": "success",
  "data": {
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
    "comment": [
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
  },
};
