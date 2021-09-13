String userName = "최윤호";
String classes = "병장";
String army = "공군";
String unit = "8전투비행단";

Map<String, List> userNotEating = {
  "2021-09-10": ["석식"]
};

void addUserNotEating(String date, String time) {
  if (userNotEating[date] == null) {
    userNotEating[date] = [time];
  } else {
    userNotEating[date]!.add(time);
  }
}

void removeUserNotEating(String date, String time) {
  userNotEating[date]!.remove(time);
  if (userNotEating[date]!.length == 0) userNotEating.remove(date);
}

bool checkIfEating(String date, String time) {
  if (userNotEating[date] == null) {
    return true;
  } else if (userNotEating[date]!.contains(time)) {
    return false;
  } else
    return true;
}
