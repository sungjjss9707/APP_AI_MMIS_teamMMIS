import 'package:admin/util/jwtToken.dart';
import 'package:get/get.dart';

import '../host.dart';

class NoticeProvider extends GetConnect {
  Future<Response> findAll() =>
      get("$host/notice", headers: {"authorization": jwtToken ?? ""});

  Future<Response> findById(int id) =>
      get("$host/notice/$id", headers: {"authorization": jwtToken ?? ""});

  Future<Response> deleteById(int id) =>
      delete("$host/post/$id", headers: {"authorization": jwtToken ?? ""});

  Future<Response> updateById(int id, Map data) =>
      put("$host/post/$id", data, headers: {"authorization": jwtToken ?? ""});

  Future<Response> save(Map data) =>
      post("$host/post/", data, headers: {"authorization": jwtToken ?? ""});
}
