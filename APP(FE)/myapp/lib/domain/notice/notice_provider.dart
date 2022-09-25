import 'package:get/get.dart';

import '../host.dart';

class NoticeProvider extends GetConnect {
  Future<Response> findAll() => get(
        "$host/notice/",
      );

  Future<Response> findById(int id) => get(
        "$host/notice/$id",
      );

  Future<Response> deleteById(int id) => delete(
        "$host/notice/$id",
      );

  Future<Response> updateById(int id, Map data) => put(
        "$host/notice/$id",
        data,
      );

  Future<Response> save(Map data) => post(
        "$host/notice/",
        data,
      );
}
