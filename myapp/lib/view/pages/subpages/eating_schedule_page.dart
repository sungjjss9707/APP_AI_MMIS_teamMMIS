import 'package:flutter/material.dart';
import 'package:myapp/user/user.dart';
import 'package:myapp/view/components/not_eating.dart';

class EatingSchedulePage extends StatefulWidget {
  @override
  _EatingSchedulePageState createState() => _EatingSchedulePageState();
}

class _EatingSchedulePageState extends State<EatingSchedulePage> {
  late int month, year, totalAmount;
  Map<String, List<String>> NotEatingDayThisMonth = {
    "0000": [""]
  };

  @override
  void initState() {
    DateTime now = DateTime.now();
    year = now.year; //int임
    month = now.month; // int 임
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // example
    var date = new DateTime(year, month + 1, 0);
    var numberOfDates = date.day.toInt(); // month의 마지막 날 28,29, 30, 31 중 하나겠지.
    String yearString = year.toString();
    String monthString = month.toString();
    if (userNotEating[yearString] != null) {
      if (userNotEating[yearString]![monthString] != null) {
        NotEatingDayThisMonth = userNotEating[yearString]![monthString]!;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("불취식 관리"),
      ),
      body: Column(
        children: [
          _thisMonthDeduction(numberOfDates),
          _notEatingDays(numberOfDates),
        ],
      ),
    );
  }

  Widget _thisMonthDeduction(int numberOfDates) {
    return Container(
      child: Text(
        "${userName}님의 ${year}년 ${month}월 공제예정금액은\n${(numberOfDates * 2370)}원입니다.",
      ),
    );
  }

  Widget _notEatingDays(int numberOfDates) {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (context, index) {
          bool isNotEatingTime = false;
          List<String>? notEatingTime;
          int _day = index + 1;
          String _dayString = _day.toString();
          String _date = "$year-$month-$_day";
          if (NotEatingDayThisMonth[_dayString] != null) {
            notEatingTime = NotEatingDayThisMonth[_dayString];
            if (notEatingTime!.length != 0) isNotEatingTime = true;
          }
          // print("$_day $notEatingTime");
          return isNotEatingTime
              ? ExpansionTile(
                  title: Text(_date),
                  children: [
                    Column(
                      children: List.generate(notEatingTime!.length, (index) {
                        return Row(
                          children: [
                            Text(notEatingTime![index]),
                            NotEating(),
                          ],
                        );
                      }),
                    )
                  ],
                  // trailing: Column(
                  //   children: List.generate(notEatingTime!.length, (index) {
                  //     return Row(
                  //       children: [
                  //         Text(notEatingTime![index]),
                  //         NotEating(),
                  //       ],
                  //     );
                  //   }),
                  // ),
                )
              : ListTile(
                  title: Text(_date),
                );
        },
        itemCount: numberOfDates,
      ),
    );
  }
}
