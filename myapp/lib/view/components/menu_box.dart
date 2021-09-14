import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/model/menu.dart';
import 'package:myapp/user/user.dart';
import 'package:myapp/view/components/button/yes_eating.dart';
import 'package:myapp/view/pages/subpages/rate_menu_page.dart';
import '../../date_functions.dart';
import 'button/not_eating.dart';

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
                : Border.all(color: Colors.lightGreen[600]!, width: 2),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //그 메뉴에 대한 날짜와 시간(조식, 중식, 석식)
              _buildMenuHeader(menu),
              Divider(color: Colors.grey),
              // 메뉴
              _buildMenuList(menu),
              SizedBox(height: 2),
              // 취식, 불취식 표시
              _buildCheckIfEating() ? YesEating() : NotEating(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuHeader(Menu menu) {
    return Text(
      "${menu.date} (${menu.time})",
      style: TextStyle(fontSize: 9),
    );
  }

  Widget _buildMenuList(Menu menu) {
    return Expanded(
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
    );
  }

  bool _buildCheckIfEating() => checkIfEating(date, time);
}
