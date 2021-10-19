import 'package:admin/domain/AI/ai.dart';
import 'package:admin/domain/AI/ai_repository.dart';
import 'package:get/get.dart';

//완
class AIController extends GetxController {
  final AIRepository _aiRepository = AIRepository();
  final principal = AI().obs;

  Future<void> getRecommendedMenus(List<String> menus) async {
    AI principal = await _aiRepository.getRecommendedMenus(menus);
    this.principal.value = principal;
  }
}
