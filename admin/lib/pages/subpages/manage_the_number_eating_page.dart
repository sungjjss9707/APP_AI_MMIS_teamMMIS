// 식수 인원 관리 페이지
import 'package:admin/components/number_eating/custom_piechart.dart';
import 'package:admin/page_util/calendar_util.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../size.dart';
import '../../style.dart';

class ManageTheNumberEatingPage extends StatefulWidget {
  @override
  _ManageTheNumberEatingPageState createState() =>
      _ManageTheNumberEatingPageState();
}

class _ManageTheNumberEatingPageState extends State<ManageTheNumberEatingPage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  late DateTime _selectedDay;

  @override
  void initState() {
    _selectedDay = _focusedDay;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getBodyWidth(context),
      padding: EdgeInsets.all(gap_xl),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _pageTitle(),
          Divider(color: Colors.grey),
          _buildCalendar(),
          CustomPieChart(
            date: _selectedDay,
          ),
        ],
      ),
    );
  }

  Widget _pageTitle() {
    return Text(
      "식수 인원 관리",
      style: h4(),
    );
  }

  Widget _buildCalendar() {
    return Center(
      child: Container(
        width: 700,
        child: TableCalendar(
          calendarBuilders: CalendarBuilders(
            selectedBuilder: _selectedBuilder,
            singleMarkerBuilder: _singleMarkerBuilder,
          ),
          focusedDay: _focusedDay,
          firstDay: kFirstDay,
          lastDay: kLastDay,
          calendarFormat: _calendarFormat,
          selectedDayPredicate: (date) {
            return isSameDay(_selectedDay, date);
          },
          onDaySelected: _onDaySelected,
          eventLoader: _getEventsForDay,
          onFormatChanged: (format) {
            if (_calendarFormat != format) {
              setState(
                () {
                  _calendarFormat = format;
                },
              );
            }
          },
          onPageChanged: (focusedDay) {
            _focusedDay = focusedDay;
          },
        ),
      ),
    );
  }

  Widget _singleMarkerBuilder(context, date, event) {
    return Container();
  }

  Widget _selectedBuilder(context, DateTime date, focusedDay) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.lightGreen[300],
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          date.day.toString(),
        ),
      ),
    );
  }

  List<String> _getEventsForDay(DateTime date) {
    // 여기는 각 날의 식수 인원에 대한 정보가 있어야 됨.
    return [];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });
    }
  }
}
