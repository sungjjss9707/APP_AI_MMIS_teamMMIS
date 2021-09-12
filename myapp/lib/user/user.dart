import 'package:intl/intl.dart';

Map<String, dynamic> userNotEating = {
  "2021": {
    "09": {
      "10": ["중식", "석식"]
    }
  }
};

void addUserNotEating(String date, String time) {
  //date는 "2021-09-21"형식으로
  var date1 = DateFormat('dd/MM/YYYY').parse(date);
  String year = date1.year.toString();
  String month = date1.month.toString();
  String day = date1.day.toString();
}
