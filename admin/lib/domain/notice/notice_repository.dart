import 'package:admin/domain/notice/notice_provider.dart';
import 'package:get/get.dart';

class NoticeRepository {
  final NoticeProvider _noticeProvider = NoticeProvider();

  Future<void> findById(int id) async {
    Response response = await _noticeProvider.findById(id);
    print(response.body);
  }
}
