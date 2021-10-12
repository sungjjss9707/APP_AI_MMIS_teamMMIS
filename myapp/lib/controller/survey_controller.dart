import 'package:get/get.dart';
import 'package:myapp/domain/survey/survey.dart';
import 'package:myapp/domain/survey/survey_repository.dart';

class GetSurveyController extends GetxController {
  final SurveyRepository _surveyRepository = SurveyRepository();
  final surveys = <Survey>[].obs;
  final survey = Survey().obs;
}
