class AIReqDto {
  final List<String>? menus;

  AIReqDto(
    this.menus,
  );

  Map<String, dynamic> toJson() => {
        "menus": menus,
      };
}
