import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:myapp/model/menu.dart';
import 'package:myapp/view/components/custom_banner.dart';
import 'package:myapp/view/components/button/function_button.dart';
import 'package:myapp/view/components/menu_box.dart';
import 'package:myapp/view/pages/subpages/eating_schedule_page.dart';
import 'package:myapp/view/pages/subpages/notice_page.dart';
import 'package:myapp/view/pages/subpages/suggestion_page.dart';
import 'package:myapp/view/pages/subpages/survey_page.dart';

class HomePage extends StatelessWidget {
  late double length;
  @override
  Widget build(BuildContext context) {
    length = (MediaQuery.of(context).size.width - 32) / 3;
    return ListView(
      children: [
        _menuList(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
    final double size = length / 4;
    return Row(
      children: [
        FunctionButton(
          length: length,
          onTap: () {
            Get.to(() => NoticePage());
          },
          icon: Icon(Icons.campaign, size: size),
          text: "공지사항",
        ),
        SizedBox(width: 8),
        FunctionButton(
          length: length,
          onTap: () {
            Get.to(() => SuggestionPage());
          },
          icon: FaIcon(FontAwesomeIcons.exclamationCircle, size: size),
          text: "건의사항",
        ),
        SizedBox(width: 8),
        FunctionButton(
          length: length,
          onTap: () {
            Get.to(() => SurveyPage());
          },
          icon: FaIcon(FontAwesomeIcons.poll, size: size),
          text: "설문조사",
        ),
      ],
    );
  }

  Widget _buildButtonSet2() {
    final double size = length / 4;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        FunctionButton(
          length: length,
          onTap: () {
            Get.to(EatingSchedulePage());
          },
          icon: Icon(Icons.no_meals, size: size),
          text: "불취식 관리",
        ),
        SizedBox(width: 8),
        FunctionButton(
          length: length,
          onTap: () {},
          icon: Icon(Icons.payment, size: size),
          text: "공제내역",
        ),
        SizedBox(width: 8),
        FunctionButton(
          length: length,
          onTap: () {},
          icon: Icon(Icons.help, size: size),
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
                  "1위. 비엔나 소세지 볶음",
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: 12,
                  ),
                ),
                Text(
                  "2위. 삼계탕",
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: 12,
                  ),
                ),
                Text(
                  "3위. 소고기 미역국",
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
                Text(
                  "찹쌀밥",
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: 12,
                  ),
                ),
                Text(
                  "삼계탕",
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: 12,
                  ),
                ),
                Text(
                  "야채 샐러드",
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: 12,
                  ),
                ),
                Text(
                  "배추김치",
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: 12,
                  ),
                ),
                Text(
                  "요거트",
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: 12,
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
