class PostNotEatingDto {
  final String militaryNumber;
  final String reason;

  PostNotEatingDto(this.militaryNumber, this.reason);
  Map<String, dynamic> toJson() =>
      {"militaryNumber": militaryNumber, "reason": reason};
}
