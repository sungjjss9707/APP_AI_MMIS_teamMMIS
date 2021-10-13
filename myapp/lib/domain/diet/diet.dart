class Diet {
  final List<dynamic>? menus;
  final String? now;

  Diet({this.now, this.menus});

  Diet.fromJson(Map<String, dynamic> json)
      : menus = json["menus"],
        now = json["now"];
}
