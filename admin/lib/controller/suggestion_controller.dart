import 'package:admin/domain/suggestion/suggestion.dart';

import 'package:admin/domain/suggestion/suggestion_repository.dart';
import 'package:get/get.dart';

class SuggestionController extends GetxController {
  final SuggestionRepository _suggestionRepository = SuggestionRepository();
  final suggestions = <Suggestion>[].obs;
  final notice = Suggestion().obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> findById(int id) async {
    await _suggestionRepository.findById(id);
  }
}
