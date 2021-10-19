import 'package:get/get.dart';
import 'package:myapp/domain/host.dart';

class PhotoProvider extends GetConnect {
  Future<Response> upload(Map data) => post("$host/photo", data);

  Future<Response> findPhotos(int id) => get("$host/:$id");
}
