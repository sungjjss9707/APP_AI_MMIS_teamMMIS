import 'package:admin/style.dart';
import 'package:admin/view/pages/login_page.dart';

import 'package:admin/view/pages/subpages/AI_page.dart';
import 'package:admin/view/pages/subpages/home_page.dart';
import 'package:admin/view/pages/subpages/manage_the_number_eating_page.dart';
import 'package:admin/view/pages/subpages/menu_manage_page.dart';
import 'package:admin/view/pages/subpages/notice_page.dart';
import 'package:admin/view/pages/subpages/suggestion_page.dart';
import 'package:admin/view/pages/subpages/survey_page.dart';
import 'package:collapsible_sidebar/collapsible_sidebar.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../size.dart';

final List<String> sideMenuBarList = [
  "홈",
  "메뉴 관리",
  "식수 인원",
  "공지사항",
  "건의사항",
  "설문조사",
  "AI 실험실"
];

final List<Widget> pageList = [
  HomePage(),
  MenuManagePage(),
  ManageTheNumberEatingPage(),
  NoticePage(),
  SuggestionPage(),
  SurveyPage(),
  AIPage(),
];
final List<IconData> pageIcon = [
  Icons.home,
  Icons.food_bank,
  Icons.no_food,
  Icons.campaign,
  FontAwesomeIcons.exclamationCircle,
  FontAwesomeIcons.poll,
  FontAwesomeIcons.robot,
];

class FramePage extends StatefulWidget {
  @override
  _FramePageState createState() => _FramePageState();
}

class _FramePageState extends State<FramePage> {
  late bool openSideBar;
  late int _selectedTapIndex;

  @override
  void initState() {
    openSideBar = false;
    _selectedTapIndex = 6;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: _buildAppBar(),
      body: CollapsibleSidebar(
        items: _generateCollapsibleItem(),
        body: _body(),
        title: "관리자",
        toggleTitle: "접기",
        backgroundColor: Colors.lightGreen,
        selectedIconBox: Colors.lightGreen[800]!,
        selectedIconColor: Colors.green,
        selectedTextColor: Colors.white,
        unselectedIconColor: Colors.white,
        unselectedTextColor: Colors.white60,
        sidebarBoxShadow: [
          BoxShadow(
            color: Colors.green,
            blurRadius: 10,
            spreadRadius: 0.01,
            offset: Offset(3, 3),
          ),
        ],
      ),
    );
  }

  List<CollapsibleItem> _generateCollapsibleItem() {
    return List.generate(
      7,
      (index) => CollapsibleItem(
          text: sideMenuBarList[index],
          icon: pageIcon[index],
          onPressed: () {
            setState(() {
              _selectedTapIndex = index;
            });
          },
          isSelected: index == _selectedTapIndex ? true : false),
    );
  }

  Widget _body() {
    return ListView(
      children: [
        _selectedTapIndex == 0
            ? pageList[_selectedTapIndex]
            : Padding(
                padding: const EdgeInsets.all(gap_xl),
                child: pageList[_selectedTapIndex],
              ),
      ],
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      title: InkWell(
        onTap: () {
          Get.offAll(() => FramePage());
        },
        child: Text(
          "MMIS",
          style: h4(),
        ),
      ),
      actions: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                Get.offAll(() => LoginPage());
              },
              child: Text("로그아웃", style: h5()),
            ),
          ],
        ),
        SizedBox(width: gap_s),
      ],
    );
  }
}
