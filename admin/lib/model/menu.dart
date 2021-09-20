Map<String, Map<String, Map<String, Map<String, List<String>>>>>
    dummyMenuSchedule = {
  "2021": {
    "9": {
      "20": {
        "조식": ["쌀밥, 김치"],
        "중식": ["라면", "김치"]
      }
    }
  }
};

void addMenu(DateTime date, String time, List<String> menu) {
  if (menu.length != 0) {
    String year = date.year.toString();
    String month = date.month.toString();
    String day = date.day.toString();
    if (dummyMenuSchedule[year] == null) {
      dummyMenuSchedule[year] = {
        month: {
          day: {time: menu}
        }
      };
    } else if (dummyMenuSchedule[year]![month] == null) {
      dummyMenuSchedule[year]![month] = {
        day: {time: menu}
      };
    } else if (dummyMenuSchedule[year]![month]![day] == null) {
      dummyMenuSchedule[year]![month]![day] = {time: menu};
    } else {
      dummyMenuSchedule[year]![month]![day]![time] = menu;
    }
  }
}

Map<String, List<String>> getMenuData(DateTime date) {
  String year = date.year.toString();
  String month = date.month.toString();
  String day = date.day.toString();
  try {
    Map<String, List<String>>? menuData = dummyMenuSchedule[year]![month]![day];
    if (menuData != null)
      return menuData;
    else
      return {};
  } catch (e) {
    return {};
  }
}
