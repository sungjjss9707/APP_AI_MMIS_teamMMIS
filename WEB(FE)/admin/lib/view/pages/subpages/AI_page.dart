import 'package:admin/controller/ai_controller.dart';
import 'package:admin/domain/AI/ai.dart';
import 'package:admin/size.dart';
import 'package:admin/style.dart';
import 'package:admin/view/components/ai/ai_menu_input_form.dart';
import 'package:admin/view/components/button/custom_elevated_button.dart';
import 'package:admin/view/components/home/customTitle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

// AI 이용 페이지
class AIPage extends StatefulWidget {
  @override
  _AIPageState createState() => _AIPageState();
}

class _AIPageState extends State<AIPage> {
  final AIController ai = Get.put(AIController());
  final AIMenuInputForm _aiMenuInputForm = AIMenuInputForm();
  late bool yesInput;
  @override
  void initState() {
    yesInput = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double _width = getMediaQueryWidth(context);
    return Padding(
      padding: _width < 540
          ? const EdgeInsets.all(gap_m)
          : const EdgeInsets.all(gap_xl),
      child: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTitle("AI 실험실"),
              Divider(color: Colors.grey),
              Center(
                child: Column(
                  children: [
                    Text(
                      "급식이 1.0.0",
                      style: h5(),
                    ),
                    SizedBox(height: gap_s),
                    Container(
                      width: 500,
                      child: Text(
                        "급식이 1.0.0은 급식 관리자들이 메뉴를 구성할 때, 도와주는 인공지능 모델입니다. 식단을 입력하면, 부대원들에 대한 이 식단의 적합도(1 ~ 5점)와 대체 추천 식단을 구해 줍니다. 구성한 식단을 테스트해보세요.",
                        style: body1_grey(),
                      ),
                    ),
                    SizedBox(height: gap_xl),
                    yesInput == true ? _buildInputMenu() : _buildResult(),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInputMenu() {
    return Container(
      padding: const EdgeInsets.all(gap_m),
      width: 400,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text(
            "테스트하고 싶은 식단을 입력하세요.(최대 7개)",
            style: subtitle1(),
          ),
          SizedBox(height: gap_s),
          _aiMenuInputForm,
          CustomElevatedButton(
            onPressed: () async {
              if (_aiMenuInputForm.formKey.currentState!.validate()) {
                // List<String> menus = _aiMenuInputForm.menuInputTextField
                //     .map((e) => e.controller.text.trim())
                //     .toList();
                //통신할 때, 활성화
                // await ai.getRecommendedMenus(menus);
                setState(() {
                  yesInput = false;
                });
              }
            },
            text: "입력 !",
            width: double.infinity,
          )
        ],
      ),
    );
  }

  Widget _buildResult() {
    return Obx(
      () => Container(
        child: Wrap(
          alignment: WrapAlignment.center,
          spacing: 60,
          runSpacing: 10,
          children: [
            Padding(
              padding: const EdgeInsets.all(gap_s),
              child: Container(
                width: 400,
                height: 400,
                padding: const EdgeInsets.all(gap_m),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Text(
                      "이 식단의 점수는?",
                      style: h4(),
                    ),
                    Spacer(),
                    Text(
                      "${ai.principal.value.score ?? 3}점",
                      style: TextStyle(
                          fontSize: 60,
                          fontWeight: FontWeight.bold,
                          color: ai.principal.value.score == null
                              ? Colors.black
                              : ai.principal.value.score! > 3
                                  ? Colors.green
                                  : ai.principal.value.score! > 2
                                      ? Colors.amber
                                      : Colors.red),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "보통 ",
                          style: TextStyle(
                              fontSize: 60,
                              fontWeight: FontWeight.bold,
                              color: ai.principal.value.score == null
                                  ? Colors.black
                                  : ai.principal.value.score! > 3
                                      ? Colors.green
                                      : ai.principal.value.score! > 2
                                          ? Colors.amber
                                          : Colors.red),
                        ),
                        FaIcon(
                          // 보통은 meh, 별로는 frown
                          FontAwesomeIcons.meh,
                          size: 60,
                          color: ai.principal.value.score == null
                              ? Colors.black
                              : ai.principal.value.score! > 3
                                  ? Colors.green
                                  : ai.principal.value.score! > 2
                                      ? Colors.amber
                                      : Colors.red,
                        ),
                      ],
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(gap_s),
              child: Container(
                width: 400,
                height: 400,
                padding: const EdgeInsets.all(gap_m),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Text(
                      "추천식단",
                      style: h4(),
                    ),
                    Text(
                      "다음 식단은 어떠신가요?",
                      style: subtitle1(),
                    ),
                    Flexible(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: _dummyRecommendedDiets(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Recommendation> dummyRecommendations = [
    Recommendation(
      score: 5,
      menus: ["찰밥", "닭강정", "야채샐러드", "배추김치", "돼지김치찌개"],
    ),
    Recommendation(
      score: 4,
      menus: ["보리밥", "안동찜닭", "야채샐러드", "배추김치", "어묵탕"],
    ),
    Recommendation(
      score: 4,
      menus: ["쌀밥", "닭튀김", "콩나물무침", "배추김치", "버섯된장찌개"],
    ),
    Recommendation(
      score: 4,
      menus: ["쌀밥", "닭튀김", "어묵볶음", "오이소박이", "김치찜"],
    ),
  ];

  Widget _dummyRecommendedDiets() {
    return Column(
      children: List.generate(dummyRecommendations.length, (index) {
        Recommendation recommendation = dummyRecommendations[index];
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    children: recommendation.menus!
                        .map((menu) => Text(menu, style: body1()))
                        .toList(),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Center(
                      child: Text(
                        "${recommendation.score}점",
                        style: subtitle1(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Divider(color: Colors.grey),
          ],
        );
      }),
    );
  }

// 통신 될 경우 이거로 하면 됨.
  Widget _recommendedDiets() {
    return Obx(
      () => Column(
        children: List.generate(ai.principal.value.getRecommendation().length,
            (index) {
          Recommendation recommendation =
              ai.principal.value.getRecommendation()[index];
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: recommendation.menus!
                        .map((menu) => Text(menu))
                        .toList(),
                  ),
                  Text("${recommendation.score}점"),
                ],
              ),
              Divider(color: Colors.grey),
            ],
          );
        }),
      ),
    );
  }
}
