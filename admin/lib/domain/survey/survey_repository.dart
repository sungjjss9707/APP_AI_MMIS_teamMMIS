import 'package:admin/domain/suggestion/suggestion_provider.dart';
import 'package:admin/domain/survey/survey_provider.dart';
import 'package:get/get.dart';

class SuveyRepository {
  final SurveyProvider _surveyProvider = SurveyProvider();

  Future<void> findById(int id) async {
    Response response = await _surveyProvider.findById(id);
  }
}
