class DietSaveDto {
  final String year;
  final String month;
  final String day;
  final String time;
  final List<String> diets;
  DietSaveDto(this.year, this.month, this.day, this.time, this.diets);

  Map<String, dynamic> toJson() => {
        "year": year,
        "month": month,
        "day": day,
        "time": time,
        "menus": diets,
      };
}
