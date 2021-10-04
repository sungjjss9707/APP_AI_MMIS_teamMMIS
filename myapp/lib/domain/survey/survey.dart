class RealSurvey {
  String id;
  String title;
  String explain;
  List<Map<String, dynamic>> questions;
  RealSurvey(this.id, this.title, this.explain, this.questions);
}

class Question {
  List<Map<String, dynamic>> questions;
  String questionTitle;
}
