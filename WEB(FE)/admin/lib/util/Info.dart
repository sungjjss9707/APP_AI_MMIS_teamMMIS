class Rank {
  static final List<String> ranks = [
    "대장",
    "중장",
    "소장",
    "준장",
    "대령",
    "중령",
    "소령",
    "대위",
    "중위",
    "소위",
    "준위",
    "원사",
    "상사",
    "중사",
    "하사",
    "군무원 1급",
    "군무원 2급",
    "군무원 3급",
    "군무원 4급",
    "군무원 5급",
    "군무원 6급",
    "군무원 7급",
    "군무원 8급",
    "군무원 9급",
    "군무원 10급",
    "공무원 1급",
    "공무원 1급",
    "공무원 2급",
    "공무원 3급",
    "공무원 4급",
    "공무원 5급",
    "공무원 6급",
    "공무원 7급",
    "공무원 8급",
    "공무원 9급",
    "공무원 10급",
  ];

  static List<String> getSuggestions(String query) {
    List<String> matches = <String>[];
    matches.addAll(ranks);
    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }
}

class MilitaryUnit {
  static final List<String> units = [
    '공군 제xx전투비행단',
    '육군 제**사단',
    '육군 제**사단',
    '육군 제**사단',
    '육군 제**사단',
    '육군 1xx연대',
    '해병대 xx부대',
    '국방부 ??정책과',
    '국방부 xx정책과',
    '공군 제a전투비행단',
    '공군 제b전투비행단',
    '공군 제c전투비행단',
    '공군 제d전투비행단',
    '공군 제e전투비행단',
  ];

  static List<String> getSuggestions(String query) {
    List<String> matches = <String>[];
    matches.addAll(units);
    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }
}

class Menus {
  static List<String> menus = [
    '쌀밥',
    '콩밥',
    '김치찌개',
    '부대찌개',
    '계란말이',
    '삼겹살구이',
    '배추김치',
    '배추 된장국',
    '콩자반',
    '돼지불고기',
    '김치볶음',
    '닭죽',
    '닭갈비',
    '비엔나소세지볶음',
  ];

  static List<String> getSuggestions(String query) {
    List<String> matches = <String>[];
    matches.addAll(menus);
    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }
}

List<String> nutritionName = [
  "칼로리(Kcal)",
  "탄수화물(g)",
  "지방(g)",
  "단백질(g)",
  "나트륨(mg)",
  "콜레스테롤(mg)",
];
List<String> nutritionNameWithOutScale = [
  "칼로리",
  "탄수화물",
  "지방",
  "단백질",
  "나트륨",
  "콜레스테롤",
];

List<String> allergyName = [
  "계란류",
  "우유",
  "메밀",
  "땅콩",
  "대두",
  "밀",
  "고등어",
  "게",
  "새우",
  "돼지고기",
  "복숭아",
  "토마토",
  "아황산류",
  "호두",
  "닭고기",
  "쇠고기",
  "오징어",
  "조개류",
  "잣"
];
