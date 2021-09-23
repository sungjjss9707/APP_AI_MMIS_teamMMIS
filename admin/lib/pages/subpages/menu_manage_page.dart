// 메뉴 관리 페이지
import 'package:admin/components/menu_manage/marker_info.dart';
import 'package:admin/components/menu_manage/menu_input_container.dart';
import 'package:admin/model/menu.dart';
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
          _pageTitle(),
          Divider(color: Colors.grey),
          SizedBox(width: gap_l),
          _buildCalendar(),
          SizedBox(height: gap_m),
          MenuInputContainer(date: _selectedDay),
        ],
      ),
    );
  }

  Widget _pageTitle() {
    return Text(
      "메뉴 관리",
      style: h4(),
    );
  }

  Widget _buildCalendar() {
    return Center(
      child: Container(
        width: 700,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TableCalendar(
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
            MarkerInfo(),
          ],
        ),
      ),
    );
  }

  Widget _singleMarkerBuilder(context, date, event) {
    if (event == "조식") {
      return Image.asset(
        "brunch.png",
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
    // 여기는 조식, 중식, 석식, 브런치 중 관리자가 입력했던 시간 때에 대한 정보가 있는 리스트가 있어야 됨.
    List<String> event = getMenuData(date).keys.toList();
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
