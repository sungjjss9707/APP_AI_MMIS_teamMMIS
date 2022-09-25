import 'package:intl/intl.dart';

class AI {
  final int? score;
  final List<Map<String, dynamic>>? recommendation;

  AI({this.score, this.recommendation});

  AI.fromJson(Map<String, dynamic> json)
      : score = json["score"],
        recommendation = json["recommendation"];

  List<Recommendation> getRecommendation() {
    List<Recommendation> result = [];
    if (recommendation != null) {
      for (Map<String, dynamic> o in recommendation!) {
        result.add(
          Recommendation(score: o["score"], menus: o["menus"]),
        );
      }
    }
    return result;
  }
}

class Recommendation {
  final int? score;
  final List<String>? menus;

  Recommendation({this.score, this.menus});
}

Map<String, dynamic> a = {
  "code": 1,
  "msg": "success",
  "data": {
    "score": 80,
    "recommendation": [
      {
        "score": 5,
        "menus": ["보리밥", "열무김치", "뚝배기", "떡볶이", "우유", "빵", "치즈"]
      },
      {
        "score": 5,
        "menus": ["콩밥", "열무김치", "돼지김치찜"]
      },
      {
        "score": 4,
        "menus": ["보리밥", "열무김치", "돼지불백"]
      },
    ]
  }
};
