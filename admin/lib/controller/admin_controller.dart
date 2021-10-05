import 'package:admin/domain/administer/admin.dart';
import 'package:admin/domain/administer/admin_repository.dart';

import 'package:get/get.dart';

class AdministerController extends GetxController {
  final AdministerRepository _administerRepository = AdministerRepository();
  final RxBool isLogin = false.obs; // UI가 관찰 가능한 변수 => 변경 => UI가 자동 업데이트
  final principal = Administer().obs;

  Future<int> login(String militaryNumber, String password) async {
    Administer principal =
        await _administerRepository.login(militaryNumber, password);
    if (principal.id != null) {
      this.isLogin.value = true;
      this.principal.value = principal;
      return 1;
    } else {
      return -1;
    }
  }
}
