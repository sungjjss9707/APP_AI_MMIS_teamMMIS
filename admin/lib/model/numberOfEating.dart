import 'package:flutter/material.dart';

Map<String, Map<String, Map<String, Map<String, String>>>> dummyNumberOfEating =
    {
  "2021": {
    "9": {
      "21": {"당직": "2", "휴가": "10", "외출": "2", "기타": "3"},
      "22": {"당직": "10", "휴가": "20", "외출": "4", "기타": "3"},
    }
  }
};
int TotalNumberOfPeople = 100;

Map<String, String> getNotEatingInfo(DateTime date) {
  String year = date.year.toString();
  String month = date.month.toString();
  String day = date.day.toString();
  try {
    Map<String, String>? notEatingData =
        dummyNumberOfEating[year]![month]![day];
    if (notEatingData != null)
      return notEatingData;
    else
      return {};
  } catch (e) {
    return {};
  }
}

List<NotEatingData> getNotEatingData(Map<String, String> notEatingData) {
  int sum = 0;
  for (String i in notEatingData.values) {
    sum += int.parse(i);
  }
  return [
    NotEatingData("불취식", sum),
    NotEatingData("취식", TotalNumberOfPeople - sum)
  ];
}

List<ReasonNotEatingData> getReaSonNotEatingData(
    Map<String, String> notEatingData) {
  List<ReasonNotEatingData> data = [];
  for (String key in notEatingData.keys) {
    String value = notEatingData[key]!;
    data.add(ReasonNotEatingData(key, int.parse(value)));
  }
  return data;
}

class NotEatingData {
  NotEatingData(this.isEating, this.numOfPeople);
  final String isEating;
  final int numOfPeople;
}

class ReasonNotEatingData {
  ReasonNotEatingData(this.reason, this.numOfPeople);
  // 불취식 사유
  final String reason;
  //사유에 따른 이유
  final int numOfPeople;
}
