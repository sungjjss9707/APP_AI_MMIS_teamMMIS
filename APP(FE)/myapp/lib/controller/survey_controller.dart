import 'package:get/get.dart';
import 'package:myapp/domain/survey/survey.dart';
import 'package:myapp/domain/survey/survey_repository.dart';
import 'package:survey_kit/survey_kit.dart';

import 'dto/survey_result_request_Dto.dart';

class GetSurveyController extends GetxController {
  final SurveyRepository _surveyRepository = SurveyRepository();
  final surveys = <Survey>[].obs;
  final survey = Survey().obs;

  Future<int> reportAnswer(List<SurveyResultDto> answers) async {
    int code = await _surveyRepository.reportAnswer(answers);
    return code;
  }
}
