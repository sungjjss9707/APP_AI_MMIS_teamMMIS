class DietUpdateDto {
  final List<String> diets;
  DietUpdateDto(this.diets);

  Map<String, dynamic> toJson() => {
        "menus": diets,
      };
}
