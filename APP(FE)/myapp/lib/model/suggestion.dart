class Suggestion {
  final String title;
  final String writer;
  final String date;
  final String main;

  Suggestion(this.title, this.date, this.writer, this.main);
}

List<Suggestion> dummySuggestion = [
  Suggestion("1. 예시 입니다.", "2021/09/12", "관리자", "글내용" * 50),
  Suggestion("2. 예시 입니다.", "2021/09/13", "관리자", "글내용" * 50),
  Suggestion("3. 예시 입니다.", "2021/09/14", "관리자", "글내용" * 50),
  Suggestion("4. 예시 입니다.", "2021/09/15", "관리자", "글내용" * 50),
  Suggestion("5. 예시 입니다.", "2021/09/16", "관리자", "글내용" * 50),
  Suggestion("6. 예시 입니다.", "2021/09/17", "관리자", "글내용" * 50),
];
