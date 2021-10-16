import 'package:get/get.dart';
import 'package:myapp/controller/dto/CM_request_dto.dart';
import 'package:myapp/controller/dto/notice_save_or_update_dto.dart';
import 'package:myapp/page_util/convert_utf8.dart';

import 'notice.dart';
import 'notice_provider.dart';

class NoticeRepository {
  final NoticeProvider _noticeProvider = NoticeProvider();

  Future<Notice> findById(int id) async {
    Response response = await _noticeProvider.findById(id);
    dynamic body = response.body;
    dynamic convertBody = convertUtf8ToObject(body);
    CMRespDto cmRespDto = CMRespDto.fromJson(convertBody);

    if (cmRespDto.code == 1) {
      Notice notice = Notice.fromJson(cmRespDto.data);
      return notice;
    } else {
      return Notice();
    }
  }

  Future<Notice> updateById(int id, String title, String content) async {
    NoticeSaveOrUpdateDto NoticeUpdateDto =
        NoticeSaveOrUpdateDto(title, content);
    Response response =
        await _noticeProvider.updateById(id, NoticeUpdateDto.toJson());
    dynamic body = response.body;
    dynamic convertBody = convertUtf8ToObject(body);
    CMRespDto cmRespDto = CMRespDto.fromJson(convertBody);
    if (cmRespDto.code == 1) {
      return Notice.fromJson(cmRespDto.data);
    } else {
      return Notice();
    }
  }

  Future<Notice> save(String title, String content) async {
    NoticeSaveOrUpdateDto NoticeSaveDto = NoticeSaveOrUpdateDto(title, content);
    Response response = await _noticeProvider.save(NoticeSaveDto.toJson());
    dynamic body = response.body;
    dynamic convertBody = convertUtf8ToObject(body);
    CMRespDto cmRespDto = CMRespDto.fromJson(convertBody);
    if (cmRespDto.code == 1) {
      return Notice.fromJson(cmRespDto.data);
    } else {
      return Notice();
    }
  }

  Future<int> deleteById(int id) async {
    Response response = await _noticeProvider.deleteById(id);
    dynamic body = response.body;
    dynamic convertBody = convertUtf8ToObject(body);
    CMRespDto cmRespDto = CMRespDto.fromJson(convertBody);
    return cmRespDto.code!;
  }

  Future<List<Notice>> findAll() async {
    Response response = await _noticeProvider.findAll();

    dynamic body = response.body;
    dynamic convertBody = convertUtf8ToObject(body);
    CMRespDto cmRespDto = CMRespDto.fromJson(convertBody);

    if (cmRespDto.code == 1) {
      List<dynamic> temp = cmRespDto.data;
      List<Notice> notices =
          temp.map((notice) => Notice.fromJson(notice)).toList();
      return notices;
    } else {
      return <Notice>[];
    }
  }
}
