class JoinOrUpdateReqDto {
  final String? unit;
  final String? rank;
  final String? militaryNumber;
  final String? password;
  final String? name;
  final Map<String, String>? allergy;

  JoinOrUpdateReqDto(
    this.name,
    this.militaryNumber,
    this.password,
    this.rank,
    this.unit,
    this.allergy,
  );

  Map<String, dynamic> toJson() => {
        "name": name,
        "militaryNumber": militaryNumber,
        "password": password,
        "grade": rank,
        "belong": unit,
        "allergy": allergy,
      };
}
