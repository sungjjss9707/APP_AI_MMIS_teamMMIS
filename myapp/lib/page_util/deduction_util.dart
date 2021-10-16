import 'package:myapp/user/user_ex.dart';

List calDeduction() {
  final notEatings = userNotEating;
  int count = 0;
  Map<DateTime, List<String>> temp = {};
  DateTime now = DateTime.now();
  final year = now.year.toString();
  final month = (now.month).toString();
  final days = notEatings[year]?[month]?.keys.toList();
  if (days != null) {
    for (int k = 0; k < days.length; ++k) {
      count += notEatings[year]![month]![days[k]]!.length;
      temp[DateTime.utc(
              int.parse(year), int.parse(month), int.parse(days[k]))] =
          notEatings[year]![month]![days[k]]!;
    }
  }
  return [temp, count];
}
