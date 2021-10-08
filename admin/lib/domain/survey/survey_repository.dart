import 'package:admin/controller/dto/CM_request_dto.dart';
import 'package:admin/controller/dto/survey_post_dto.dart';

import 'package:admin/domain/survey/survey_provider.dart';
import 'package:admin/util/convert_utf8.dart';
import 'package:admin/view/components/survey/survey_question_form_field.dart';
import 'package:get/get.dart';

class SurveyRepository {
  final SurveyProvider _surveyProvider = SurveyProvider();
  Future<int> postSurvey(String title, String explain, List<SurveyQuestionFormField> questions) async {
    SurveyPostDto surveyPostDto = SurveyPostDto(title, explain, questions);
    Response response = await _surveyProvider.postSurvey(surveyPostDto.toJson());
    dynamic body = response.body;
    dynamic convertBody = convertUtf8ToObject(body);
    CMRespDto cmRespDto = CMRespDto.fromJson(convertBody);
    if(cmRespDto.code == 1){
      return 1;
    }else return -1;
  }


}
