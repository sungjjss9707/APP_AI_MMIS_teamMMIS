import 'package:get/get.dart';

import '../host.dart';

class MenuProvider extends GetConnect {
  Future<Response> save(Map data) => post("$host/menu/", data);
  Future<Response> findAll() => get("$host/menu");
  Future<Response> findByName(String menuName) => get("$host/menu/menuName");
}
