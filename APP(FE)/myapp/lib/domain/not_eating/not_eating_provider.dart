import 'package:get/get.dart';
import 'package:myapp/domain/host.dart';

class NotEatingProvider extends GetConnect {
  Future<Response> applyNotEating(
          String year, String month, String day, String time, Map data) =>
      post("$host/noteating/$year/$month/$day/$time", data);
  Future<Response> cancel(
    String year,
    String month,
    String day,
    String time,
    Map data,
  ) =>
      delete("$host/noteating/$year/$month/$day/$time");
}
