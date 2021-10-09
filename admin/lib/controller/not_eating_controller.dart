import 'package:admin/domain/not_eating/not_eating.dart';
import 'package:admin/domain/not_eating/not_eating_repository.dart';
import 'package:get/get.dart';

class NotEatingController extends GetxController {
  final NotEatingRepository _notEatingRepository = NotEatingRepository();
  final notEating = NotEating().obs;

  Future<void> findByDateAndTime(
      String year, String month, String day, String time) async {
    NotEating notEating =
        await _notEatingRepository.findByDateAndTime(year, month, day, time);
    this.notEating.value = notEating;
  }

  Future<void> changeTotalNumOfPeople(String year, String month, String day,
      String time, String totalNumOfPeople) async {
    NotEating notEating = await _notEatingRepository.changeTotalNumOfPeople(
        year, month, day, time, totalNumOfPeople);
    this.notEating.value = notEating;
  }
}
