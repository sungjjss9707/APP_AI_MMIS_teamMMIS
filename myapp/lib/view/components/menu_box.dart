import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:myapp/user/user_ex.dart';
import 'package:myapp/view/components/button/yes_eating.dart';
import 'package:myapp/view/pages/subpages/rate_menu_page.dart';
import '../../date_functions.dart';
import 'button/not_eating.dart';

class MenuBox extends StatelessWidget {
  final String dateAndTime;
  final Map<String, List<String>> menuMap;
  final List<String> menuList;
  const MenuBox(this.dateAndTime, this.menuList, this.menuMap);
  @override
  Widget build(BuildContext context) {
    bool _isToday;
    this.dateAndTime == getToday() ? _isToday = true : _isToday = false;
    String validate =
        dateAndTime.substring(dateAndTime.length - 2, dateAndTime.length - 1);
    final String time = validate == "석"
        ? "석식"
        : validate == "중"
            ? "중식"
            : validate == "조"
                ? "조식"
                : "브런치";

    return Padding(
      padding: EdgeInsets.all(8.w),
      child: InkWell(
        onTap: () {
          Get.to(
            () => RateMenuPage(
              dateAndTime,
              menuMap,
            ),
          );
        },
        child: Container(
          padding: EdgeInsets.all(2.w),
          height: (0.3).sw,
          width: (0.2).sw,
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
              _buildMenuHeader(),
              Divider(color: Colors.grey),
              // 메뉴
              _buildMenuList(),
              SizedBox(height: 2),
              // 취식, 불취식 표시
              menuList.length == 0
                  ? Container()
                  : _buildCheckIfEating(time)
                      ? YesEating()
                      : NotEating(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuHeader() {
    return Text(
      "$dateAndTime",
      style: TextStyle(fontSize: 8.sp),
    );
  }

  Widget _buildMenuList() {
    return menuList.length == 0
        ? Center(
            child: Text(
              "등록된 메뉴 정보가 없습니다.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 8.sp),
            ),
          )
        : Expanded(
            child: ListView(
              children: [
                Column(
                  children: List.generate(
                    menuList.length,
                    (index) => Text(
                      "${menuList[index]}",
                      style: TextStyle(fontSize: 8.sp),
                    ),
                  ),
                )
              ],
            ),
          );
  }

  bool _buildCheckIfEating(String time) {
    return checkIfEating(dateAndTime, time);
  }
}
