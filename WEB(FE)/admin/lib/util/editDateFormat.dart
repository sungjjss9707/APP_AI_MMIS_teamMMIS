String editDateFormat(DateTime dateTime) {
  return "${dateTime.year}-${dateTime.month}-${dateTime.day}";
}

String getYear(DateTime dateTime) {
  return dateTime.year.toString();
}

String getMonth(DateTime dateTime) {
  return dateTime.month.toString();
}

String getDay(DateTime dateTime) {
  return dateTime.day.toString();
}

class EatingTime {
  final String breakfast = "조식";
  final String brunch = "브런치";
  final String lunch = "중식";
  final String dinner = "석식";
}
