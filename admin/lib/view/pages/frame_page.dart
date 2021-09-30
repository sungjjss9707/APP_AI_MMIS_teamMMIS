import 'package:admin/style.dart';
import 'package:admin/view/pages/login_page.dart';

import 'package:admin/view/pages/subpages/AI_page.dart';
import 'package:admin/view/pages/subpages/home_page.dart';
import 'package:admin/view/pages/subpages/manage_the_number_eating_page.dart';
import 'package:admin/view/pages/subpages/menu_manage_page.dart';
import 'package:admin/view/pages/subpages/notice_page.dart';
import 'package:admin/view/pages/subpages/suggestion_page.dart';
import 'package:admin/view/pages/subpages/survey_page.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../size.dart';

class FramePage extends StatefulWidget {
  @override
  _FramePageState createState() => _FramePageState();
}

class _FramePageState extends State<FramePage> {
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
  final List<FaIcon> pageIcon = [
    FaIcon(Icons.home),
    FaIcon(Icons.food_bank),
    FaIcon(Icons.no_food),
    FaIcon(Icons.campaign),
    FaIcon(FontAwesomeIcons.exclamationCircle),
    FaIcon(FontAwesomeIcons.poll),
    FaIcon(FontAwesomeIcons.robot),
  ];
  late bool openSideBar;
  late int _selectedTapIndex;

  @override
  void initState() {
    openSideBar = false;
    _selectedTapIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: _buildAppBar(),
      body: Row(
        children: [
          openSideBar == true ? _sideMenuBar() : Container(),
          Expanded(
            child: ListView(
              children: [
                //HomeHeader(),
                Align(
                  child: SizedBox(
                    width: openSideBar == true ? _width - 200 : _width,
                    child: Padding(
                      padding: const EdgeInsets.all(gap_xl),
                      child: pageList[_selectedTapIndex],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      leading: IconButton(
          onPressed: () {
            setState(() {
              if (openSideBar == false)
                openSideBar = true;
              else
                openSideBar = false;
            });
          },
          icon: Icon(
            Icons.menu,
            color: Colors.black,
          )),
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
            leading: pageIcon[index],
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
