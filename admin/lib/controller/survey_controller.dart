import 'package:admin/view/components/survey/survey_question_form_field.dart';
import 'package:get/get.dart';

class SurveyController extends GetxController {
  RxString? title = "".obs;
  RxString? explain = "".obs;
  RxList<SurveyQuestionFormField> questions = <SurveyQuestionFormField>[].obs;
}

class QuestionType<T> {
  T? type;
  QuestionType(this.type);
}
