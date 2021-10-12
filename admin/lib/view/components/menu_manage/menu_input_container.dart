import 'package:admin/model/menu.dart';
import 'package:admin/view/components/button/custom_elevated_button.dart';
import 'package:admin/view/components/menu_manage/menu_input_form.dart';
import 'package:admin/view/components/menu_manage/newMenuInputDialog.dart';

import 'package:flutter/material.dart';

class MenuInputContainer extends StatelessWidget {
  final DateTime date;

  MenuInputContainer({required this.date});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomElevatedButton(
                text: "메뉴 추가",
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => NewMenuInputDialog(),
                  );
                },
              ),
            ],
          ),
          Wrap(
            children: [
              MenuInputForm(
                time: "조식",
                date: date,
                key: UniqueKey(),
              ),
              MenuInputForm(
                time: "브런치",
                date: date,
                key: UniqueKey(),
              ),
              MenuInputForm(
                time: "중식",
                date: date,
                key: UniqueKey(),
              ),
              MenuInputForm(
                time: "석식",
                date: date,
                key: UniqueKey(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<String> _inputTime() {
    return getMenuData(date).keys.toList();
  }
}
