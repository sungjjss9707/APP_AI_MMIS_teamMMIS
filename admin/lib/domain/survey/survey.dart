import 'package:admin/view/components/survey/survey_question_form_field.dart';

class Survey {
  String? title;
  String? explain;
  List<SurveyQuestionFormField>? questions;

  Survey({this.title, this.explain, this.questions});
}
