import 'package:admin/controller/dto/CM_request_dto.dart';
import 'package:admin/controller/dto/total_num_update_dto.dart';
import 'package:admin/domain/not_eating/not_eating_provider.dart';
import 'package:admin/util/convert_utf8.dart';
import 'package:get/get.dart';

import 'not_eating.dart';

class NotEatingRepository {
  NotEatingProvider _notEatingProvider = NotEatingProvider();
  Future<NotEating> findByDateAndTime(
      String year, String month, String day, String time) async {
    Response response =
        await _notEatingProvider.findByDateAndTime(year, month, day, time);
    dynamic body = response.body;
    dynamic convertBody = convertUtf8ToObject(body);
    CMRespDto cmRespDto = CMRespDto.fromJson(convertBody);
    if (cmRespDto.code == 1) {
      NotEating principal = NotEating.fromJson(cmRespDto.data);
      return principal;
    }
    return NotEating();
  }

  Future<List<NotEating>> findByDate(
      String year, String month, String day) async {
    Response response = await _notEatingProvider.findByDate(year, month, day);
    dynamic body = response.body;
    dynamic convertBody = convertUtf8ToObject(body);
    CMRespDto cmRespDto = CMRespDto.fromJson(convertBody);
    if (cmRespDto.code == 1) {
      Map<String, Map<String, dynamic>> temp = cmRespDto.data;
      List<NotEating> notEatings =
          temp.values.map((e) => NotEating.fromJson(e)).toList();
      return notEatings;
    }
    return <NotEating>[];
  }

  Future<NotEating> changeTotalNumOfPeople(String year, String month,
      String day, String time, String totalNumOfPeople) async {
    TotalNumUpdateDto totalNumUpdateDto = TotalNumUpdateDto(totalNumOfPeople);
    Response response = await _notEatingProvider.changeTotalNumOfPeople(
        year, month, day, time, totalNumUpdateDto.toJson());
    dynamic body = response.body;
    dynamic convertBody = convertUtf8ToObject(body);
    CMRespDto cmRespDto = CMRespDto.fromJson(convertBody);
    if (cmRespDto.code == 1) {
      NotEating principal = NotEating.fromJson(cmRespDto.data);
      return principal;
    }
    return NotEating();
  }
}
