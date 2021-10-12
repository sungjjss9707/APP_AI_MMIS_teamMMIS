import 'package:get/get.dart';

import '../host.dart';

class UserProvider extends GetConnect {
  Future<Response> login(Map data) => post("$host/normallogin/", data);
  Future<Response> join(Map data) => post("$host/normaljoin/", data);
  Future<Response> update(int id, Map data) =>
      put("$host/normalmodify/$id", data);
}
