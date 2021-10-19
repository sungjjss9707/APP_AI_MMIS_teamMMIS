import 'package:get/get.dart';

const host = "";

class SurveyProvider extends GetConnect {
  Future<Response> getSurvey() => get(host);

  Future<Response> reportAnswer(List data) => post(host, data);
}
