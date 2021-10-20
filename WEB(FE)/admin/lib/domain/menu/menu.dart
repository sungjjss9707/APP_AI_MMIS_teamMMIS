class Menu {
  final String? name;
  final Map<String, dynamic>? nutrition;
  final Map<String, dynamic>? allergy;

  Menu({this.name, this.nutrition, this.allergy});

  Menu.fromJson(Map<String, dynamic> json)
      : name = json["name"],
        nutrition = json["nutrition"],
        allergy = json["allergy"];
}
