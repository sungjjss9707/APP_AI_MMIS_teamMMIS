import 'package:admin/controller/dto/CM_request_dto.dart';
import 'package:admin/controller/dto/diet_save_dto.dart';
import 'package:admin/controller/dto/diet_update_dto.dart';

import 'package:admin/util/convert_utf8.dart';
import 'package:get/get.dart';

import 'diet.dart';
import 'diet_provider.dart';

class DietRepository {
  final DietProvider _dietProvider = DietProvider();

  Future<List<Diet>> findMonth(String year, String month) async {
    Response response = await _dietProvider.findMonth(year, month);
    dynamic body = response.body;
    dynamic convertBody = convertUtf8ToObject(body);
    CMRespDto cmRespDto = CMRespDto.fromJson(convertBody);
    if (cmRespDto.code == 1) {
      List<dynamic> temp = cmRespDto.data;
      List<Diet> diets = temp.map((e) => Diet.fromJson(e)).toList();
      return diets;
    }
    return <Diet>[];
  }

  Future<List<Diet>> findDay(String year, String month, String day) async {
    Response response = await _dietProvider.findDay(year, month, day);
    dynamic body = response.body;
    dynamic convertBody = convertUtf8ToObject(body);
    CMRespDto cmRespDto = CMRespDto.fromJson(convertBody);
    if (cmRespDto.code == 1) {
      List<dynamic> temp = cmRespDto.data;

      List<Diet> diets = temp.map((e) => Diet.fromJson(e)).toList();
      return diets;
    }
    return <Diet>[];
  }

  Future<List<Diet>> findTime(
      String year, String month, String day, String time) async {
    Response response = await _dietProvider.findTime(year, month, day, time);
    dynamic body = response.body;
    dynamic convertBody = convertUtf8ToObject(body);
    CMRespDto cmRespDto = CMRespDto.fromJson(convertBody);
    if (cmRespDto.code == 1) {
      List<dynamic> temp = cmRespDto.data;
      List<Diet> diets = temp.map((e) => Diet.fromJson(e)).toList();
      return diets;
    }
    return <Diet>[];
  }

  Future<int> saveDiet(String year, String month, String day, String time,
      List<String> diets) async {
    DietSaveDto dietSaveDto = DietSaveDto(year, month, day, time, diets);
    Response response = await _dietProvider.saveDiet(dietSaveDto.toJson());
    dynamic body = response.body;
    dynamic convertBody = convertUtf8ToObject(body);
    CMRespDto cmRespDto = CMRespDto.fromJson(convertBody);
    if (cmRespDto.code == 1) {
      return 1;
    } else {
      return -1;
    }
  }

  Future<int> upDateDiet(String year, String month, String day, String time,
      List<String> diets) async {
    DietUpdateDto dietUpdateDtoDto = DietUpdateDto(diets);
    Response response = await _dietProvider.upDateDiet(
        year, month, day, time, dietUpdateDtoDto.toJson());
    dynamic body = response.body;
    dynamic convertBody = convertUtf8ToObject(body);
    CMRespDto cmRespDto = CMRespDto.fromJson(convertBody);
    if (cmRespDto.code == 1) {
      return 1;
    } else {
      return -1;
    }
  }

  Future<int> deleteDiet(
      String year, String month, String day, String time) async {
    Response response = await _dietProvider.deleteDiet(year, month, day, time);
    dynamic body = response.body;
    dynamic convertBody = convertUtf8ToObject(body);
    CMRespDto cmRespDto = CMRespDto.fromJson(convertBody);
    if (cmRespDto.code == 1) {
      return 1;
    }
    return -1;
  }
}
