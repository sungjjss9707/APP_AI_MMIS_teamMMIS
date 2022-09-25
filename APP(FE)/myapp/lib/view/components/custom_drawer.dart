import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:myapp/controller/user_controller.dart';
import 'package:myapp/domain/user/user.dart';
import 'package:myapp/user/user_ex.dart';
import 'package:myapp/view/pages/initialpages/login_page.dart';
import 'package:myapp/view/pages/subpages/app_info_page.dart';
import 'package:myapp/view/pages/subpages/deduction_page.dart';
import 'package:myapp/view/pages/subpages/suggestion_page.dart';
import 'package:myapp/view/pages/subpages/user_info_page.dart';

class CustomDrawer extends StatelessWidget {
  final u = Get.put(UserController());
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw * 0.7,
      height: double.infinity,
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${u.principal.value.rank} ${u.principal.value.username}",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25.sp,
                  color: Colors.black),
            ),
            Text(
              "${u.principal.value.unit}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13.sp,
                color: Colors.black54,
              ),
            ),
            SizedBox(height: 8.h),
            Divider(),
            DrawerLine(
              iconName: Icons.account_circle,
              text: "내정보",
              tap: () {
                Navigator.pop(context);
                Get.to(() => UserInfoPage());
              },
            ),
            DrawerLine(
                iconName: Icons.payment,
                text: "공제내역",
                tap: () {
                  Navigator.pop(context);
                  Get.to(() => DeductionPage());
                }),
            DrawerLine(
              iconName: FontAwesomeIcons.exclamationCircle,
              text: "건의사항",
              tap: () {
                Navigator.pop(context);
                Get.to(() => SuggestionPage());
              },
            ),
            DrawerLine(
              iconName: Icons.info,
              text: "앱정보",
              tap: () {
                Navigator.pop(context);
                Get.to(() => AppInfoPage());
              },
            ),
            DrawerLine(
              iconName: Icons.logout,
              text: "로그아웃",
              tap: () {
                u.principal.value = User();
                Get.offAll(LoginPage());
              },
            ),
          ],
        ),
      ),
    );
  }
}

class DrawerLine extends StatelessWidget {
  IconData iconName;
  String text;
  final tap;

  DrawerLine({required this.iconName, required this.text, required this.tap});

  Widget build(BuildContext context) {
    return InkWell(
      onTap: tap,
      child: Column(
        children: [
          Row(
            children: [
              Icon(iconName),
              SizedBox(width: 8.w),
              Text(text,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.sp,
                      color: Colors.black54)),
            ],
          ),
          Divider(),
        ],
      ),
    );
  }
}
