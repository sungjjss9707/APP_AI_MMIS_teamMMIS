// 메뉴 관리 페이지
import 'package:admin/components/menu_manage/menu_input_container.dart';
import 'package:admin/page_util/calendar_util.dart';
import 'package:admin/size.dart';
import 'package:admin/style.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:table_calendar/table_calendar.dart';

class MenuManagePage extends StatefulWidget {
  @override
  _MenuManagePageState createState() => _MenuManagePageState();
}

class _MenuManagePageState extends State<MenuManagePage> {
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
          Text(
            "메뉴 관리",
            style: h4(),
          ),
          Divider(color: Colors.grey),
          SizedBox(width: gap_l),
          _buildCalendar(),
          SizedBox(height: gap_m),
          MenuInputContainer(day: _selectedDay)
        ],
      ),
    );
  }

  Widget _buildCalendar() {
    bool isBreakfast = false;
    bool isLunch = false;
    bool isDinner = false;
    bool isBrunch = false;

    return Container(
      width: 700,
      child: TableCalendar(
        calendarBuilders: CalendarBuilders(
          singleMarkerBuilder: (context, day, event) {
            if (event == "조식") {
              return Image.asset(
                "morning.png",
                width: 14,
                height: 14,
              );
            }
            if (event == "중식") {
              return FaIcon(
                FontAwesomeIcons.solidSun,
                color: Colors.red,
                size: 14,
              );
            }

            if (event == "석식") {
              return FaIcon(
                FontAwesomeIcons.solidMoon,
                color: Colors.yellow,
                size: 14,
              );
            } else {
              return Image.asset(
                "brunch.png",
                width: 14,
                height: 14,
              );
            }
          },
        ),
        focusedDay: _focusedDay,
        firstDay: kFirstDay,
        lastDay: kLastDay,
        calendarFormat: _calendarFormat,
        selectedDayPredicate: (day) {
          return isSameDay(_selectedDay, day);
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
    );
  }

  List _getEventsForDay(DateTime day) {
    // 여기는 조식, 중식, 석식, 브런치 중 관리자가 입력했던 시간 때에 대한 정보가 있는 리스트가 있어야 됨.
    List<String> event = MenuInputContainer(day: day).inputedTime;
    return event;
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
