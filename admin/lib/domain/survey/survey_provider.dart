import 'package:get/get.dart';

import '../host.dart';

class SurveyProvider extends GetConnect {
  Future<Response> postSurvey(Map data) => post("$host/survey", data);

  Future<Response> findAll() => get("$host/survey");
}
