class DummySurvey {
  final String title;
  final String writer;
  final String date;
  final String main;

  DummySurvey(this.title, this.date, this.writer, this.main);
}

List<DummySurvey> dummySurvey = [
  DummySurvey("1. 21-3차 급식 만족도조사입니다.", "2021/09/12", "관리자", "글내용" * 50),
  DummySurvey("2. 예시 입니다.", "2021/09/13", "관리자", "글내용" * 50),
  DummySurvey("3. 예시 입니다.", "2021/09/14", "관리자", "글내용" * 50),
];
