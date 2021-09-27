import 'package:flutter/material.dart';

import '../../../size.dart';
import '../../../style.dart';

class SingleChoiceFormField extends StatelessWidget {
  int index;
  final controller = TextEditingController();

  SingleChoiceFormField({required this.index});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextFormField(
        controller: controller,
        style: subtitle2(),
        decoration: InputDecoration(
          hintText: "옵션 ${index+1}",
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[200]!),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.lightGreen),
          ),
        ),
      ),
    );
  }
}
