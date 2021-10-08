import 'package:admin/domain/menu/menu_repository.dart';
import 'package:admin/util/Info.dart';
import 'package:get/get.dart';

class MenuController extends GetxController {
  final MenuRepository _menuRepository = MenuRepository();

  Future<void> save(String name, Map<String, String> nutrition,
      Map<String, String> allergy) async {
    int a = await _menuRepository.save(name, nutrition, allergy);
    if (a == 1) {
      Menus.menus.add(name);
    }
  }
}
