import 'package:intl/intl.dart';

String userName = "최윤호";
String classes = "병장";
String army = "공군";
String unit = "8전투비행단";

// Map<String, List> userNotEating = {
//   "2021-09-10": ["석식"]
// };
Map<String, Map<String, Map<String, List<String>>>> userNotEating = {
  "2021": {
    "9": {
      "12": ["석식"]
    }
  }
}; // 2021, 3, 4, 석식 이런 식으로 데이터가 들어감.

List<String> splitDate(String date) {
  DateTime _date = DateFormat("yyyy-MM-dd").parse(date);
  return [_date.year.toString(), _date.month.toString(), _date.day.toString()];
}

void addUserNotEating(String date, String time) {
  List dateList = splitDate(date);
  String year = dateList[0];
  String month = dateList[1];
  String day = dateList[2];
  if (userNotEating[year] == null) {
    userNotEating[year] = {
      month: {
        day: [time]
      }
    };
  } else if (userNotEating[year]![month] == null) {
    userNotEating[year]![month] = {
      day: [time]
    };
  } else if (userNotEating[year]![month]![day] == null) {
    userNotEating[year]![month]![day] = [time];
  } else {
    userNotEating[year]![month]![day]!.add(time);
  }
}

void removeUserNotEating(String date, String time) {
  List dateList = splitDate(date);
  String year = dateList[0];
  String month = dateList[1];
  String day = dateList[2];
  userNotEating[year]![month]![day]!.remove(time);
  // if (userNotEating[date]!.length == 0) userNotEating.remove(date);
}

bool checkIfEating(String date, String time) {
  List dateList = splitDate(date);
  String year = dateList[0];
  String month = dateList[1];
  String day = dateList[2];
  if (userNotEating[year] == null) {
    return true;
  } else if (userNotEating[year]![month] == null) {
    return true;
  } else if (userNotEating[year]![month]![day] == null) {
    return true;
  } else if (userNotEating[year]![month]![day]!.contains(time)) {
    return false;
  } else
    return true;
}

Map<String, bool> userAllergy = {
  "갑각류": true,
  "견과류": true,
  "달걀": true,
  "땅콩": true,
  "밀": true,
  "생선": true,
  "우유": true,
  "조개": true,
  "콩": true
};
Map<String, bool> localUserAllergy = {...userAllergy};
