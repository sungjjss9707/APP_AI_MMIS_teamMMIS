import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_mmis/components/not_eating.dart';
import 'package:project_mmis/get_today.dart';
import 'package:project_mmis/model/menu.dart';
import 'package:project_mmis/pages/subpages/rate_menu_page.dart';

class MenuBox extends StatelessWidget {
  final String date;
  final String time;
  const MenuBox(this.date, this.time);
  @override
  Widget build(BuildContext context) {
    bool _isToday;
    this.date == getToday() ? _isToday = true : _isToday = false;
    Menu menu =
        dummyMenu.firstWhere((e) => e.date == this.date && e.time == this.time);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Get.to(() => RateMenuPage(date, time));
        },
        child: Container(
          padding: EdgeInsets.all(2),
          height: 120,
          width: 90,
          decoration: BoxDecoration(
            border: _isToday == false
                ? Border.all(color: Colors.black45, width: 2)
                : Border.all(color: Colors.blue, width: 3),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //그 메뉴에 대한 날짜와 시간(조식, 중식, 석식)
              Text(
                "${menu.date} (${menu.time})",
                style: TextStyle(fontSize: 9),
              ),
              Divider(color: Colors.grey),
              // 메뉴
              Expanded(
                child: ListView(
                  children: [
                    Column(
                      children: List.generate(
                        menu.menuPlate.length,
                        (index) => Text(
                          "${menu.menuPlate[index]}",
                          style: TextStyle(fontSize: 9),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 1),
              // 취식, 불취식 표시
              NotEating(),
            ],
          ),
        ),
      ),
    );
  }
}
