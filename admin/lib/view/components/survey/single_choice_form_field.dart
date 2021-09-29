import 'package:flutter/material.dart';

import '../../../size.dart';
import '../../../style.dart';

class ChoiceFormField extends StatelessWidget {
  int? index;
  final controller = TextEditingController();
  final bool? enabled;

  ChoiceFormField({this.index, this.enabled});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextFormField(
        enabled: enabled == false ? false : true,
        controller: controller,
        style: subtitle2(),
        decoration: InputDecoration(
          hintText: index != null ? "옵션 ${index! + 1}" : "답변",
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
