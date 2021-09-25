import 'package:flutter/material.dart';

class NutritionBox extends StatelessWidget {
  final carbohydrate;
  final protein;
  final fat;
  final vitaminA;
  final vitaminC;
  final calcium;
  final iron;
  final salt;
  final sugar;
  final TextStyle _textStyle = TextStyle(fontSize: 12, color: Colors.black54);

  NutritionBox(
      {this.carbohydrate = "-",
      this.protein = "-",
      this.fat = "-",
      this.vitaminA = "-",
      this.vitaminC = "-",
      this.calcium = "-",
      this.iron = "-",
      this.salt = "-",
      this.sugar = "-"});
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
              Expanded(
                  flex: 1, child: Text("비타민A ${vitaminA}g", style: _textStyle)),
              Expanded(
                  flex: 1, child: Text("비타민C ${vitaminC}g", style: _textStyle)),
              Expanded(
                  flex: 1, child: Text("칼슘 ${calcium}g", style: _textStyle)),
            ],
          ),
          Row(
            children: [
              Expanded(flex: 1, child: Text("철분 ${iron}g", style: _textStyle)),
              Expanded(flex: 1, child: Text("나트륨 ${salt}g", style: _textStyle)),
              Expanded(flex: 1, child: Text("당 ${sugar}g", style: _textStyle)),
            ],
          ),
        ],
      ),
    );
  }
}
