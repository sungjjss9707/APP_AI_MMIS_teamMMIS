// 공지사항 관리 페이지

import 'package:admin/model/survey.dart';
import 'package:admin/size.dart';
import 'package:admin/view/components/button/custom_elevated_button.dart';
import 'package:admin/view/components/home/customTitle.dart';
import 'package:admin/view/pages/sub_sub_pages/create_survey_page.dart';
import 'package:admin/view/pages/sub_sub_pages/survey_result_page.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:number_pagination/number_pagination.dart';

import '../../../style.dart';

class SurveyPage extends StatefulWidget {
  @override
  _SurveyPageState createState() => _SurveyPageState();
}

class _SurveyPageState extends State<SurveyPage> {
  late int _currentPage;
  List<FakeSurvey> _dummySurvey = dummySurvey;

  @override
  void initState() {
    _currentPage = 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _width = getMediaQueryWidth(context);
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
              CustomTitle("설문조사"),
              Divider(color: Colors.grey),
              _width > 850 ? _contentHeader() : Container(),
              _surveyList(context, _width),
              _buildNewSurveyButton(),
              _numberPagination(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _contentHeader() {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Container(
            child: Center(
              child: Text(
                "번호",
                style: subtitle1(),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 8,
          child: Container(
            child: Center(
              child: Text(
                "제목",
                style: subtitle1(),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Container(
            child: Center(
              child: Text(
                "작성자",
                style: subtitle1(),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            child: Center(
              child: Text(
                "작성날짜",
                style: subtitle1(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _surveyList(BuildContext context, double mediaWidth) {
    String title = '';
    String writer = '';
    String date = '';
    return Column(
      children: List.generate(15, (int index) {
        index += 15 * (_currentPage - 1);
        try {
          FakeSurvey survey = dummySurvey[index];

          return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: InkWell(
                onTap: () {
                  Get.to(
                    () => SurveyResultPage(
                      title: survey.title,
                      date: survey.date,
                      questionSets: survey.questionSets,
                      writer: survey.writer,
                    ),
                  );
                },
                child: mediaWidth > 850
                    ? _contentForWide(
                        index, survey.title, survey.writer, survey.date)
                    : _contentForNarrow(
                        index, survey.title, survey.writer, survey.date),
              ));
        } catch (e) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: InkWell(
              child: _contentForWide(index, title, writer, date),
            ),
          );
        }
      }),
    );
  }

  Widget _buildNewSurveyButton() {
    return Row(
      children: [
        Spacer(),
        CustomElevatedButton(
          textSize: 20,
          text: "새 설문조사 생성",
          onPressed: () {
            Get.to(() => CreateSurveyPage(
                  key: UniqueKey(),
                ));
          },
        ),
      ],
    );
  }

  Widget _numberPagination() {
    return NumberPagination(
      listner: (int selectedPage) {
        setState(() {
          _currentPage = selectedPage;
        });
      },
      totalPage: _dummySurvey.length % 15 == 0
          ? _dummySurvey.length ~/ 15
          : _dummySurvey.length ~/ 15 + 1,
      currentPage: _currentPage,
    );
  }

  Row _contentForWide(int index, String title, String writer, String date) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Container(
            height: 30,
            child: Center(
              child: Text(
                title == "" ? "" : "${index + 1}",
                style: body1(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 8,
          child: Container(
            height: 30,
            child: Center(
              child: Text(
                "$title",
                style: body1(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Container(
            height: 30,
            child: Center(
              child: Text(
                "$writer",
                style: body1(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            height: 30,
            child: Center(
              child: Text(
                "$date",
                style: body1(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _contentForNarrow(
      int index, String title, String writer, String date) {
    return ListTile(
      title: Text(
        "${index + 1} $title",
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        date,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Text(
        writer,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
