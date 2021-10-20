class SuggestionPostOrUpdateDto {
  final String title;
  final String content;
  final String militaryNumber;

  SuggestionPostOrUpdateDto(this.title, this.content, this.militaryNumber);

  Map<String, dynamic> toJson() => {
        "title": title,
        "content": content,
        "militaryNumber": militaryNumber,
      };
}
