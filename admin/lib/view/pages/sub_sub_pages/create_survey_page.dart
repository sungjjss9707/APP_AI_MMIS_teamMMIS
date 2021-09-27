import 'package:admin/size.dart';
import 'package:admin/util/validators.dart';
import 'package:admin/view/components/home/customTitle.dart';
import 'package:admin/view/components/home/home_header.dart';
import 'package:admin/view/components/survey/survey_question_form_field.dart';
import 'package:admin/view/components/survey/survey_title_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateSurveyPage extends StatefulWidget {
  @override
  _CreateSurveyPageState createState() => _CreateSurveyPageState();
}

class _CreateSurveyPageState extends State<CreateSurveyPage> {
  List<SurveyQuestionFormField> _questionList = [];
  @override
  void initState() {
    _questionList.add(
      SurveyQuestionFormField(
        funValidate: validateTitle(),
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double _width = getMediaQueryWidth(context);
    double _surveyTileWidth = _width * 0.4;
    return Scaffold(
      body: ListView(
        children: [
          HomeHeader(),
          Container(
            width: _width,
            padding: EdgeInsets.all(gap_xl),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CustomTitle("설문조사 생성"),
                    Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text("목록"),
                    ),
                  ],
                ),
                Divider(color: Colors.grey),
                Center(
                  child: Container(
                    width: _surveyTileWidth,
                    child: Column(
                      children: [
                        SurveyTitleFormField(
                          width: _surveyTileWidth,
                          funValidate: validateTitle(),
                        ),
                        SurveyQuestionFormField(
                          funValidate: validateTitle(),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
