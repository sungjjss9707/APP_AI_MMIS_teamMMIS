import 'package:admin/domain/suggestion/suggestion_provider.dart';
import 'package:get/get.dart';

class SuggestionRepository {
  final SuggestionProvider _suggestionProvider = SuggestionProvider();

  Future<void> findById(int id) async {
    Response response = await _suggestionProvider.findById(id);
    print(response.body);
  }
}
