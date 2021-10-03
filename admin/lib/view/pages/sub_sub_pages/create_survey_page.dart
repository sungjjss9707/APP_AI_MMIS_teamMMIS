import 'package:admin/controller/survey_controller.dart';
import 'package:admin/size.dart';
import 'package:admin/util/validators.dart';
import 'package:admin/view/components/home/customTitle.dart';

import 'package:admin/view/components/survey/survey_question_form_field.dart';
import 'package:admin/view/components/survey/survey_title_form_field.dart';
import 'package:admin/view/pages/frame_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../style.dart';
import '../login_page.dart';

class CreateSurveyPage extends StatefulWidget {
  const CreateSurveyPage({Key? key}) : super(key: key);
  @override
  _CreateSurveyPageState createState() => _CreateSurveyPageState();
}

class _CreateSurveyPageState extends State<CreateSurveyPage> {
  SurveyController s = Get.put(SurveyController());
  late SurveyTitleFormField surveyTitleFormField;

  @override
  void initState() {
    s.questions.clear();
    s.questions.add(
      SurveyQuestionFormField(
        index: 0,
        funValidate: validateTitle(),
      ),
    );

    surveyTitleFormField = SurveyTitleFormField();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double _width = getMediaQueryWidth(context);
    return Scaffold(
      appBar: AppBar(
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
      ),
      body: ListView(
        children: [
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
                        _getData();
                      },
                      child: Text("올리기"),
                    ),
                    SizedBox(width: gap_m),
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
                        surveyTitleFormField,
                        _addAndRemoveQuestionForTitle(),
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

  void _getData() {
    s.title!.value = surveyTitleFormField.titleController.text;
    s.explain!.value = surveyTitleFormField.explainController.text;
    print("----------");
    print(s.title);
    print(s.explain);
    print("s.questions : ${s.questions.length}");
    for (SurveyQuestionFormField i in s.questions) {
      print(i.questionController.text);
      print(i.isCompulsory);
      print("int ${i.selectedValue}");
      if (i.selectedValue == 1) {
        print(i.singleChoice);
        print(i.singleChoice.textEditingControllers.length);
        for (TextEditingController j in i.singleChoice.textEditingControllers) {
          print(j.text);
        }
      } else if (i.selectedValue == 2) {
        print(i.multipleChoice);
        print(i.multipleChoice.textEditingControllers.length);
        for (TextEditingController j
            in i.multipleChoice.textEditingControllers) {
          print(j.text);
        }
      }
    }
    print("-----");
  }

  void _addSurveyQuestionFormField() {
    setState(() {
      s.questions.add(
          SurveyQuestionFormField(key: UniqueKey(), index: s.questions.length));
    });
  }

  void _removeSurveyQuestionFormField(int index) {
    setState(() {
      s.questions.removeAt(index);
      for (SurveyQuestionFormField i in s.questions) {
        i.index = s.questions.indexOf(i);
      }
    });
  }

  List<Widget> _buildQuestionList() {
    return List.generate(s.questions.length, (index) {
      return Column(
        children: [s.questions[index], _addAndRemoveQuestion(index)],
      );
    });
  }

  Widget _addAndRemoveQuestionForTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            _addSurveyQuestionFormField();
          },
        ),
      ],
    );
  }

  Widget _addAndRemoveQuestion(int index) {
    return Row(
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
    );
  }
}
