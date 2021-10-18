import 'package:get/get.dart';
import 'package:myapp/controller/dto/CM_request_dto.dart';
import 'package:myapp/controller/dto/comment_save_or_update_dto.dart';
import 'package:myapp/controller/dto/suggestion_post_or_update_dto.dart';
import 'package:myapp/domain/suggestion/suggestion.dart';
import 'package:myapp/domain/suggestion/suggestion_provider.dart';
import 'package:myapp/page_util/convert_utf8.dart';

class SuggestionRepository {
  final SuggestionProvider _suggestionProvider = SuggestionProvider();

  Future<Suggestion> findById(int id) async {
    Response response = await _suggestionProvider.findById(id);
    dynamic body = response.body;
    dynamic convertBody = convertUtf8ToObject(body);
    CMRespDto cmRespDto = CMRespDto.fromJson(convertBody);
    if (cmRespDto.code == 1) {
      Suggestion suggestion = Suggestion.fromJson(cmRespDto.data);
      return suggestion;
    } else {
      return Suggestion();
    }
  }

  Future<List<Suggestion>> findAll() async {
    Response response = await _suggestionProvider.findAll();
    dynamic body = response.body;
    dynamic convertBody = convertUtf8ToObject(body);
    CMRespDto cmRespDto = CMRespDto.fromJson(convertBody);
    if (cmRespDto.code == 1) {
      List<dynamic> temp = cmRespDto.data;

      List<Suggestion> suggestions =
          temp.map((suggestion) => Suggestion.fromJson(suggestion)).toList();

      return suggestions;
    } else {
      return <Suggestion>[];
    }
  }

  Future<int> deleteById(int id) async {
    Response response = await _suggestionProvider.deleteById(id);
    dynamic body = response.body;
    dynamic convertBody = convertUtf8ToObject(body);
    CMRespDto cmRespDto = CMRespDto.fromJson(convertBody);
    return cmRespDto.code ?? -1;
  }

  Future<Suggestion> postComment(
      int suggestionId, String militaryNumber, String content) async {
    CommentSaveOrUpdateDto saveDto =
        CommentSaveOrUpdateDto(militaryNumber, content);
    Response response =
        await _suggestionProvider.postComment(suggestionId, saveDto.toJson());
    dynamic body = response.body;
    dynamic convertBody = convertUtf8ToObject(body);
    CMRespDto cmRespDto = CMRespDto.fromJson(convertBody);
    if (cmRespDto.code == 1) {
      return Suggestion.fromJson(cmRespDto.data);
    } else {
      return Suggestion();
    }
  }

  Future<Suggestion> updateComment(int suggestionId, int CommentId,
      String militaryNumber, String content) async {
    CommentSaveOrUpdateDto updateDto =
        CommentSaveOrUpdateDto(militaryNumber, content);
    Response response = await _suggestionProvider.updateComment(
        suggestionId, CommentId, updateDto.toJson());
    dynamic body = response.body;
    dynamic convertBody = convertUtf8ToObject(body);
    CMRespDto cmRespDto = CMRespDto.fromJson(convertBody);
    if (cmRespDto.code == 1) {
      return Suggestion.fromJson(cmRespDto.data);
    } else {
      return Suggestion();
    }
  }

  Future<int> deleteComment(int suggestionId, int CommentId) async {
    Response response =
        await _suggestionProvider.deleteComment(suggestionId, CommentId);
    dynamic body = response.body;
    dynamic convertBody = convertUtf8ToObject(body);
    CMRespDto cmRespDto = CMRespDto.fromJson(convertBody);
    return cmRespDto.code ?? -1;
  }

  Future<Suggestion> postSuggestion(
      String title, content, militaryNumber) async {
    SuggestionPostOrUpdateDto postDto =
        SuggestionPostOrUpdateDto(title, content, militaryNumber);
    Response response =
        await _suggestionProvider.postSuggestion(postDto.toJson());
    dynamic body = response.body;
    dynamic convertBody = convertUtf8ToObject(body);
    CMRespDto cmRespDto = CMRespDto.fromJson(convertBody);
    if (cmRespDto.code == 1) {
      return Suggestion.fromJson2(cmRespDto.data);
    }
    return Suggestion();
  }
}
