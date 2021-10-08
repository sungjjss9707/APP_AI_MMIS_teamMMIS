import 'package:admin/domain/survey/survey.dart';
import 'package:admin/domain/survey/survey_repository.dart';
import 'package:admin/view/components/survey/survey_question_form_field.dart';

import 'package:get/get.dart';

//미완
class SurveyController extends GetxController {
  final SurveyRepository _surveyRepository = SurveyRepository();
  final surveys = <Survey>[].obs;
  final notice = Survey().obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<int> postSurvey(String title, String explain, List<SurveyQuestionFormField> questions)async {
    int a = await _surveyRepository.postSurvey(title, explain, questions);
    return a;
  }
}
