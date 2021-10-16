import 'package:get/get.dart';
import 'package:myapp/domain/user/user.dart';
import 'package:myapp/domain/user/user_repository.dart';
import 'package:myapp/user/user_ex.dart';

class UserController extends GetxController {
  UserRepository _userRepository = UserRepository();
  final principal = User().obs;

  Future<int> login(String militaryNumber, String password) async {
    User principal = await _userRepository.login(militaryNumber, password);
    this.principal.value = principal;
    if (principal.id != null) {
      userAllergy = principal.allergy!
          .map((key, value) => MapEntry(key, value != "0" ? true : false));
      return 1;
    }
    return -1;
  }

  Future<int> join(String name, String militaryNumber, String password,
      String rank, String unit, Map<String, String> allergy) async {
    int code = await _userRepository.join(
        name, militaryNumber, password, rank, unit, allergy);
    if (code == 1) {
      return 1;
    } else {
      return -1;
    }
  }

  Future<void> updateInfo(
      int id,
      String name,
      String militaryNumber,
      String password,
      String rank,
      String unit,
      Map<String, String> allergy) async {
    User principal = await _userRepository.update(
        id, name, militaryNumber, password, rank, unit, allergy);
    this.principal.value = principal;
  }
}
