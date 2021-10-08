class MenuSaveDto {
  final String name;
  final Map<String, String> nutrition;
  final Map<String, String> allergy;

  MenuSaveDto(this.name, this.nutrition, this.allergy);

  Map<String, dynamic> toJson() => {
        "name": name,
        "nutrition": nutrition,
        "allergy": allergy,
      };
}
