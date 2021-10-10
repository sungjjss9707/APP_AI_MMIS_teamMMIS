import 'package:admin/domain/notice/notice.dart';
import 'package:admin/domain/notice/notice_repository.dart';
import 'package:get/get.dart';

//완
class NoticeController extends GetxController {
  final NoticeRepository _noticeRepository = NoticeRepository();
  final notices = <Notice>[].obs;
  final notice = Notice().obs;

  @override
  void onInit() {
    super.onInit();
    findAll();
  }

  Future<void> findById(int id) async {
    Notice notice = await _noticeRepository.findById(id);
    this.notice.value = notice;
  }

  Future<void> findAll() async {
    List<Notice> notices = await _noticeRepository.findAll();
    this.notices.value = notices.reversed.toList();
  }

  Future<int> deleteById(int id) async {
    int a = await _noticeRepository.deleteById(id);
    if (a == 1) {
      List<Notice> result = notices.where((post) => post.id != id).toList();
      notices.value = result;
      return a;
    }
    return -1;
  }

  Future<void> updateById(int id, String title, String content) async {
    Notice notice = await _noticeRepository.updateById(id, title, content);
    if (notice.id != null) {
      this.notice.value = notice;
      this.notices.value =
          this.notices.map((e) => e.id == id ? notice : e).toList();
    }
  }

  Future<void> save(String title, String content) async {
    Notice notice = await _noticeRepository.save(title, content);
    if (notice.id != null) {
      this.notices.insert(0, notice);
    }
  }
}
