import 'package:admin/controller/dto/CM_request_dto.dart';
import 'package:admin/controller/dto/survey_post_dto.dart';
import 'package:admin/domain/survey/survey.dart';

import 'package:admin/domain/survey/survey_provider.dart';
import 'package:admin/util/convert_utf8.dart';
import 'package:admin/view/components/survey/survey_question_form_field.dart';
import 'package:get/get.dart';

class SurveyRepository {
  final SurveyProvider _surveyProvider = SurveyProvider();
  Future<int> postSurvey(String title, String explain, String seq,
      List<SurveyQuestionFormField> questions) async {
    SurveyPostDto surveyPostDto = SurveyPostDto(title, explain, seq, questions);
    Response response =
        await _surveyProvider.postSurvey(surveyPostDto.toJson());

    dynamic body = response.body;
    dynamic convertBody = convertUtf8ToObject(body);
    CMRespDto cmRespDto = CMRespDto.fromJson(convertBody);
    if (cmRespDto.code == 1) {
      return 1;
    } else
      return -1;
  }

  Future<List<Survey>> findAll() async {
    Response response = await _surveyProvider.findAll();
    dynamic body = response.body;
    dynamic convertBody = convertUtf8ToObject(body);
    CMRespDto cmRespDto = CMRespDto.fromJson(convertBody);
    if (cmRespDto.code == 1) {
      List<dynamic> temp = cmRespDto.data;
      List<Survey> surveys =
          temp.map((survey) => Survey.fromJson(survey)).toList();
      return surveys;
    } else
      return <Survey>[];
  }

  Future<Survey> findById(int id) async {
    Response response = await _surveyProvider.findById(id);
    dynamic body = response.body;
    dynamic convertBody = convertUtf8ToObject(body);
    CMRespDto cmRespDto = CMRespDto.fromJson(convertBody);
    if (cmRespDto.code == 1) {
      Survey survey = Survey.fromJson(cmRespDto.data);
      return survey;
    } else
      return Survey();
  }
}
