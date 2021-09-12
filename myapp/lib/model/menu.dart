class Menu {
  final String date;
  final String time;
  final List<String> menuPlate;
  final List<double> rating;

  Menu(this.date, this.time, this.menuPlate, this.rating);
}

Menu getMenuByDateAndTime(String date, String time, List<Menu> menu) {
  return menu
      .firstWhere((element) => element.date == date && element.time == time);
}

int getMenuIndexByDateAndTime(String date, String time, List<Menu> menu) {
  Menu menuElement = getMenuByDateAndTime(date, time, menu);
  return menu.indexOf(menuElement);
}

List<Menu> dummyMenu = [
  Menu(
    "2021-09-06",
    "석식",
    [
      "밥",
      "김치",
      "오징어 제육볶음",
      "맛김",
      "오이무침",
      "미역국",
    ],
    [0, 0, 0, 0, 0, 0],
  ),
  Menu(
    "2021-09-07",
    "석식",
    [
      "차조밥",
      "열무김치",
      "버섯제육볶음",
      "맛김",
      "오뎅국",
      "김치",
      "우유",
      "초콜릿",
      "버섯",
    ],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
  ),
  Menu(
    "2021-09-08",
    "석식",
    [
      "밥",
      "오이소박이",
      "소고기볶음",
      "비엔나 소세지 볶음",
      "오이무침",
      "북엇국",
    ],
    [0, 0, 0, 0, 0, 0],
  ),
  Menu(
    "2021-09-09",
    "중식",
    [
      "불고기 버거",
      "감자튀김",
      "시리얼",
    ],
    [0, 0, 0],
  ),
  Menu(
    "2021-09-10",
    "브런치",
    [
      "메밀국수",
      "김치",
      "떡갈비",
      "음료",
      "야채 샐러드",
      "마카롱",
    ],
    [0, 0, 0, 0, 0, 0],
  ),
  Menu(
    "2021-09-11",
    "브런치",
    [
      "메밀국수",
      "김치",
      "떡갈비",
      "음료",
      "야채 샐러드",
      "마카롱",
    ],
    [0, 0, 0, 0, 0, 0],
  ),
  Menu(
    "2021-09-11",
    "중식",
    [
      "메밀국수",
      "김치",
      "떡갈비",
      "음료",
      "야채 샐러드",
      "마카롱",
    ],
    [0, 0, 0, 0, 0, 0],
  )
];
