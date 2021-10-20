import 'package:admin/controller/dto/CM_request_dto.dart';
import 'package:admin/controller/dto/ai_request_dto.dart';
import 'package:admin/domain/AI/ai.dart';
import 'package:admin/domain/AI/ai_provider.dart';
import 'package:admin/util/convert_utf8.dart';
import 'package:get/get.dart';

class AIRepository {
  final AIProvider _aiProvider = AIProvider();

  Future<AI> getRecommendedMenus(List<String> menus) async {
    AIReqDto aiReqDto = AIReqDto(menus);
    Response response =
        await _aiProvider.getRecommendedMenus(aiReqDto.toJson());
    dynamic body = response.body;
    dynamic convertBody = convertUtf8ToObject(body);
    CMRespDto cmRespDto = CMRespDto.fromJson(convertBody);
    print(cmRespDto.data);
    if (cmRespDto.code == 1) {
      AI principal = AI.fromJson(cmRespDto.data);
      return principal;
    } else
      return AI();
  }
}
