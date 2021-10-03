import 'package:admin/domain/notice/notice.dart';
import 'package:admin/domain/notice/notice_repository.dart';
import 'package:get/get.dart';

class NoticeController extends GetxController {
  final NoticeRepository _noticeRepository = NoticeRepository();
  final notices = <Notice>[].obs;
  final notice = Notice().obs;

  Future<void> findById(int id) async {
    await _noticeRepository.findById(id);
  }
}
