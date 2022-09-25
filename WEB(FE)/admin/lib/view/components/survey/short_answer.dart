import 'package:admin/view/components/survey/single_choice_form_field.dart';
import 'package:flutter/material.dart';

class ShortAnswer extends StatelessWidget {
  const ShortAnswer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ChoiceFormField(
          enabled: false,
        ),
      ],
    );
  }
}
