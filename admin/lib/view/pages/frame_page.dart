import 'package:admin/controller/admin_controller.dart';
import 'package:admin/style.dart';
import 'package:admin/view/pages/login_page.dart';

import 'package:admin/view/pages/subpages/AI_page.dart';
import 'package:admin/view/pages/subpages/home_page.dart';
import 'package:admin/view/pages/subpages/manage_the_number_eating_page.dart';
import 'package:admin/view/pages/subpages/diet_manage_page.dart';
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
  DietManagePage(),
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
  final scrollController = ScrollController();
  late bool isCollapsed;
  late int _selectedTapIndex;

  @override
  void initState() {
    isCollapsed = true;
    _selectedTapIndex = 0;

    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final a = Get.put(AdministerController());
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: Scaffold(
        appBar: _buildAppBar(),
        body: CollapsibleSidebar(
          isCollapsed: isCollapsed,
          fitItemsToBottom: true,
          items: _generateCollapsibleItem(),
          body: _body(),
          title: "${a.principal.value.username}",
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
              isCollapsed = true;
            });
          },
          isSelected: index == _selectedTapIndex ? true : false),
    );
  }

  Widget _body() {
    return Container(
      margin: EdgeInsets.all(gap_xs),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 10,
            spreadRadius: 0.01,
            offset: Offset(3, 3),
          ),
        ],
      ),
      child: pageList[_selectedTapIndex],
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
