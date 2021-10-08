import 'package:admin/domain/survey/survey.dart';
import 'package:admin/domain/survey/survey_repository.dart';
import 'package:admin/view/components/survey/survey_question_form_field.dart';

import 'package:get/get.dart';

class SurveyController extends GetxController {
  final SurveyRepository _surveyRepository = SurveyRepository();
  final surveys = <Survey>[].obs;
  final survey = Survey().obs;

  @override
  void onInit() {
    super.onInit();
    findAll();
  }

  Future<int> postSurvey(String title, String explain,
      List<SurveyQuestionFormField> questions) async {
    int a = await _surveyRepository.postSurvey(title, explain, questions);
    return a;
  }

  Future<void> findAll() async {
    List<Survey> surveys = await _surveyRepository.findAll();
    this.surveys.value = surveys;
  }

  Future<void> findById(int id) async {
    Survey survey = await _surveyRepository.findById(id);
    this.survey.value = survey;
  }
}
