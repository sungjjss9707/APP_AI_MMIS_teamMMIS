import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/date_functions.dart';
import 'package:myapp/user/user.dart';
import 'package:myapp/view/components/not_eating.dart';
import 'package:myapp/view/pages/mainpages/framepage.dart';
import 'package:myapp/view/pages/mainpages/homepage.dart';

class EatingSchedulePage extends StatefulWidget {
  @override
  _EatingSchedulePageState createState() => _EatingSchedulePageState();
}

class _EatingSchedulePageState extends State<EatingSchedulePage> {
  late int month, year, totalAmount;
  Map<String, List<String>> NotEatingDayThisMonth = {
    "0": [""]
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
        leading: IconButton(
          onPressed: () {
            Get.offAll(FramePage());
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            _thisMonthDeduction(numberOfDates),
            _notEatingDays(numberOfDates),
          ],
        ),
      ),
    );
  }

  Widget _thisMonthDeduction(int numberOfDates) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 16),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          width: 1,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          "${userName}님의 ${year}년 ${month}월 공제예정금액은\n${(numberOfDates * 2370 * 2 - 2370)}원입니다.",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _notEatingDays(int numberOfDates) {
    return Expanded(
      child: ListView.separated(
        itemBuilder: (context, index) {
          bool isNotEatingTime = false;
          List<String>? notEatingTime;
          int _day = index + 1;
          String _dayString = _day.toString();
          String _date = "$year년 $month월 $_day일";
          if (NotEatingDayThisMonth[_dayString] != null) {
            notEatingTime = NotEatingDayThisMonth[_dayString];
            if (notEatingTime!.length != 0) isNotEatingTime = true;
          }
          // print("$_day $notEatingTime");
          return isNotEatingTime
              ? ExpansionTile(
                  initiallyExpanded: false,
                  title: Text(_date),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: List.generate(notEatingTime!.length, (index) {
                          return Row(
                            children: [
                              Text(notEatingTime![index]),
                              SizedBox(width: 4),
                              NotEating(),
                              Spacer(),
                              _buildElevatedButton(_day, notEatingTime[index]),
                            ],
                          );
                        }),
                      ),
                    )
                  ],
                )
              : ListTile(
                  title: Text(_date),
                );
        },
        itemCount: numberOfDates,
        separatorBuilder: (context, index) => Divider(color: Colors.grey),
      ),
    );
  }

  ElevatedButton _buildElevatedButton(int day, String time) {
    String date = transformToDateForm(year, month, day);
    return ElevatedButton(
      onPressed: () {
        setState(() {
          removeUserNotEating(date, time);
        });
      },
      child: Text("취식 신청"),
    );
  }
}
