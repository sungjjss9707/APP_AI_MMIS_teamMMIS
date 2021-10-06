import 'package:admin/domain/AI/ai_repository.dart';
import 'package:get/get.dart';

class AIController extends GetxController {
  final AIRepository _aiRepository = AIRepository();

  Future<void> getRecommendedMenus(Map data) async {
    await _aiRepository.getRecommendedMenus(data);
  }
}
