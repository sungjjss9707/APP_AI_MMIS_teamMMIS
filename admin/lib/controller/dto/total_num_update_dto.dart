class TotalNumUpdateDto {
  final String totalNumberOfPeople;

  TotalNumUpdateDto(this.totalNumberOfPeople);

  Map<String, dynamic> toJson() => {
        "totalNumberOfPeople": totalNumberOfPeople,
      };
}
