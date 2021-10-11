import 'package:admin/domain/host.dart';
import 'package:get/get.dart';

class NotEatingProvider extends GetConnect {
  Future<Response> findByDateAndTime(
          String year, String month, String day, String time) =>
      get("$host/noteating/$year/$month/$day/$time");
  Future<Response> findByDate(String year, String month, String day) =>
      get("$host/noteating/$year/$month/$day/");
  Future<Response> changeTotalNumOfPeople(
          String year, String month, String day, String time, Map data) =>
      put("$host/noteating", data);
}
