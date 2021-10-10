String editDateFormat(DateTime dateTime) {
  return "${dateTime.year}-${dateTime.month}-${dateTime.day}";
}

String getYear(DateTime dateTime){
  return dateTime.year.toString();
}

String getMonth(DateTime dateTime){
  return dateTime.month.toString();
}


String getDay(DateTime dateTime){
  return dateTime.day.toString();
}

class EatingTime {"조식", "브런치", "중식", "석식"};