import 'package:intl/intl.dart';
import 'package:myapp/user/user_ex.dart';

final List<String> weekdayList = ["월", "화", "수", "목", "금", "토", "일"];
bool validateNow(String dateAndTime) {
  // 2021/10/3/석식
  DateTime input = DateFormat("yyyy/MM/dd").parse(dateAndTime);
  String time = getTimeFromDateAndTime(dateAndTime);
  DateTime now = DateTime.now();
  if (input.difference(now).inDays == 0 && now.day == input.day) {
    if (now.hour < 8) {
      if (time == "조식") return true;
    } else if (now.hour < 13) {
      if (time == "중식") return true;
    } else if (time == "석식") return true;
  }
  return false;
}

String editDateFormat(DateTime dateTime) {
  return "${dateTime.year}-${dateTime.month}-${dateTime.day}";
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

String getMonthDayAndWeekdayInKorean(String dateAndTime) {
  DateTime _date = DateFormat("yyyy/MM/dd").parse(dateAndTime);
  int month = _date.month;
  int day = _date.day;
  int weekInt = _date.weekday;
  String weekday = weekdayList[weekInt - 1];
  return "$month월 $day일($weekday)";
}

String getKoreanWeekDay(DateTime date) {
  return weekdayList[date.weekday - 1];
}

String getTimeFromDateAndTime(String dateAndTime) {
  String validate =
      dateAndTime.substring(dateAndTime.length - 2, dateAndTime.length - 1);
  String time = validate == "석"
      ? "석식"
      : validate == "중"
          ? "중식"
          : validate == "조"
              ? "조식"
              : "브런치";
  return time;
}

List<String> getYearMonthAndDayFromDateAndTime(String dateAndTime) {
  DateTime _date = DateFormat("yyyy/MM/dd").parse(dateAndTime);
  int year = _date.year;
  int month = _date.month;
  int day = _date.day;
  return [year.toString(), month.toString(), day.toString()];
}
