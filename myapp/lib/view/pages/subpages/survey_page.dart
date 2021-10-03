import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/model/survey.dart';
import 'package:myapp/view/components/appBar/sub_page_appbar.dart';
import 'package:myapp/view/components/custom_drawer.dart';
import 'package:myapp/view/components/textfield/custom_text_form_field_search.dart';
import 'package:myapp/view/pages/subpages/do_survey_page.dart';

class SurveyPage extends StatefulWidget {
  @override
  _SurveyPageState createState() => _SurveyPageState();
}

class _SurveyPageState extends State<SurveyPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: subPageAppBar("설문조사"),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: const CustomTextFormFieldSearch(
                hint: "제목으로 검색해 보세요.",
              ),
            ),
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  Survey survey = dummySurvey[index];
                  return InkWell(
                    onTap: () {
                      Get.to(() => DoSurveyPage());
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

class Notice {}
