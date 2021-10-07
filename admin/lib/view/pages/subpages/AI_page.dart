import 'package:admin/controller/ai_controller.dart';
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
    return Column(
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
                  "급식이 1.0.0은 급식 관리자들이 메뉴를 구성할 때, 도와주는 인공지능 모델입니다. 식단을 입력하면, 부대원들에 대한 이 식단의 적합도와 대체 추천 식단을 구해 줍니다. 구성한 식단을 테스트해보세요.",
                  style: body1_grey(),
                ),
              ),
              SizedBox(height: yesInput == true ? gap_xl : gap_xl * 2),
              yesInput == true ? _buildInputMenu() : _buildResult(),
            ],
          ),
        ),
      ],
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
            "테스트하고 싶은 식단을 입력하세요.",
            style: subtitle1(),
          ),
          SizedBox(height: gap_s),
          _aiMenuInputForm,
          CustomElevatedButton(
            onPressed: () {
              if (_aiMenuInputForm.formKey.currentState!.validate()) {}
              setState(() {
                yesInput = false;
              });
            },
            text: "입력 !",
            width: double.infinity,
          )
        ],
      ),
    );
  }

  Widget _buildResult() {
    return Container(
      child: Wrap(
        alignment: WrapAlignment.center,
        children: [
          Container(
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
                  "94점",
                  style: TextStyle(
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                      color: Colors.lightGreen),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "좋음 ",
                      style: TextStyle(
                          fontSize: 60,
                          fontWeight: FontWeight.bold,
                          color: Colors.lightGreen),
                    ),
                    FaIcon(
                      // 보통은 meh, 별로는 frown
                      FontAwesomeIcons.smile,
                      size: 60,
                      color: Colors.lightGreen,
                    ),
                  ],
                ),
                Spacer(),
              ],
            ),
          ),
          SizedBox(width: gap_xl),
          Container(
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
                    child: _recommendedDiets(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _recommendedDiets() {
    return Column(
      children: List.generate(
          4,
          (index) => Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text("밥"),
                          Text("된장국"),
                          Text("돼지불고기"),
                          Text("야채샐러드"),
                          Text("깍두기"),
                          Text("사과"),
                        ],
                      ),
                      Text("95점"),
                    ],
                  ),
                  Divider(color: Colors.grey),
                ],
              )),
    );
  }
}
