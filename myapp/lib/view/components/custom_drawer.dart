import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/user/user.dart';
import 'package:myapp/view/pages/initialpages/login_page.dart';
import 'package:myapp/view/pages/subpages/deduction_page.dart';
import 'package:myapp/view/pages/subpages/suggestion_page.dart';
import 'package:myapp/view/pages/subpages/user_info_page.dart';

class CustomDrawer extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      height: double.infinity,
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "$classes $userName",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.black),
            ),
            Text(
              "$army $unit",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.black54,
              ),
            ),
            SizedBox(height: 10),
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
                iconName: Icons.analytics,
                text: "공제내역 확인",
                tap: () {
                  Navigator.pop(context);
                  Get.to(() => DeductionPage());
                }),
            DrawerLine(
              iconName: Icons.question_answer,
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
                print("앱정보");
              },
            ),
            DrawerLine(
              iconName: Icons.logout,
              text: "로그아웃",
              tap: () {
                Get.off(LoginPage());
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
              SizedBox(width: 10),
              Text(text,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black54)),
            ],
          ),
          Divider(),
        ],
      ),
    );
  }
}
