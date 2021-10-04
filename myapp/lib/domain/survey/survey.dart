class RealSurvey {
  String? id;
  String? title;
  String? explain;
  List<Map<String, dynamic>>? questions;
  String? createTime;
  RealSurvey(
      {this.id, this.title, this.explain, this.questions, this.createTime});

  RealSurvey.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        title = json["title"],
        explain = json["explain"],
        questions = json["questions"],
        createTime = json["create"];
}

Map<String, dynamic> DumSurvey = {
  "id": "1",
  "title": "설문제목입니다.",
  "explain": "설문설명입니다",
  "questions": [
    {
      "id": "1",
      "text": "예시 질문입니다.",
      "type": "객관식",
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
      // 선지입니다.
      "options": [],
    },
    {
      "id": "4",
      "text": "예시 질문입니다.",
      "type": "장문형",
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
