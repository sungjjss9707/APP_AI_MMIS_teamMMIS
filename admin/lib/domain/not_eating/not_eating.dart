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

class Reason {
  final List? reasonBreakFast;
  final List? reasonBrunch;
  final List? reasonLunch;
  final List? reasonDinner;

  Reason(this.reasonBreakFast, this.reasonBrunch, this.reasonLunch,
      this.reasonDinner);

  Reason.fromNotEatings(List<NotEating> notEatings)
      : reasonBreakFast = notEatings[0].reason!.values.toList(),
        reasonBrunch = notEatings[1].reason!.values.toList(),
        reasonLunch = notEatings[2].reason!.values.toList(),
        reasonDinner = notEatings[3].reason!.values.toList();
}
