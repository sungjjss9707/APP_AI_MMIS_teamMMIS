import 'package:flutter/material.dart';

class NutritionBox extends StatelessWidget {
  final String menuName;
  final carbohydrate;
  final protein;
  final fat;

  final salt;
  final cholesterol;
  final TextStyle _textStyle = TextStyle(fontSize: 12, color: Colors.black54);

  NutritionBox(
    this.menuName, {
    this.carbohydrate = "-",
    this.protein = "-",
    this.fat = "-",
    this.salt = "-",
    this.cholesterol = "-",
  });
  // NutritionBox.fromJson(Map<String, dynamic> nutrition)
  //     : carbohydrate = nutrition["탄수화물"] ?? "-",
  //       protein = nutrition["단백질"] ?? "-",
  //       fat = nutrition["지방"] ?? "-",
  //       salt = nutrition["나트륨"] ?? "-",
  //       cholesterol = nutrition["콜레스테롤"] ?? "-";
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  flex: 1,
                  child: Text("탄수화물 ${carbohydrate}g", style: _textStyle)),
              Expanded(
                  flex: 1, child: Text("단백질 ${protein}g", style: _textStyle)),
              Expanded(flex: 1, child: Text("지방 ${fat}g", style: _textStyle)),
            ],
          ),
          Row(
            children: [
              Expanded(flex: 1, child: Text("나트륨 ${salt}g", style: _textStyle)),
              Expanded(
                  flex: 1,
                  child: Text("콜레스테롤 ${cholesterol}g", style: _textStyle)),
              Expanded(flex: 1, child: Container()),
            ],
          ),
        ],
      ),
    );
  }
}
