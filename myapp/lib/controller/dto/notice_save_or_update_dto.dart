class NoticeSaveOrUpdateDto {
  final String title;
  final String content;

  NoticeSaveOrUpdateDto(this.title, this.content);

  Map<String, dynamic> toJson() => {
        "title": title,
        "content": content,
      };
}
