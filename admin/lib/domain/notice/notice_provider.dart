import 'package:get/get.dart';

const host = "http://cors-anywhere.herokuapp.com/http://52.78.37.19:8080";

class NoticeProvider extends GetConnect {
  Future<Response> findById(int id) => get("$host/board/$id");
}
