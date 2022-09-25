class NotEating {
  final int? id;
  final String? totalNumberOfPeople;
  final Map<String, dynamic>? reason;

  NotEating({this.id, this.totalNumberOfPeople, this.reason});

  NotEating.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        totalNumberOfPeople = json["totalNumberOfPeople"],
        reason = json["reason"];
}

Map<String, List> convertReasonForDetailTable(
    Map<String, NotEating> notEatings) {
  Map<String, List> result = {};
  for (String key in notEatings.keys) {
    NotEating notEating = notEatings[key]!;
    List d = notEating.reason!["당직"];
    // List h = notEating.reason!["휴가"];
    List w = notEating.reason!["외출"];
    List g = notEating.reason!["근무"];
    List other = notEating.reason!["기타"];
    for (Map<String, dynamic> user in d) {
      user["notEatingReason"] = "당직";
    }
    // for (Map<String, dynamic> user in h) {
    //   user["notEatingReason"] = "휴가";
    // }
    for (Map<String, dynamic> user in w) {
      user["notEatingReason"] = "외출";
    }
    for (Map<String, dynamic> user in g) {
      user["notEatingReason"] = "근무";
    }
    for (Map<String, dynamic> user in other) {
      user["notEatingReason"] = "기타";
    }
    result[key] = d + w + g + other;
  }
  return result;
}

Map<String, int> convertReasonForSimpleTable(
    Map<String, NotEating> notEatings) {
  Map<String, List> a = convertReasonForDetailTable(notEatings);
  return a.map((key, value) => MapEntry(key, value.length));
}

Map<String, String> convertTotalNumForSimpleTable(
    Map<String, NotEating> notEatings) {
  return notEatings
      .map((key, value) => MapEntry(key, value.totalNumberOfPeople!));
}
