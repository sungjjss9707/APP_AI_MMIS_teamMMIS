import 'package:intl/intl.dart';

final List<String> weekdayList = ["월", "화", "수", "목", "금", "토", "일"];
String getToday() {
  DateTime now = DateTime.now();
  DateFormat formatter = DateFormat("yyyy-MM-dd");
  return formatter.format(now);
}

String getTodayInKorean() {
  DateTime now = DateTime.now();
  int year = now.year;
  int month = now.month;
  int day = now.day;
  int weekInt = now.weekday;
  String weekday = weekdayList[weekInt - 1];
  return "$year년 $month월 $day일($weekday)";
}

String transformToDateForm(int year, int month, int day) {
  DateTime now = DateTime(year, month, day);
  DateFormat formatter = DateFormat("yyyy-MM-dd");
  return formatter.format(now);
}

String getMonthDayAndWeekdayInKorean(String date) {
  DateTime dateTime = DateTime.parse(date);
  int month = dateTime.month;
  int day = dateTime.day;
  int weekInt = dateTime.weekday;
  String weekday = weekdayList[weekInt - 1];
  return "$month월 $day일($weekday)";
}
