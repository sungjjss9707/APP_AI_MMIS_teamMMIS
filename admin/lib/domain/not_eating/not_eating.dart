class NotEating {
  final int? id;
  final String? totalNumberOfPeople;
  final Map<String, List>? reason;

  NotEating({this.id, this.totalNumberOfPeople, this.reason});

  NotEating.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        totalNumberOfPeople = json["totalNumberOfPeople"],
        reason = json["reason"];
}
