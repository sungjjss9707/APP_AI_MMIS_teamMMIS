import 'package:get/get.dart';

import '../host.dart';

class SuggestionProvider extends GetConnect {
  Future<Response> findById(int id) => get("$host/board/$id");
}
