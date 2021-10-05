class Suggestion {
  final int? id;
  final String? title;
  final String? content;
  final Map? writerInfo;
  final List<Comment>? comments;
  final DateTime? created;
  final DateTime? updated;

  Suggestion({
    this.id,
    this.title,
    this.content,
    this.writerInfo,
    this.comments,
    this.created,
    this.updated,
  });
}

class Comment {
  final int? id;
  final String? title;
  final Map? writerInfo;
  final DateTime? created;
  final DateTime? updated;

  Comment({
    this.id,
    this.title,
    this.writerInfo,
    this.created,
    this.updated,
  });
}
