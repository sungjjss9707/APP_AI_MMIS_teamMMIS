import 'package:admin/view/pages/subpages/AI_page.dart';
import 'package:admin/view/pages/subpages/manage_the_number_eating_page.dart';
import 'package:admin/view/pages/subpages/menu_manage_page.dart';
import 'package:admin/view/pages/subpages/notice_page.dart';
import 'package:admin/view/pages/subpages/suggestion_page.dart';
import 'package:admin/view/pages/subpages/survey_page.dart';
import 'package:flutter/material.dart';

class HomeBody extends StatefulWidget {
  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  int _selectedTapIndex = 2;

  final List<String> sideMenuBarList = [
    "메뉴 입력",
    "식수 인원 관리",
    "공지사항 관리",
    "건의사항 관리",
    "설문조사 관리",
    "AI 실험실"
  ];

  final List<Widget> pageList = [
    MenuManagePage(),
    ManageTheNumberEatingPage(),
    NoticePage(),
    SuggestionPage(),
    SurveyPage(),
    AIPage(),
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Align(
      child: SizedBox(
        width: width,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sideMenuBar(),
            pageList[_selectedTapIndex],
          ],
        ),
      ),
    );
  }

  Widget _sideMenuBar() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: List.generate(
        sideMenuBarList.length,
        (index) => Container(
          width: 200,
          height: 50,
          child: ListTile(
            onTap: () {
              setState(() {
                _selectedTapIndex = index;
              });
            },
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
