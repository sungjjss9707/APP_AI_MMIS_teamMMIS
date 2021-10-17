// 메뉴 관리 페이지

import 'package:admin/controller/diet_controller.dart';
import 'package:admin/controller/menu_controller.dart';
import 'package:admin/domain/diet/diet.dart';
import 'package:admin/size.dart';
import 'package:admin/util/Info.dart';
import 'package:admin/util/calendar_util.dart';
import 'package:admin/view/components/home/customTitle.dart';
import 'package:admin/view/components/menu_manage/marker_info.dart';
import 'package:admin/view/components/menu_manage/diet_input_container.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class DietManagePage extends StatefulWidget {
  @override
  _DietManagePageState createState() => _DietManagePageState();
}

class _DietManagePageState extends State<DietManagePage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  late DateTime _selectedDay;
  final menuCon = Get.put(MenuController());
  final dietCon = Get.put(DietController());

  @override
  initState() {
    _selectedDay = _focusedDay;
    _setMenus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double _width = getMediaQueryWidth(context);
    return Padding(
      padding: _width < 540
          ? const EdgeInsets.all(gap_m)
          : const EdgeInsets.all(gap_xl),
      child: ListView(
        children: [
          Column(
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
          ),
        ],
      ),
    );
  }

  Widget _buildCalendar() {
    return Center(
      child: Container(
        padding: EdgeInsets.all(gap_m),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 10,
              spreadRadius: 0.01,
              offset: Offset(3, 3),
            ),
          ],
        ),
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
  // 시간 남으면 하자....
  // Future<List<String>> _getEventsForDay(DateTime date) async {
  //   // 여기는 조식, 중식, 석식, 브런치 중 관리자가 입력했던 시간 때에 대한 정보가 있는 리스트가 있어야 됨.
  //   String year = getYear(date);
  //   String month = getMonth(date);
  //   Map<String, List<String>> eventMap = await _editMenuForDays(year, month);
  //   List<String>
  //   return event;
  // }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });
    }
  }

  Future<Map<String, List<String>>> _editMenuForDays(String year, month) async {
    await dietCon.findMonth(year, month);
    Map<String, List<String>> result = {};
    for (Diet diet in dietCon.diets) {
      String a = diet.now!.substring(diet.now!.length - 2, diet.now!.length);
      List<String> menus =
          diet.menus!.map((e) => e["name"].toString()).toList();
      if (a == "조식")
        result["조식"] = menus;
      else if (a == "브런치")
        result["브런치"] = menus;
      else if (a == "중식")
        result["중식"] = menus;
      else if (a == "석식") result["석식"] = menus;
    }
    return result;
  }
}
