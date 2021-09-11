import 'package:intl/intl.dart';

String getToday() {
  DateTime now = DateTime.now();
  DateFormat formatter = DateFormat("yyyy-mm-dd");
  return formatter.format(now);
}

String getTodayInKorean() {
  DateTime now = DateTime.now();
  DateFormat formatter = DateFormat("yyyy년 mm월 dd일");
  return formatter.format(now);
}
