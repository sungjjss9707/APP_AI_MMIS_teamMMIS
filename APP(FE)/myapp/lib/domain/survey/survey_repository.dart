import 'package:get/get.dart';
import 'package:myapp/controller/dto/CM_request_dto.dart';
import 'package:myapp/controller/dto/survey_result_request_Dto.dart';
import 'package:myapp/domain/survey/survey_provider.dart';
import 'package:myapp/page_util/convert_utf8.dart';

class SurveyRepository {
  SurveyProvider _surveyProvider = SurveyProvider();

  Future<int> reportAnswer(List<SurveyResultDto> answers) async {
    List data = [];
    for (SurveyResultDto surveyResultDto in answers) {
      data.add(surveyResultDto.toJson());
    }
    Response response = await _surveyProvider.reportAnswer(data);
    dynamic body = response.body;
    dynamic convertBody = convertUtf8ToObject(body);
    CMRespDto cmRespDto = CMRespDto.fromJson(convertBody);
    if (cmRespDto.code == 1) {
      return 1;
    }
    return -1;
  }
}
