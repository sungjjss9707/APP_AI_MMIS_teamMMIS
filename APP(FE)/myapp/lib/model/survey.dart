class DummySurvey {
  final String title;
  final String writer;
  final String date;
  final String main;

  DummySurvey(this.title, this.date, this.writer, this.main);
}

List<DummySurvey> dummySurvey = [
  DummySurvey("1. 예시 입니다.", "2021/09/12", "관리자", "글내용" * 50),
  DummySurvey("2. 예시 입니다.", "2021/09/13", "관리자", "글내용" * 50),
  DummySurvey("3. 예시 입니다.", "2021/09/14", "관리자", "글내용" * 50),
  DummySurvey("4. 예시 입니다.", "2021/09/15", "관리자", "글내용" * 50),
  DummySurvey("5. 예시 입니다.", "2021/09/16", "관리자", "글내용" * 50),
  DummySurvey("6. 예시 입니다.", "2021/09/17", "관리자", "글내용" * 50),
];
