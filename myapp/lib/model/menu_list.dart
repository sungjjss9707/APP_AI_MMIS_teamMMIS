Map<String, Map<String, Map<String, Map<String, List<String>>>>> menu = {
  "2021": {
    "9": {
      "12": {
        "석식": [
          "밥",
          "김치",
        ],
        "중식": ["떡", "김치"],
        "조식": ["떡만두국", "김치"],
      }
    }
  }
};

List<String> times = ["브런치", "조식", "중식", "석식"];

bool checkMenuExistence(int year, int month, int day, String time) {
  if (menu[year.toString()] == null) {
    return false;
  } else if (menu[year.toString()]![month.toString()] == null) {
    return false;
  } else if (menu[year.toString()]![month.toString()]![day.toString()] ==
      null) {
    return false;
  } else if (menu[year.toString()]![month.toString()]![day.toString()]![time] ==
      null) {
    return false;
  } else if (menu[year.toString()]![month.toString()]![day.toString()]![time]!
      .isEmpty) {
    return false;
  } else {
    return true;
  }
}

bool checkDayMenuExistence(int year, int month, int day) {
  List<int> temp = loadDayMenuExistence(year, month, day);
  int result = temp[0] + temp[1] + temp[2] + temp[3];
  return result != 0;
}

List<int> loadDayMenuExistence(int year, int month, int day) {
  List<int> result = [0, 0, 0, 0];
  checkMenuExistence(year, month, day, "브런치") == true ? result[0]++ : 0;
  checkMenuExistence(year, month, day, "조식") == true ? result[1]++ : 0;
  checkMenuExistence(year, month, day, "중식") == true ? result[2]++ : 0;
  checkMenuExistence(year, month, day, "석식") == true ? result[3]++ : 0;
  return result;
}
