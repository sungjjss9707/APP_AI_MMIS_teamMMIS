import 'package:admin/size.dart';
import 'package:admin/style.dart';
import 'package:admin/view/components/home/guide_section_1.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final keyList = [
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
    GlobalKey()
  ];

  @override
  Widget build(BuildContext context) {
    double _width = getMediaQueryWidth(context);
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 600,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("food.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Align(
              child: Opacity(
                opacity: 0.7,
                child: Container(
                  padding: EdgeInsets.all(gap_m),
                  width: 800,
                  height: 400,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[300],
                  ),
                  child: Column(
                    children: [
                      Image.asset(
                        "black_logo_transparent.png",
                        height: _width > 540 ? 190 : 150,
                        fit: BoxFit.cover,
                      ),
                      Text(
                        "MMIS 군 급식 정보 체계",
                        style: _width > 540 ? h4() : h5(),
                      ),
                      Divider(),
                      Text(
                        "군 급식 정보 체계 관리자 홈페이지에 오신 것을 환영합니다. 부대원들에게 최고의 급식을 제공하기 위한 플랫폼입니다.",
                        style: h5(),
                        textAlign: TextAlign.center,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(gap_xl),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    "MMIS 관리자 사용가이드",
                    style: h4(),
                  ),
                ),
                SizedBox(
                  height: gap_s,
                ),
                Center(
                  child: Text(
                    "- 다양하고 편리한 MMIS의 기능들을 살펴보세요. -",
                    style: h5(),
                  ),
                ),
                SizedBox(height: gap_xl),
                _outlineButtons(),
                SizedBox(height: gap_xl * 4),
                _guide(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _outlineButtons() {
    return Center(
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 64,
        runSpacing: 24,
        children: [
          OutlinedButton(
            onPressed: () {},
            child: Text("메뉴 관리"),
          ),
          OutlinedButton(
            onPressed: () {},
            child: Text("식수 인원"),
          ),
          OutlinedButton(
            onPressed: () {},
            child: Text("공지사항"),
          ),
          OutlinedButton(
            onPressed: () {},
            child: Text("건의사항"),
          ),
          OutlinedButton(
            onPressed: () {},
            child: Text("설문조사"),
          ),
          OutlinedButton(
            onPressed: () {},
            child: Text("AI 실험실"),
          ),
        ],
      ),
    );
  }

  Widget _guide() {
    return Column(
      children: [
        GuideSection1(
            imageName: "capture_ex.png",
            title: "메뉴 관리",
            content:
                "메뉴 관리에서는 부대 내 식단을 하루, 한달 단위로 관리할 수 있습니다. 뿐만 아니라 새로운 메뉴의 추가도 손쉽게 가능합니다.")
      ],
    );
  }
}
