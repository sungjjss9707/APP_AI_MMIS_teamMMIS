import 'package:intl/intl.dart';

class Notice {
  final int? id;
  final String? title;
  final String? content;
  final DateTime? created;
  final DateTime? updated;

  Notice({
    this.id,
    this.title,
    this.content,
    this.created,
    this.updated,
  });
  Notice.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        title = json["title"],
        content = json["content"],
        created = DateFormat("yyyy-mm-dd").parse(json["created"]),
        updated = DateFormat("yyyy-mm-dd").parse(json["updated"]);
}
