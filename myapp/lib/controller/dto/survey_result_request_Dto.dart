class SurveyResultDto {
  final int id;
  final String type;
  final List<String> answer;

  SurveyResultDto(this.id, this.type, this.answer);
  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "answer": answer,
      };
}
