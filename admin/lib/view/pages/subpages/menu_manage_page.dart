// 메뉴 관리 페이지

import 'package:admin/controller/menu_controller.dart';
import 'package:admin/model/menu.dart';

import 'package:admin/size.dart';
import 'package:admin/util/Info.dart';
import 'package:admin/util/calendar_util.dart';

import 'package:admin/view/components/home/customTitle.dart';
import 'package:admin/view/components/menu_manage/marker_info.dart';
import 'package:admin/view/components/menu_manage/menu_input_container.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'package:table_calendar/table_calendar.dart';

class MenuManagePage extends StatefulWidget {
  @override
  _MenuManagePageState createState() => _MenuManagePageState();
}

class _MenuManagePageState extends State<MenuManagePage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  late DateTime _selectedDay;
  final menuCon = Get.put(MenuController());

  @override
  initState() {
    _selectedDay = _focusedDay;
    _setMenus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTitle("메뉴 관리"),
        Divider(color: Colors.grey),
        SizedBox(width: gap_l),
        _buildCalendar(),
        SizedBox(height: gap_m),
        MenuInputContainer(date: _selectedDay),
      ],
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
            MarkerInfo(),
          ],
        ),
      ),
    );
  }

  Future<void> _setMenus() async {
    await menuCon.findAll();
    Menus.menus = menuCon.menus.map((e) => e.name ?? "").toList();
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
