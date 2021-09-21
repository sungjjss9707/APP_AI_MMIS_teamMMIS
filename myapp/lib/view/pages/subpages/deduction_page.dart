import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:myapp/user/user.dart';
import 'package:table_calendar/table_calendar.dart';

class DeductionPage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "공제",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white),
        ),
        elevation: 2,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [
            DeductionCount(),
            SizedBox(height: 20),
            Text("공제 내역",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            Divider(),
            DeductionCalendar(),
          ],
        ),
      ),
    );
  }
}

class DeductionCount extends StatelessWidget {
  int count = countDeduction();
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black12, width: 3),
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 20, bottom: 20, right: 50, left: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "이번달 총 공제는 $count회 입니다.",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

int countDeduction() {
  final notEatings = userNotEating;
  int count = 0;
  final years = notEatings.keys.toList();
  for (int i = 0; i < notEatings.length; ++i) {
    final months = notEatings[years[i]]!.keys.toList();
    for (int j = 0; j < months.length; ++j) {
      final days = notEatings[years[i]]![months[j]]!.keys.toList();
      for (int k = 0; k < days.length; ++k) {
        count += notEatings[years[i]]![months[j]]![days[k]]!.length;
      }
    }
  }
  return count;
}

class DeductionCalendar extends StatefulWidget {
  @override
  _DeductionCalendarState createState() => _DeductionCalendarState();
}

class _DeductionCalendarState extends State<DeductionCalendar> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      calendarFormat: _calendarFormat,
      focusedDay: DateTime.now(),
      firstDay: DateTime.utc(2021, 1, 1),
      lastDay: DateTime.utc(2022, 12, 31),
      locale: 'ko-KR',
    );
  }
}
