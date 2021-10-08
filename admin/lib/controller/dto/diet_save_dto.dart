class DietSaveDto {
  final String year;
  final String month;
  final String day;
  final List<String> diets;
  DietSaveDto(this.year, this.month, this.day, this.diets);

  Map<String, dynamic> toJson() => {
        "year": year,
        "month": month,
        "day": day,
        "menus": diets,
      };
}
