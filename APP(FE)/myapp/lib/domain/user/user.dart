import 'package:intl/intl.dart';

class User {
  final int? id;
  final String? username;
  final String? militaryNumber;
  // 계급
  final String? rank;
  // 소속
  final String? unit;
  final Map<String, dynamic>? allergy;

  User({
    this.id,
    this.username,
    this.militaryNumber,
    this.rank,
    this.unit,
    this.allergy,
  });

  User.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        username = json["name"],
        militaryNumber = json["militaryNumber"],
        rank = json["grade"],
        unit = json["belong"],
        allergy = json["allergy"];
}
