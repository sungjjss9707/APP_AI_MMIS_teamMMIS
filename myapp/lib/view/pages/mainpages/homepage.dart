import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:myapp/controller/diet_controller.dart';
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
  //나중에 로그인할 때 불러오는 걸로 하자.
  final diet = Get.put(DietController());
  final DateTime now = DateTime.now();
  late String nowYear;
  late String nowMonth;
  late String nowDay;
  late int nowTime;
  final List<String> time = ["조식", "중식", "석식"];

  @override
  void initState() {
    nowYear = now.year.toString();
    nowMonth = now.month.toString();
    nowDay = now.day.toString();
    nowTime = now.hour > 0 && now.hour < 9
        ? 0
        : now.hour < 13
            ? 1
            : 2;
    super.initState();
  }

  Widget build(BuildContext context) {
    return ListView(
      children: [
        _menuList(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: _functionButtons(),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: CustomBanner(),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: _recommendation(),
        ),
      ],
    );
  }

  Widget _menuList() {
    Map<String, List<String>> menuMap = _createMenuList();
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(
            menuMap.length,
            (index) {
              return MenuBox(menuMap.keys.toList()[index],
                  menuMap.values.toList()[index], menuMap);
            },
          ),
        ),
      ),
    );
  }

  Widget _functionButtons() {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Column(
        children: [
          _buildButtonSet1(),
          SizedBox(height: 16.h),
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
        SizedBox(width: 8.w),
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
        SizedBox(width: 8.w),
        FunctionButton(
          onTap: () {
            Get.to(() => DeductionPage());
          },
          icon: Icons.payment,
          text: "공제내역",
        ),
        SizedBox(width: 8.w),
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
        Expanded(flex: 1, child: _popularMenu()),
        SizedBox(width: 8.w),
        Expanded(flex: 1, child: _AIRecommendation()),
      ],
    );
  }

  Widget _popularMenu() {
    return Container(
      padding: EdgeInsets.all(8.r),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10.r),
      ),
      height: 200.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "우리 부대 인기 메뉴는?",
            style: TextStyle(
              decoration: TextDecoration.underline,
              fontSize: 12.sp,
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
                    fontSize: 10.sp,
                  ),
                ),
                Text(
                  "2위. ${popularMenu["second"]}",
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: 10.sp,
                  ),
                ),
                Text(
                  "3위. ${popularMenu["third"]}",
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: 10.sp,
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
      padding: EdgeInsets.all(8.r),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10.r),
      ),
      height: 200.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "AI가 추전해주는 부대 식단!",
            style: TextStyle(
              decoration: TextDecoration.underline,
              fontSize: 12.sp,
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
                      fontSize: 10.sp,
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

  Map<String, List<String>> _createMenuList() {
    int count = -2;
    Map<String, List<String>> result = {};
    while (count <= 2) {
      DateTime particularDay = now.add(Duration(days: count));
      result[
          "${particularDay.year}/${particularDay.month}/${particularDay.day}/조식"] = diet
                  .dietsConvert[
              "${particularDay.year}/${particularDay.month}/${particularDay.day}/조식"] ??
          [];
      if (diet.dietsConvert[
              "${particularDay.year}/${particularDay.month}/${particularDay.day}/브런치"] !=
          null)
        result[
            "${particularDay.year}/${particularDay.month}/${particularDay.day}/브런치"] = diet
                .dietsConvert[
            "${particularDay.year}/${particularDay.month}/${particularDay.day}/브런치"]!;
      result[
          "${particularDay.year}/${particularDay.month}/${particularDay.day}/중식"] = diet
                  .dietsConvert[
              "${particularDay.year}/${particularDay.month}/${particularDay.day}/중식"] ??
          [];
      result[
          "${particularDay.year}/${particularDay.month}/${particularDay.day}/석식"] = diet
                  .dietsConvert[
              "${particularDay.year}/${particularDay.month}/${particularDay.day}/석식"] ??
          [];
      count += 1;
    }

    return result;
  }
}
