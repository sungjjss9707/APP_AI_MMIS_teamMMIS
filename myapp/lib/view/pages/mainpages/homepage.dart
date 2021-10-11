import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:myapp/model/menu.dart';
//import 'package:myapp/model/diet.dart';
import 'package:myapp/model/popular_menu.dart';
import 'package:myapp/view/components/custom_banner.dart';
import 'package:myapp/view/components/button/function_button.dart';
import 'package:myapp/view/components/menu_box.dart';
import 'package:myapp/view/pages/subpages/ai_test_page.dart';
import 'package:myapp/view/pages/subpages/allergy_info_page.dart';
import 'package:myapp/view/pages/subpages/deduction_page.dart';
import 'package:myapp/view/pages/subpages/notice_page.dart';
import 'package:myapp/view/pages/subpages/suggestion_page.dart';
import 'package:myapp/view/pages/subpages/survey_page.dart';

import '../../../model/ai_recommend.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget build(BuildContext context) {
    return ListView(
      children: [
        _menuList(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: _functionButtons(),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: CustomBanner(),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: _recommendation(),
        ),
      ],
    );
  }

  Widget _menuList() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(
            dummyMenu.length,
            (index) => MenuBox(
              dummyMenu[index].date,
              dummyMenu[index].time,
            ),
          ),
        ),
      ),
    );
  }

  Widget _functionButtons() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        children: [
          _buildButtonSet1(),
          SizedBox(height: 16),
          _buildButtonSet2(),
        ],
      ),
    );
  }

  Widget _buildButtonSet1() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        FunctionButton(
          onTap: () {
            Get.to(() => NoticePage());
          },
          icon: Icons.campaign,
          text: "공지사항",
        ),
        SizedBox(width: 8),
        FunctionButton(
          onTap: () {
            Get.to(() => SuggestionPage());
          },
          icon: FontAwesomeIcons.exclamationCircle,
          text: "건의사항",
        ),
        SizedBox(width: 8),
        FunctionButton(
          onTap: () {
            Get.to(() => SurveyPage());
          },
          icon: FontAwesomeIcons.poll,
          text: "설문조사",
        ),
      ],
    );
  }

  Widget _buildButtonSet2() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        FunctionButton(
          onTap: () {
            Get.to(AiTestPage());
          },
          icon: Icons.no_meals,
          text: "AI 실험실",
        ),
        SizedBox(width: 8),
        FunctionButton(
          onTap: () {
            Get.to(() => DeductionPage());
          },
          icon: Icons.payment,
          text: "공제내역",
        ),
        SizedBox(width: 8),
        FunctionButton(
          onTap: () {
            Get.to(() => AllergyInfoPage());
          },
          icon: Icons.help,
          text: "알레르기 정보",
        )
      ],
    );
  }

  Widget _recommendation() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _popularMenu(),
        SizedBox(width: 8),
        _AIRecommendation(),
      ],
    );
  }

  Widget _popularMenu() {
    return Container(
      height: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "우리 부대 인기 메뉴는?",
            style: TextStyle(
              decoration: TextDecoration.underline,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "1위. ${popularMenu["first"]}",
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: 12,
                  ),
                ),
                Text(
                  "2위. ${popularMenu["second"]}",
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: 12,
                  ),
                ),
                Text(
                  "3위. ${popularMenu["third"]}",
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _AIRecommendation() {
    return Container(
      height: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "AI가 추전해주는 부대 식단!",
            style: TextStyle(
              decoration: TextDecoration.underline,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...aiRecommend.map(
                  (value) => Text(
                    value,
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 12,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
