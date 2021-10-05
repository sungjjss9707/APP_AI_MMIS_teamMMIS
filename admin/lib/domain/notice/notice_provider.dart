import 'package:get/get.dart';

import '../host.dart';

class NoticeProvider extends GetConnect {
  Future<Response> findById(int id) => get("$host/board/$id");
}
