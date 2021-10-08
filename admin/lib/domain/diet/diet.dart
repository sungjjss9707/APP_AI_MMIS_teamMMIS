class Diet {
  final List<String>? menus;
  final int? id;

  Diet({this.id, this.menus});

  Diet.fromJsonMonth(Map<String, dynamic> json)
      : menus = json["menus"],
        id = json["id"];
  Diet.fromJDay(Map<String, dynamic> json)
      : menus = json["menus"],
        id = json["id"];
  Diet.fromJsonTime(Map<String, dynamic> json)
      : menus = json["menus"],
        id = json["id"];
}

dietMonth(Map<String, dynamic> json) {
  List days = json.keys.toList();
  for (String day in days) {}
}
