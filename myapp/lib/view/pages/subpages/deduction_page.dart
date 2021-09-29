import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:myapp/date_functions.dart';
import 'package:myapp/model/menu_list.dart';
import 'package:myapp/page_util/deduction_util.dart';
import 'package:myapp/user/user.dart';
import 'package:myapp/view/components/appBar/sub_page_appbar.dart';
import 'package:myapp/view/components/custom_drawer.dart';

import 'package:table_calendar/table_calendar.dart';

class DeductionPage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: subPageAppBar("공제내역"),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
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
          DeductionCount(),
          SizedBox(height: 20),
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
          SizedBox(height: 10),
          NoMenuText(
              _selectedDay!.year, _selectedDay!.month, _selectedDay!.day),
          ...List.generate(
              loadDayMenuExistence(_selectedDay!.year, _selectedDay!.month,
                      _selectedDay!.day)
                  .length, (index) {
            if (loadDayMenuExistence(_selectedDay!.year, _selectedDay!.month,
                    _selectedDay!.day)[index] ==
                0) {
              return SizedBox();
            }
            List<String> notEatingTimes = calDeduction()[0][_selectedDay];
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
                        if (notEatingTimes.contains(times[index])) {
                          removeUserNotEating(date, times[index]);
                        } else {
                          addUserNotEating(date, times[index]);
                        }
                      });
                    },
                    title: Text(
                        "${times[index]} " +
                            (notEatingTimes.contains(times[index])
                                ? "불취식 취소"
                                : "불취식 신청"),
                        style: TextStyle(
                            fontSize: 20,
                            color: notEatingTimes.contains(times[index])
                                ? Colors.blue
                                : Colors.red)),
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

class NoMenuText extends StatelessWidget {
  int year;
  int month;
  int day;
  NoMenuText(this.year, this.month, this.day);
  @override
  Widget build(BuildContext context) {
    if (checkDayMenuExistence(year, month, day)) {
      return SizedBox();
    }
    return Row(
      children: [
        Expanded(
          child: Center(
            child: Text(
              "식사 제공 없는 날",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.cyan),
            ),
          ),
        ),
      ],
    );
  }
}
