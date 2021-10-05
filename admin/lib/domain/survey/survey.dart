import 'package:admin/view/components/survey/survey_question_form_field.dart';

class Survey {
  final String? title;
  final String? explain;
  final List<SurveyQuestionFormField>? questions;

  Survey({this.title, this.explain, this.questions});
}
