class CommentSaveOrUpdateDto {
  final String content;

  CommentSaveOrUpdateDto(this.content);
  Map<String, dynamic> toJson() => {"content": content};
}
