class LoginReqDto {
  final String? militaryNumber;
  final String? password;

  LoginReqDto(this.militaryNumber, this.password);

  Map<String, dynamic> toJson() => {
        "군번": militaryNumber,
        "비밀번호": password,
      };
}
