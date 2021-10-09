import 'package:intl/intl.dart';

class Suggestion {
  final int? id;
  final String? title;
  final String? content;
  final String? writer;
  List<Comment>? comments;
  final DateTime? created;
  final DateTime? updated;

  Suggestion({
    this.id,
    this.title,
    this.content,
    this.writer,
    this.comments,
    this.created,
    this.updated,
  });

  Suggestion.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        title = json["title"],
        content = json["content"],
        writer = json["writer"],
        comments = convertToResult(json["comments"]),
        created = DateFormat("yyyy-mm-dd").parse(json["created"]),
        updated = DateFormat("yyyy-mm-dd").parse(json["updated"]);
}

List<Comment> convertToResult(List<Map<String, dynamic>> rawData) {
  List<Comment> result = <Comment>[];
  for (Map<String, dynamic> i in rawData) {
    result.add(
      Comment(i["id"], i["content"], i["writer"], i["created"], i["updated"]),
    );
  }
  return result;
}

class Comment {
  final int? id;
  final String? content;
  final String? writer;
  final DateTime? created;
  final DateTime? updated;

  Comment(
    this.id,
    this.content,
    this.writer,
    this.created,
    this.updated,
  );
}
