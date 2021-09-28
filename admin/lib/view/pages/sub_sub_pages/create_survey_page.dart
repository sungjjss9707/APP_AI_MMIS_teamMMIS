import 'package:admin/size.dart';
import 'package:admin/util/validators.dart';
import 'package:admin/view/components/home/customTitle.dart';
import 'package:admin/view/components/home/home_header.dart';
import 'package:admin/view/components/survey/survey_question_form_field.dart';
import 'package:admin/view/components/survey/survey_title_form_field.dart';
import 'package:flutter/cupertino.dart';
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
        key: UniqueKey(),
        index: 0,
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
              crossAxisAlignment: CrossAxisAlignment.center,
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
                Column(
                  children: <Widget>[
                        SurveyTitleFormField(
                          width: _surveyTileWidth,
                          funValidate: validateTitle(),
                        ),
                      ] +
                      _buildQuestionList(),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _addSurveyQuestionFormField() {
    setState(() {
      _questionList.add(SurveyQuestionFormField(
          key: UniqueKey(), index: _questionList.length));
    });
  }

  void _removeSurveyQuestionFormField(int index) {
    setState(() {
      _questionList.removeAt(index);
      for (SurveyQuestionFormField i in _questionList) {
        i.index = _questionList.indexOf(i);
      }
    });
  }

  List<Widget> _buildQuestionList() {
    return List.generate(_questionList.length, (index) {
      return Column(
        children: [
          _questionList[index],
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  _addSurveyQuestionFormField();
                },
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  _removeSurveyQuestionFormField(index);
                },
              )
            ],
          )
        ],
      );
    });
  }
}
