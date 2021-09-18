import 'package:flutter/material.dart';

class SideMenuBar extends StatelessWidget {
  final List<String> sideMenuBarList = [
    "메뉴 입력",
    "식수 인원 관리",
    "공지사항 관리",
    "건의사항 관리",
    "설문조사 관리",
    "AI"
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        sideMenuBarList.length,
        (index) => Container(
          width: 200,
          height: 50,
          child: ListTile(
            onTap: () {},
            tileColor: Colors.lightGreen[400],
            title: Text(
              sideMenuBarList[index],
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }
}
