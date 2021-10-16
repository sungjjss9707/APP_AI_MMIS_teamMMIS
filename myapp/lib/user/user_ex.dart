import 'package:intl/intl.dart';

String userName = "최윤호";
String classes = "병장";
String army = "공군";
String unit = "8전투비행단";
double height = 180.0;
double weight = 70.0;

// Map<String, List> userNotEating = {
//   "2021-09-10": ["석식"]
// };
Map<String, Map<String, Map<String, List<String>>>> userNotEating =
    {}; // 2021, 3, 4, 석식 이런 식으로 데이터가 들어감.

List<String> splitDate(String date) {
  DateTime _date = DateFormat("yyyy/MM/dd").parse(date);
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
  } else if (userNotEating[year]![month]![day]!.contains(time)) {
    return;
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
  "계란류": false,
  "우유": false,
  "메밀": false,
  "땅콩": false,
  "대두": false,
  "밀": false,
  "고등어": false,
  "게": false,
  "새우": false,
  "돼지고기": false,
  "복숭아": false,
  "토마토": false,
  "아황산류": false,
  "호두": false,
  "닭고기": false,
  "쇠고기": false,
  "오징어": false,
  "조개류": false,
  "잣": false,
};
Map<String, bool> localUserAllergy = {...userAllergy};
