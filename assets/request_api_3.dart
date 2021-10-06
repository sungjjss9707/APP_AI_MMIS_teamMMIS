// III. 유저별 데이터
//
// 1. 유저 회원가입, 로그인
// 1.1. 유저 회원가입(Post)
// * route : join/
// * request:
Map userJoin = {
  "name": "홍길동",
  "militaryNumber": "12-33333",
  "password": "1234",
  "rank": "일병",
  "unit": "xx사단",
  "allergy": {
    "계란류": "1",
    "우유": "1",
  }
};
// * response :
Map userJoinResponse = {
  "code": "1",
  "msg": "success",
  "data": {
    "name": "홍길동",
    "militaryNumber": "12-33333",
    "password": null,
    "rank": "일병",
    "unit": "xx사단",
    "allergy": {
      "계란류": "1",
      "우유": "1",
    }
  }
};

// 1.2. 유저 로그인(Post)
// * route : login/
// * request :
Map userLogin = {
  "militaryNumber": "12-33333",
  "password": "1234",
};
// * response : header에 유저 토큰,
// body :
Map userLoginResponse = {
  "code": "1",
  "msg": "success",
  "data": {
    "name": "홍길동",
    "militaryNumber": "12-33333",
    "password": null,
    "rank": "일병",
    "unit": "xx사단",
    "allergy": {
      "계란류": "1",
      "우유": "1",
    }
  }
};
//
// 2. 회원정보 수정
// 2.1. 유저정보 수정하기(Put)
// 2.2. * route : user/1
// *request: header에 유저 토큰,
// body :
Map UserPut = {
  "name": "홍길동",
  "militaryNumber": "12-33333",
  "password": "1240",
  "rank": "병장",
  "unit": "xx사단",
  "allergy": {
    "계란류": "1",
    "우유": "1",
  }
};

// *response:
Map userPutResponse = {
  "code": "1",
  "msg": "success",
  "data": {
    "name": "홍길동",
    "militaryNumber": "12-33333",
    "password": "1240",
    "rank": "병장",
    "unit": "xx사단",
    "allergy": {
      "계란류": "1",
      "우유": "1",
    }
  },
};
