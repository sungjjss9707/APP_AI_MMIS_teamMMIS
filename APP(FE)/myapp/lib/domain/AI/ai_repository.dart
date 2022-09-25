import 'package:get/get.dart';
import 'package:myapp/controller/dto/CM_request_dto.dart';
import 'package:myapp/controller/dto/ai_request_dto.dart';
import 'package:myapp/page_util/convert_utf8.dart';

import 'ai.dart';
import 'ai_provider.dart';

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
