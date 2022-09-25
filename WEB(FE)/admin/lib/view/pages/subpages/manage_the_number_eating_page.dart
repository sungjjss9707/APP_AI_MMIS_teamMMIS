// 식수 인원 관리 페이지

import 'package:admin/controller/not_eating_controller.dart';
import 'package:admin/domain/not_eating/not_eating.dart';
import 'package:admin/util/calendar_util.dart';
import 'package:admin/util/editDateFormat.dart';
import 'package:admin/view/components/button/custom_elevated_button.dart';
import 'package:admin/view/components/home/customTitle.dart';

import 'package:admin/view/components/number_eating/custom_detail_table.dart';
import 'package:admin/view/components/number_eating/custom_simple_table.dart';
import 'package:admin/view/components/number_eating/total_num_dialog.dart';
import 'package:flutter/cupertino.dart';
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
  late bool _simpleOrDetail;
  final double _containerWidth = 700;
  @override
  void initState() {
    _selectedDay = _focusedDay;
    _simpleOrDetail = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final String year = getYear(_selectedDay);
    final String month = getMonth(_selectedDay);
    final String day = getDay(_selectedDay);
    _findByDate(year, month, day);
    double _width = getBodyWidth(context);
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
              CustomTitle("식수 인원 관리"),
              Text(
                  "주의! 데모버전에서는 10월 16일부터 11월 10일까지의 불취식만 데이터를 가지고 있습니다. 참고하시기 바랍니다. 다른 날을 선택하면 에러가 납니다."),
              Text("데이터가 안변할 시, 다른 날짜를 찍고 다시 돌아와주세요."),
              Divider(color: Colors.grey),
              _buildCalendar(),
              _changeTotalNum(context),
              SizedBox(height: gap_l),
              _showData(year, month, day),
            ],
          ),
        ],
      ),
    );
  }

  Widget _changeTotalNum(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CustomElevatedButton(
          text: "총인원 수정",
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                List<NotEating> temp = not.notEatings.values.toList();
                List<String> totalNumberOfPeopleList =
                    temp.map((e) => e.totalNumberOfPeople ?? "0").toList();
                return TotalNumDialog(_selectedDay, totalNumberOfPeopleList);
              },
            );
          },
        ),
      ],
    );
  }

  Widget _showData(String year, month, day) {
    return FutureBuilder(
      future: _getData(year, month, day),
      builder: (context, snapshot) {
        if (snapshot.hasData == false) {
          return CircularProgressIndicator(
            color: Colors.grey,
          );
        }
        //error가 발생하게 될 경우 반환하게 되는 부분
        else if (snapshot.hasError) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Error: ${snapshot.error}',
              style: TextStyle(fontSize: 15),
            ),
          );
        }

        return Center(
          child: Container(
            width: _containerWidth,
            padding: const EdgeInsets.all(gap_m),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: _simpleOrDetail == true
                          ? Colors.lightGreen
                          : Colors.lightBlue),
                  onPressed: () {
                    setState(() {
                      if (_simpleOrDetail == true)
                        _simpleOrDetail = false;
                      else
                        _simpleOrDetail = true;
                    });
                  },
                  child: Text(_simpleOrDetail ? "명단보기" : "불취식 인원 수 보기"),
                ),
                SizedBox(height: gap_m),
                Center(
                  child: _simpleOrDetail == true
                      ? CustomSimpleTable(not.notEatings)
                      : CustomDetailTable(not.notEatings),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _findByDate(String year, month, day) async {}
  Widget _buildCalendar() {
    return Center(
      child: Container(
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
        width: _containerWidth,
        child: TableCalendar(
          locale: 'ko-KR',
          calendarStyle: CalendarStyle(),
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

  Future<int> _getData(String year, month, day) async {
    try {
      await not.findByDateAndTime(year, month, day, "조식");
      await not.findByDateAndTime(year, month, day, "브런치");
      await not.findByDateAndTime(year, month, day, "중식");
      await not.findByDateAndTime(year, month, day, "석식");
      return 1;
    } catch (e) {
      return -1;
    }
  }
}
