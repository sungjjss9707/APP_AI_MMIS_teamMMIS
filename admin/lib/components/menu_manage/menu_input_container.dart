import 'package:admin/components/menu_manage/menu_input_form.dart';
import 'package:admin/model/menu.dart';

import 'package:flutter/material.dart';

class MenuInputContainer extends StatelessWidget {
  final DateTime date;

  MenuInputContainer({required this.date});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        children: [
          MenuInputForm(time: "조식", date: date),
          MenuInputForm(time: "브런치", date: date),
          MenuInputForm(time: "중식", date: date),
          MenuInputForm(time: "석식", date: date),
        ],
      ),
    );
  }

  List<String> inputTime() {
    return getMenuData(date).keys.toList();
  }
}
