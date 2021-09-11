import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:myapp/components/custom_banner.dart';
import 'package:myapp/components/function_button.dart';
import 'package:myapp/components/menu_box.dart';
import 'package:myapp/pages/subpages/notice_page.dart';


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        scrollDirection: Axis.vertical,
        children: [
          _menuList(),
          const SizedBox(height: 16),
          Column(
            children: [
              _buildButtonSet1(),
              const SizedBox(height: 16),
              _buildButtonSet2(),
            ],
          ),
          const SizedBox(height: 16),
          CustomBanner(),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _popularMenu(),
              const SizedBox(width: 8),
              _AIRecommendation(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _menuList() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          MenuBox("2021-09-06", "석식"),
          MenuBox("2021-09-07", "석식"),
          MenuBox("2021-09-09", "중식"),
          MenuBox("2021-09-10", "브런치"),
        ],
      ),
    );
  }

  Widget _buildButtonSet1() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        FunctionButton(
          onTap: () {},
          iconData: FontAwesomeIcons.poll,
          text: "설문조사",
        ),
        FunctionButton(
          onTap: () {},
          iconData: FontAwesomeIcons.exclamationCircle,
          text: "건의사항",
        ),
        FunctionButton(
          onTap: () {},
          iconData: FontAwesomeIcons.exclamationCircle,
          text: "불취식 관리",
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
            Get.to(() => NoticePage());
          },
          iconData: FontAwesomeIcons.exclamationCircle,
          text: "공지사항",
        ),
        FunctionButton(
          onTap: () {},
          iconData: FontAwesomeIcons.exclamationCircle,
          text: "공제내역",
        ),
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
