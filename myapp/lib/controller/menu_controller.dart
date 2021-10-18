import 'package:get/get.dart';
import 'package:myapp/domain/menu/menu.dart';
import 'package:myapp/domain/menu/menu_repository.dart';
import 'package:myapp/page_util/Info.dart';

class MenuController extends GetxController {
  final MenuRepository _menuRepository = MenuRepository();
  final menus = <Menu>[].obs;
  final menu = Menu().obs;

  @override
  void onInit() {
    findAll();
    super.onInit();
  }

  Future<void> save(String name, Map<String, String> nutrition,
      Map<String, String> allergy) async {
    int a = await _menuRepository.save(name, nutrition, allergy);
    if (a == 1) {
      Menus.menus.add(name);
    }
  }

  Future<void> findAll() async {
    List<Menu> menus = await _menuRepository.findAll();
    this.menus.value = menus;
    getMenusAndAllergyMap(menus);
    getMenusAndNutritionMap(menus);
  }

  Future<void> findByName(String menuName) async {
    Menu menu = await _menuRepository.findByName(menuName);
    this.menu.value = menu;
  }
}
