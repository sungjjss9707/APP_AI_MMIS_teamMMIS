import 'package:admin/domain/menu/diet.dart';
import 'package:admin/domain/menu/diet_repository.dart';
import 'package:get/get.dart';

class DietController extends GetxController {
  final DietRepository _dietRepository = DietRepository();
  final diet = Diet().obs;

  Future<void> findTime(
      String year, String month, String day, String time) async {
    Diet diet = await _dietRepository.findTime(year, month, day, time);
    this.diet.value = diet;
  }
}
