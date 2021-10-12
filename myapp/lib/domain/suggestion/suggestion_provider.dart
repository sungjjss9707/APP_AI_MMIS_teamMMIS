import 'package:get/get.dart';

import '../host.dart';

class SuggestionProvider extends GetConnect {
  Future<Response> findById(int id) => get("$host/suggestion/$id/");
  Future<Response> findAll() => get("$host/suggestion/");
  Future<Response> deleteById(int id) => delete("$host/suggestion/$id");
  Future<Response> postComment(int suggestionId, Map data) =>
      post("$host/suggestion/", data);
  Future<Response> updateComment(int suggestionId, int CommentId, Map data) =>
      post("$host/suggestion/", data);
  Future<Response> deleteComment(int suggestionId, int CommentId) =>
      delete("$host/suggestion/");
}
