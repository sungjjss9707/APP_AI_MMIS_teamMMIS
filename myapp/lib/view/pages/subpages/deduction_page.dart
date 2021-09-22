import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:myapp/date_functions.dart';
import 'package:myapp/page_util/deduction_util.dart';
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
        child: Column(
          children: [
            DeductionCount(),
            SizedBox(height: 20),
            DeductionCalendar(),
          ],
        ),
      ),
    );
  }
}

class DeductionCount extends StatelessWidget {
  int count = calDeduction()[1];
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
              "이번달 총 불취식횟수는 $count회 입니다.",
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

class DeductionCalendar extends StatefulWidget {
  @override
  _DeductionCalendarState createState() => _DeductionCalendarState();
}

class _DeductionCalendarState extends State<DeductionCalendar> {
  final CalendarFormat _calendarFormat = CalendarFormat.month;
  final RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.disabled;
  Map<DateTime, List<String>> notEatingDays = calDeduction()[0];
  int notEatingCount = calDeduction()[1];
  List getEventsForDay(DateTime day) {
    return notEatingDays[day] ?? [];
  }

  DateTime? _selectedDay;
  DateTime _focusedDay = DateTime.now();
  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now();
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: [
          TableCalendar(
            rangeSelectionMode: _rangeSelectionMode,
            calendarFormat: _calendarFormat,
            eventLoader: getEventsForDay,
            headerStyle:
                HeaderStyle(formatButtonVisible: false, titleCentered: true),
            focusedDay: _focusedDay,
            firstDay: DateTime.utc(2021, 1, 1),
            lastDay: DateTime.utc(2022, 12, 31),
            locale: 'ko-KR',
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: _onDaySelected,
          ),
          ...getEventsForDay(_selectedDay!).map((value) {
            return Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black54),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ListTile(
                    onTap: () {
                      setState(() {
                        final year = _selectedDay!.year;
                        final month = _selectedDay!.month;
                        final day = _selectedDay!.day;
                        String date = transformToDateForm(year, month, day);
                        removeUserNotEating(date, value);
                      });
                    },
                    title: Text("$value 불취식 취소",
                        style: TextStyle(fontSize: 20, color: Colors.blue)),
                  ),
                ),
                SizedBox(height: 10),
              ],
            );
          }),
        ],
      ),
    );
  }
}
