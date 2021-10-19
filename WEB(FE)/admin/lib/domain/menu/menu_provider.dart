import 'package:admin/domain/host.dart';
import 'package:get/get.dart';

class MenuProvider extends GetConnect {
  Future<Response> save(Map data) => post("$host/menu/", data);
  Future<Response> findAll() => get("$host/menu");
  Future<Response> findByName(String menuName) => get("$host/menu/menuName");
}
