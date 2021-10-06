class AIReqDto {
  final String? rice;
  final String? mainDish;
  final String? soup;
  final String? serveDish;
  final String? vegetable;
  final String? dessert;

  AIReqDto(
    this.rice,
    this.mainDish,
    this.soup,
    this.serveDish,
    this.vegetable,
    this.dessert,
  );

  Map<String, dynamic> toJson() => {
        "rice": rice,
        "mainDish": mainDish,
        "soup": soup,
        "serveDish": serveDish,
        "vegetable": vegetable,
        "desert": dessert,
      };
}
