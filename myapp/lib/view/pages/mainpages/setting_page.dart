import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:myapp/view/pages/subpages/inner_seeting_page.dart';

class SettingPage extends StatelessWidget {
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      children: [
        ConfigItem(
            icon: Icons.search,
            text: "예시1",
            tap: () {
              print("예시1");
            }),
        ConfigItem(
            icon: Icons.account_circle,
            text: "예시2",
            tap: () {
              print("예시2");
            }),
        ConfigItem(
            icon: CupertinoIcons.gear_alt_fill,
            text: "설정내부 확인",
            tap: () {
              Get.to(() => InnerSettingPage());
            }),
        ConfigItem(
            icon: Icons.analytics,
            text: "예시4",
            tap: () {
              print("예시4");
            }),
      ],
    );
  }
}

class ConfigItem extends StatelessWidget {
  IconData icon;
  String text;
  final tap;
  ConfigItem({required this.icon, required this.text, required this.tap});
  Widget build(BuildContext context) {
    return InkWell(
      onTap: tap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 50),
          Text(
            text,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ],
      ),
    );
  }
}
