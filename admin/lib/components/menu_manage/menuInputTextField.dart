import 'package:admin/size.dart';
import 'package:flutter/material.dart';

class MenuInputTextField extends StatelessWidget {
  int index;
  final String hint;
  final String? value;
  final funValidate;
  final controller = TextEditingController();
  final bool isFirst;
  final addOnPressed;
  final backOnPressed;
  //final String type;

  MenuInputTextField({
    this.hint = "메뉴",
    this.value,
    this.funValidate,
    this.isFirst = false,
    this.addOnPressed,
    this.backOnPressed,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: gap_xs),
      child: SizedBox(
        width: 220,
        height: 40,
        child: TextFormField(
          controller: controller,
          initialValue: value ?? null, //널이면 빈칸 넣으란 말임
          validator: funValidate,
          decoration: InputDecoration(
            hintText: "$hint", //이렇게 넣는게 더 좋음 걍 힌트 하지말고
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7),
            ),
          ),
        ),
      ),
    );
  }
}
