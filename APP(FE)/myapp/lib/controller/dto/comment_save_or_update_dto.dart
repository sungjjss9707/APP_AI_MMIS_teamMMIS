class CommentSaveOrUpdateDto {
  final String militaryNumber;
  final String content;

  CommentSaveOrUpdateDto(this.militaryNumber, this.content);
  Map<String, dynamic> toJson() =>
      {"militaryNumber": militaryNumber, "content": content};
}
