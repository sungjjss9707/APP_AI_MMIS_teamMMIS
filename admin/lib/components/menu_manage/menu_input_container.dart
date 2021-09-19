import 'package:admin/components/menu_manage/menu_input_form.dart';

import 'package:flutter/material.dart';

class MenuInputContainer extends StatefulWidget {
  final DateTime day;

  final List<String> inputedTime = ["조식", "중식"];
  MenuInputContainer({required this.day});
  @override
  _MenuInputContainerState createState() => _MenuInputContainerState(day);
}

class _MenuInputContainerState extends State<MenuInputContainer> {
  final DateTime day;

  _MenuInputContainerState(this.day);
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        MenuInputForm(time: "조식"),
        MenuInputForm(time: "브런치"),
        MenuInputForm(time: "중식"),
        MenuInputForm(time: "석식"),
      ],
    );
  }
}
