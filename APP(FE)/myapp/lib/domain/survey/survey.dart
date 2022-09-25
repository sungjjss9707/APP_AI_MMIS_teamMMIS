class Survey {
  String? id;
  String? title;
  String? explain;
  List<Map<String, dynamic>>? questions;
  String? createTime;
  Survey({this.id, this.title, this.explain, this.questions, this.createTime});

  Survey.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        title = json["title"],
        explain = json["explain"],
        questions = json["questions"],
        createTime = json["create"];
}

Map<String, dynamic> DumSurvey = {
  "id": "1",
  "title": "21-3차 급식 만족도조사입니다.",
  "explain": "성의껏 답변 부탁드립니다.",
  "questions": [
    {
      "id": "1",
      "text": "전반적인 급식 만족도는 어떻습니까?",
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
      "text": "다음 메뉴 중 선호하는 메뉴를 골라주세요",
      "type": "다수선택",
      "isOptional": "no",
      // 선지입니다.
      "options": [
        "김치찌개",
        "닭도리탕",
        "볶음밥",
        "김치전",
        "떡갈비",
      ],
    },
    {
      "id": "3",
      "text": "그 외 건의사항을 써주세요!",
      "type": "단답식",
      "isOptional": "no",
      // 선지입니다.
      "options": [],
    },
    {
      "id": "4",
      "text": "예시 질문입니다.",
      "type": "단답식",
      "isOptional": "yes",
      // 선지입니다.
      "options": [],
    },
  ],
  //questions의 객체의 개수만큼 빈 리스트를 객체로 생성..
  // 못 하시겠으면, 프론트에서도 처리 가능..
  "result": [
    [],
    [],
    [],
    [],
  ],
  "create": "2021-07-10T08:05:49.068049",
  "update": "2021-07-10T08:05:49.068049",
};
