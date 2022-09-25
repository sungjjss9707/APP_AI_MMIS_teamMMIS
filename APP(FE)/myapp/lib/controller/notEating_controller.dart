import 'package:get/get.dart';
import 'package:myapp/domain/not_eating/not_eating_repository.dart';

class NotEatingController extends GetxController {
  NotEatingRepository _notEatingRepository = NotEatingRepository();

  Future<int> applyNotEating(String year, String month, String day, String time,
      militaryNumber, reason) async {
    int code = await _notEatingRepository.applyNotEating(
        year, month, day, time, militaryNumber, reason);
    return code;
  }
}
