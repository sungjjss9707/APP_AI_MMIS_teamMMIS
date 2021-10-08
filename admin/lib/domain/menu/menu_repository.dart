import 'package:admin/controller/dto/CM_request_dto.dart';
import 'package:admin/controller/dto/menu_save_dto.dart';
import 'package:admin/domain/menu/menu_provider.dart';
import 'package:admin/util/convert_utf8.dart';
import 'package:get/get.dart';

class MenuRepository {
  final MenuProvider _menuProvider = MenuProvider();

  Future<int> save(String name, Map<String, String> nutrition,
      Map<String, String> allergy) async {
    MenuSaveDto menuSaveDto = MenuSaveDto(name, nutrition, allergy);
    Response response = await _menuProvider.save(menuSaveDto.toJson());
    dynamic body = response.body;
    dynamic convertBody = convertUtf8ToObject(body);
    CMRespDto cmRespDto = CMRespDto.fromJson(convertBody);
    if (cmRespDto.code == 1)
      return 1;
    else
      return -1;
  }
}
