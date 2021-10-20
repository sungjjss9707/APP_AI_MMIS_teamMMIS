import 'package:get/get.dart';
import 'package:myapp/controller/dto/CM_request_dto.dart';
import 'package:myapp/controller/dto/post_notEating_dto.dart';
import 'package:myapp/page_util/convert_utf8.dart';

import 'not_eating.dart';
import 'not_eating_provider.dart';

class NotEatingRepository {
  NotEatingProvider _notEatingProvider = NotEatingProvider();

  Future<int> applyNotEating(String year, String month, String day, String time,
      militaryNumber, reason) async {
    PostNotEatingDto postNotEatingDto =
        PostNotEatingDto(militaryNumber, reason);
    Response response = await _notEatingProvider.applyNotEating(
        year, month, day, time, postNotEatingDto.toJson());
    dynamic body = response.body;
    dynamic convertBody = convertUtf8ToObject(body);
    CMRespDto cmRespDto = CMRespDto.fromJson(convertBody);

    if (cmRespDto.code == 1) {
      return 1;
    }
    return -1;
  }
}
