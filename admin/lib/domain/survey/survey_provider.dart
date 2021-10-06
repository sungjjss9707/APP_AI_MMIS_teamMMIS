import 'package:get/get.dart';

import '../host.dart';

class SurveyProvider extends GetConnect {
  Future<Response> findById(int id) => get("$host/board/$id");
}
