import 'package:intl/intl.dart';

String getToday() {
  DateTime now = DateTime.now();
  DateFormat formatter = DateFormat("yyyy-MM-dd");
  return formatter.format(now);
}

String getTodayInKorean() {
  List<String> weekdayKorean = ["월", "화", "수", "목", "금", "토", "일"];
  DateTime now = DateTime.now();
  int year = now.year;
  int month = now.month;
  int day = now.day;
  int weekInt = now.weekday;
  String weekday = weekdayKorean[weekInt - 1];
  return "$year년 $month월 $day일($weekday)";
}

String transformToDateForm(int year, int month, int day) {
  DateTime now = DateTime(year, month, day);
  DateFormat formatter = DateFormat("yyyy-MM-dd");
  return formatter.format(now);
}
