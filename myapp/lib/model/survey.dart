class Survey {
  final String title;
  final String writer;
  final String date;
  final String main;

  Survey(this.title, this.date, this.writer, this.main);
}

List<Survey> dummySurvey = [
  Survey("1. 예시 입니다.", "2021/09/12", "관리자", "글내용" * 50),
  Survey("2. 예시 입니다.", "2021/09/13", "관리자", "글내용" * 50),
  Survey("3. 예시 입니다.", "2021/09/14", "관리자", "글내용" * 50),
  Survey("4. 예시 입니다.", "2021/09/15", "관리자", "글내용" * 50),
  Survey("5. 예시 입니다.", "2021/09/16", "관리자", "글내용" * 50),
  Survey("6. 예시 입니다.", "2021/09/17", "관리자", "글내용" * 50),
];
