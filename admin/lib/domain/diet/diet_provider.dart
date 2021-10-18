import 'package:admin/domain/host.dart';
import 'package:get/get.dart';

class DietProvider extends GetConnect {
  Future<Response> findMonth(String year, String month) =>
      get("$host/diet/$year/$month");
  Future<Response> findDay(String year, String month, String day) =>
      get("$host/diet/$year/$month/$day");
  Future<Response> findTime(
          String year, String month, String day, String time) =>
      get("$host/diet/$year/$month/$day/$time");
  Future<Response> saveDiet(Map data) => post("$host/diet", data);
  Future<Response> upDateDiet(
          String year, String month, String day, String time, Map data) =>
      put("$host/diet/$year/$month/$day/$time", data);
  Future<Response> deleteDiet(
          String year, String month, String day, String time) =>
      delete("$host/diet/$year/$month/$day/$time");
}
