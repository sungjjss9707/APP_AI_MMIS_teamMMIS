import 'package:admin/controller/dto/CM_request_dto.dart';
import 'package:admin/domain/AI/ai_provider.dart';
import 'package:admin/util/convert_utf8.dart';
import 'package:get/get.dart';

class AIRepository {
  final AIProvider _aiProvider = AIProvider();

  Future<void> getRecommendedMenus(Map data) async {
    Response response = await _aiProvider.getRecommendedMenus(data);
    dynamic body = response.body;
    dynamic convertBody = convertUtf8ToObject(body);
    CMRespDto cmRespDto = CMRespDto.fromJson(convertBody);
    print(cmRespDto.data);
  }
}
