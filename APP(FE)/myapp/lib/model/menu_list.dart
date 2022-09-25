import 'package:intl/intl.dart';
import 'package:myapp/model/menu.dart';

Map<String, List<String>> dietFromServer = {};
Map<String, Map<String, Map<String, Map<String, List<String>>>>> menu = {
  "2021": {
    "10": {
      "6": {
        "석식": [
          "밥",
          "김치",
          "오징어 제육볶음",
          "맛김",
          "오이무침",
          "미역국",
        ],
      },
      "7": {
        "석식": [
          "차조밥",
          "열무김치",
          "버섯제육볶음",
          "맛김",
          "오뎅국",
          "김치",
          "우유",
          "초콜릿",
          "버섯",
        ],
      },
      "8": {
        "석식": [
          "밥",
          "오이소박이",
          "소고기볶음",
          "비엔나 소세지 볶음",
          "오이무침",
          "북엇국",
        ],
      },
      "9": {
        "중식": [
          "불고기 버거",
          "감자튀김",
          "시리얼",
        ],
      },
      "10": {
        "브런치": [
          "메밀국수",
          "김치",
          "떡갈비",
          "음료",
          "야채 샐러드",
          "마카롱",
        ],
      },
      "12": {
        "석식": [
          "밥",
          "김치",
        ],
        "중식": ["떡", "김치"],
        "조식": ["떡만두국", "김치"],
      },
      "13": {
        "브런치": [
          "메밀국수",
          "김치",
          "떡갈비",
          "음료",
          "야채 샐러드",
          "마카롱",
        ],
        "중식": [
          "메밀국수",
          "김치",
          "떡갈비",
          "음료",
          "야채 샐러드",
          "마카롱",
        ],
      },
    }
  }
};

List<String> times = ["브런치", "조식", "중식", "석식"];

bool checkMenuExistence(int year, int month, int day, String time) {
  if (dietFromServer["$year/$month/$day/$time"] != null) {
    if (dietFromServer["$year/$month/$day/$time"]!.length != 0) {
      return true;
    }
    // if (menu[year.toString()] == null) {
    //   return false;
    // } else if (menu[year.toString()]![month.toString()] == null) {
    //   return false;
    // } else if (menu[year.toString()]![month.toString()]![day.toString()] ==
    //     null) {
    //   return false;
    // } else if (menu[year.toString()]![month.toString()]![day.toString()]![time] ==
    //     null) {
    //   return false;
    // } else if (menu[year.toString()]![month.toString()]![day.toString()]![time]!
    //     .isEmpty) {
    //   return false;
    // } else {
    //   return true;
  }
  return false;
}

bool checkDayMenuExistence(int year, int month, int day) {
  List<int> temp = loadDayMenuExistence(year, month, day);
  int result = temp[0] + temp[1] + temp[2] + temp[3];
  return result != 0;
}

List<int> loadDayMenuExistence(int year, int month, int day) {
  List<int> result = [0, 0, 0, 0];
  checkMenuExistence(year, month, day, "브런치") == true ? result[0]++ : 0;
  checkMenuExistence(year, month, day, "조식") == true ? result[1]++ : 0;
  checkMenuExistence(year, month, day, "중식") == true ? result[2]++ : 0;
  checkMenuExistence(year, month, day, "석식") == true ? result[3]++ : 0;
  return result;
}

List<Menu> makeMenuList() {
  List<Menu> menuList = [];
  final years = menu.keys.toList();
  for (int i = 0; i < years.length; ++i) {
    final months = menu[years[i]]!.keys.toList();
    for (int j = 0; j < months.length; ++j) {
      final days = menu[years[i]]![months[j]]!.keys.toList();
      for (int k = 0; k < days.length; ++k) {
        final times = menu[years[i]]![months[j]]![days[k]]!.keys.toList();
        for (int l = 0; l < times.length; ++l) {
          final menuPlate = menu[years[i]]![months[j]]![days[k]]![times[l]];
          List<double> rate = menuPlate!.map((e) => 0.0).toList();
          DateTime t = DateTime(
              int.parse(years[i]), int.parse(months[j]), int.parse(days[k]));
          DateFormat formatter = DateFormat("yyyy-MM-dd");
          String date = formatter.format(t);
          menuList.add(Menu(date, times[l], menuPlate, rate));
        }
      }
    }
  }
  return menuList;
}
