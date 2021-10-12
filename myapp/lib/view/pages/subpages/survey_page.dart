import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/domain/survey/survey.dart';
import 'package:myapp/model/survey.dart';
import 'package:myapp/view/components/appBar/sub_page_appbar.dart';
import 'package:myapp/view/components/custom_drawer.dart';
import 'package:myapp/view/pages/subpages/do_survey_page.dart';

class SurveyPage extends StatefulWidget {
  @override
  _SurveyPageState createState() => _SurveyPageState();
}

class _SurveyPageState extends State<SurveyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: subPageAppBar("설문조사"),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  DummySurvey survey = dummySurvey[index];
                  return InkWell(
                    onTap: () {
                      //통신 받아서 ,RealSurvey로 전달 (이름 나중에 Survey로 바꾸자!)
                      Get.to(
                        () => DoSurveyPage(
                          Survey.fromJson(DumSurvey),
                        ),
                      );
                    },
                    child: ListTile(
                      title: Text(
                        "${survey.title}",
                      ),
                      // trailing: Text(notice.writer),
                      subtitle: Text(survey.date),
                      trailing: Text("관리자"),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider(
                    color: Colors.grey,
                  );
                },
                itemCount: dummySurvey.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
