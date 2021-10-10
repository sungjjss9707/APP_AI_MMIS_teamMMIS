import 'package:admin/domain/host.dart';
import 'package:get/get.dart';

class NotEatingProvider extends GetConnect {
  Future<Response> findByDateAndTime(
          String year, String month, String day, String time) =>
      get("$host/noteating");
  Future<Response> changeTotalNumOfPeople(
          String year, String month, String day, String time, Map data) =>
      put("$host/noteating", data);
}
