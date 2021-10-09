// 식수 인원 관리 페이지

import 'package:admin/controller/not_eating_controller.dart';
import 'package:admin/util/calendar_util.dart';
import 'package:admin/view/components/button/custom_elevated_button.dart';
import 'package:admin/view/components/home/customTitle.dart';
import 'package:admin/view/components/number_eating/custom_piechart.dart';
import 'package:admin/view/components/number_eating/total_num_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:table_calendar/table_calendar.dart';

import '../../../size.dart';

class ManageTheNumberEatingPage extends StatefulWidget {
  @override
  _ManageTheNumberEatingPageState createState() =>
      _ManageTheNumberEatingPageState();
}

class _ManageTheNumberEatingPageState extends State<ManageTheNumberEatingPage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  late DateTime _selectedDay;
  final not = Get.put(NotEatingController());

  @override
  void initState() {
    _selectedDay = _focusedDay;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTitle("식수 인원 관리"),
        Divider(color: Colors.grey),
        _buildCalendar(),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomElevatedButton(
              text: "총인원 수정",
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => TotalNumDialog(_selectedDay),
                );
              },
            ),
          ],
        ),
        SizedBox(height: gap_l),
        CustomPieChart(date: _selectedDay),
      ],
    );
  }

  Widget _buildCalendar() {
    return Center(
      child: Container(
        width: 700,
        child: TableCalendar(
          locale: 'ko-KR',
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
