import 'package:admin/domain/diet/diet.dart';
import 'package:admin/domain/diet/diet_repository.dart';
import 'package:get/get.dart';

//미완
class DietController extends GetxController {
  final DietRepository _dietRepository = DietRepository();
  final diets = <Diet>[].obs;
  final diet = Diet().obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> findTime(
      String year, String month, String day, String time) async {
    List<Diet> diets = await _dietRepository.findTime(year, month, day, time);
    this.diets.value = diets;
  }

  Future<void> findDay(String year, String month, String day) async {
    List<Diet> diets = await _dietRepository.findDay(year, month, day);
    this.diets.value = diets;
  }

  Future<void> findMonth(String year, String month) async {
    List<Diet> diets = await _dietRepository.findMonth(year, month);
    this.diets.value = diets;
  }

  Future<int> saveDiet(String year, String month, String day, String time,
      List<String> diets) async {
    int code = await _dietRepository.saveDiet(year, month, day, time, diets);
    return code;
  }

  Future<int> upDateDiet(String year, String month, String day, String time,
      List<String> diets) async {
    int code = await _dietRepository.upDateDiet(year, month, day, time, diets);
    return code;
  }

  Future<int> deleteDiet(String year, month, day, time) async {
    int code = await _dietRepository.deleteDiet(year, month, day, time);
    return code;
  }
}
