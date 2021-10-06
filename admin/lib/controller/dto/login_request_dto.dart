class LoginReqDto {
  final String? militaryNumber;
  final String? password;

  LoginReqDto(this.militaryNumber, this.password);

  Map<String, dynamic> toJson() => {
        "militaryNumber": militaryNumber,
        "password": password,
      };
}
