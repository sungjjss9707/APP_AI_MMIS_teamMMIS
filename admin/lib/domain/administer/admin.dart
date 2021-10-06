import 'package:intl/intl.dart';

class Administer {
  final int? id;
  final String? username;
  final String? militaryNumber;
  // 계급
  final String? rank;
  // 소속
  final String? unit;
  final DateTime? created;
  final DateTime? updated;

  Administer({
    this.id,
    this.username,
    this.militaryNumber,
    this.rank,
    this.unit,
    this.created,
    this.updated,
  });

  Administer.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        username = json["name"],
        militaryNumber = json["militaryNumber"],
        rank = json["rank"],
        unit = json["unit"],
        created = DateFormat("yyyy-mm-dd").parse(json["created"]),
        updated = DateFormat("yyyy-mm-dd").parse(json["updated"]);
}
