import 'package:admin/components/button/custom_elevated_button.dart';
import 'package:admin/components/textfield/custom_text_form_field.dart';
import 'package:flutter/material.dart';

import '../../size.dart';

class MenuInputForm extends StatefulWidget {
  final String time;

  const MenuInputForm({required this.time});

  @override
  _MenuInputFormState createState() => _MenuInputFormState(time);
}

class _MenuInputFormState extends State<MenuInputForm> {
  final String time;
  int _formCount = 1; // 메뉴 입력 칸 개수

  _MenuInputFormState(this.time);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      child: Form(
        child: Column(
          children: <Widget>[Text("$time")] +
              List.generate(
                _formCount,
                (index) => Row(
                  children: [
                    SizedBox(
                      width: 250,
                      height: 50,
                      child: CustomTextFormField(
                        hint: "메뉴",
                      ),
                    ),
                    SizedBox(width: gap_l),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _formCount += 1;
                        });
                      },
                      icon: Icon(Icons.add),
                    ),
                    _formCount > 1
                        ? IconButton(
                            onPressed: () {
                              setState(() {
                                _formCount -= 1;
                              });
                            },
                            icon: Icon(Icons.backspace),
                          )
                        : Container(),
                  ],
                ),
              ) +
              [
                Row(
                  children: [
                    CustomElevatedButton(text: "저장"),
                    SizedBox(width: gap_m),
                    CustomElevatedButton(text: "취소"),
                  ],
                ),
              ],
        ),
      ),
    );
  }
}
