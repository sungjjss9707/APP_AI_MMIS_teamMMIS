import 'package:admin/domain/diet/diet.dart';
import 'package:admin/domain/diet/diet_repository.dart';
import 'package:get/get.dart';

class DietController extends GetxController {
  final DietRepository _dietRepository = DietRepository();
  final diet = Diet().obs;

  Future<void> findTime(
      String year, String month, String day, String time) async {
    Diet diet = await _dietRepository.findTime(year, month, day, time);
    this.diet.value = diet;
  }

  Future<void> saveDiet(String year, String month, String day, String time,
      List<String> diets) async {
    int code = await _dietRepository.saveDiet(year, month, day, time, diets);
  }

  Future<void> upDateDiet(String year, String month, String day, String time,
      List<String> diets) async {
    int code = await _dietRepository.upDateDiet(year, month, day, time, diets);
  }
}
