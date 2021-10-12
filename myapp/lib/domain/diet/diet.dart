class Diet {
  final List<dynamic>? menus;
  final String? now;

  Diet({this.now, this.menus});

  Diet.fromJson(Map<String, dynamic> json)
      : menus = json["menus"],
        now = json["now"];
  // Diet.fromJDay(Map<String, dynamic> json)
  //     : menus = json["menus"],
  //       now = json["now"];
  // Diet.fromJsonTime(Map<String, dynamic> json)
  //     : menus = json["menus"],
  //       now = json["now"];
}

dietMonth(Map<String, dynamic> json) {
  List days = json.keys.toList();
  for (String day in days) {}
}
