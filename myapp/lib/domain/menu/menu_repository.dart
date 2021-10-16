import 'package:get/get.dart';
import 'package:myapp/controller/dto/CM_request_dto.dart';
import 'package:myapp/controller/dto/menu_save_dto.dart';
import 'package:myapp/page_util/convert_utf8.dart';

import 'menu.dart';
import 'menu_provider.dart';

class MenuRepository {
  final MenuProvider _menuProvider = MenuProvider();

  Future<int> save(String name, Map<String, String> nutrition,
      Map<String, String> allergy) async {
    MenuSaveDto menuSaveDto = MenuSaveDto(name, nutrition, allergy);
    Response response = await _menuProvider.save(menuSaveDto.toJson());
    dynamic body = response.body;
    dynamic convertBody = convertUtf8ToObject(body);
    CMRespDto cmRespDto = CMRespDto.fromJson(convertBody);
    if (cmRespDto.code == 1) {
      print(cmRespDto.code);
      print(cmRespDto.data);
      return 1;
    } else
      return -1;
  }

  Future<List<Menu>> findAll() async {
    Response response = await _menuProvider.findAll();
    dynamic body = response.body;
    dynamic convertBody = convertUtf8ToObject(body);
    CMRespDto cmRespDto = CMRespDto.fromJson(convertBody);
    if (cmRespDto.code == 1) {
      List<dynamic> temp = cmRespDto.data;
      List<Menu> menus = temp.map((menu) => Menu.fromJson(menu)).toList();
      return menus;
    } else {
      return <Menu>[];
    }
  }

  Future<Menu> findByName(String menuName) async {
    Response response = await _menuProvider.findByName(menuName);
    dynamic body = response.body;
    dynamic convertBody = convertUtf8ToObject(body);
    CMRespDto cmRespDto = CMRespDto.fromJson(convertBody);
    if (cmRespDto.code == 1) {
      Menu menu = Menu.fromJson(cmRespDto.data);
      return menu;
    } else {
      return Menu();
    }
  }
}
