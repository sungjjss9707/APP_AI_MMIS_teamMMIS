import 'package:admin/domain/suggestion/suggestion.dart';

import 'package:admin/domain/suggestion/suggestion_repository.dart';
import 'package:get/get.dart';

//미완
class SuggestionController extends GetxController {
  final SuggestionRepository _suggestionRepository = SuggestionRepository();
  final suggestions = <Suggestion>[].obs;
  final suggestion = Suggestion().obs;

  @override
  void onInit() {
    super.onInit();
    findAll();
  }

  Future<void> findById(int id) async {
    Suggestion suggestion = await _suggestionRepository.findById(id);
    this.suggestion.value = suggestion;
  }

  Future<void> findAll() async {
    List<Suggestion> suggestions = await _suggestionRepository.findAll();
    this.suggestions.value = suggestions.reversed.toList();
  }

  Future<int> deleteById(int id) async {
    int result = await _suggestionRepository.deleteById(id);
    if (result == 1) {
      List<Suggestion> result =
          suggestions.where((post) => post.id != id).toList();
      suggestions.value = result;
      return 1;
    }
    return -1;
  }

  Future<void> postComment(int suggestionId, String content) async {
    Suggestion suggestion =
        await _suggestionRepository.postComment(suggestionId, content);
    this.suggestion.value = suggestion;
  }

  Future<void> updateComment(
      int suggestionId, int CommentId, String content) async {
    Suggestion suggestion = await _suggestionRepository.updateComment(
        suggestionId, CommentId, content);
    this.suggestion.value = suggestion;
  }

  Future<void> deleteComment(int suggestionId, int CommentId) async {
    int result =
        await _suggestionRepository.deleteComment(suggestionId, CommentId);
    if (result == 1) {
      List<Comment> result = suggestion.value.comments!
          .where((comment) => comment.id != CommentId)
          .toList();
      this.suggestion.value.comments = result;
    }
  }
}
