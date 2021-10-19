class JoinReqDto {
  final String? unit;
  final String? rank;
  final String? militaryNumber;
  final String? password;
  final String? name;

  JoinReqDto(
    this.name,
    this.militaryNumber,
    this.password,
    this.rank,
    this.unit,
  );

  Map<String, dynamic> toJson() => {
        "name": name,
        "militaryNumber": militaryNumber,
        "password": password,
        "grade": rank,
        "belong": unit,
      };
}
