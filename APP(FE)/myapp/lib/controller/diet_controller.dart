import 'package:get/get.dart';
import 'package:myapp/domain/diet/diet.dart';
import 'package:myapp/domain/diet/diet_repository.dart';

//미완
class DietController extends GetxController {
  final DietRepository _dietRepository = DietRepository();
  final diets = <Diet>[].obs;
  // {"2021/10/21/석식" : ["밥", "김치"]}
  final dietsConvert = <String, List<String>>{}.obs;
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

  Future<int> findMonth(String year, String month) async {
    List<Diet> diets = await _dietRepository.findMonth(year, month);
    this.diets.value = diets;
    this.dietsConvert.value = await dietConvert(diets);
    return 1;
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
