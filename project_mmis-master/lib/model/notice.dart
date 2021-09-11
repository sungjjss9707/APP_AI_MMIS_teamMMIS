class Notice {
  final String type;
  final String title;
  final String writer;
  final String date;
  final String main;

  Notice(this.type, this.title, this.date, this.writer, this.main);
}

List<Notice> dummyNotice = [
  Notice("공지", "1. 예시 입니다.", "2021/09/12", "관리자", "글내용" * 50),
  Notice("긴급", "2. 예시 입니다.", "2021/09/13", "관리자", "글내용" * 50),
  Notice("공지", "3. 예시 입니다.", "2021/09/14", "관리자", "글내용" * 50),
  Notice("공지", "4. 예시 입니다.", "2021/09/15", "관리자", "글내용" * 50),
  Notice("공지", "5. 예시 입니다.", "2021/09/16", "관리자", "글내용" * 50),
  Notice("이벤트", "6. 예시 입니다.", "2021/09/17", "관리자", "글내용" * 50),
];
