import 'package:admin/model/menu.dart';
import 'package:admin/view/components/button/custom_elevated_button.dart';
import 'package:admin/view/components/menu_manage/menuInputTextField.dart';
import 'package:flutter/material.dart';

import '../../../size.dart';

class MenuInputForm extends StatefulWidget {
  final String time;
  final DateTime date;
  MenuInputForm({required this.time, required this.date});

  @override
  _MenuInputFormState createState() => _MenuInputFormState(time, date);
}

class _MenuInputFormState extends State<MenuInputForm> {
  final _formKey = GlobalKey<FormState>();
  final String time;
  final DateTime date;
  List<TextEditingController> textEditingControllerList = [];

  List<MenuInputTextField> menuInputTextField = [];

  _MenuInputFormState(this.time, this.date);
  @override
  void initState() {
    menuInputTextField
        .add(MenuInputTextField(index: menuInputTextField.length));
    super.initState();
  }

  @override
  void dispose() {
    for (MenuInputTextField i in menuInputTextField) {
      i.controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(date);
    return Container(
      width: 400,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
                Text(
                  "$time",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ] +
              _menuInputTextFieldGenerate() +
              [
                _buttons(),
              ],
        ),
      ),
    );
  }

  void menuInputTextFieldAdd() {
    setState(() {
      int index = menuInputTextField.length;
      menuInputTextField.add(MenuInputTextField(index: index));
    });
  }

  void menuInputTextFieldRemove(int index) {
    setState(() {
      menuInputTextField.removeAt(index);
      for (MenuInputTextField i in menuInputTextField) {
        i.index = menuInputTextField.indexOf(i);
      }
    });
  }

  List<Widget> _menuInputTextFieldGenerate() {
    return List.generate(
      menuInputTextField.length,
      (index) => Row(
        children: [
          menuInputTextField[index],
          SizedBox(width: gap_m),
          index == menuInputTextField.length - 1
              ? IconButton(
                  onPressed: () {
                    menuInputTextFieldAdd();
                  },
                  icon: Icon(Icons.add),
                )
              : Container(),
          index > 0
              ? IconButton(
                  onPressed: () {
                    menuInputTextFieldRemove(index);
                  },
                  icon: Icon(Icons.backspace),
                )
              : Container(),
        ],
      ),
    );
  }

  Widget _buttons() {
    return Row(
      children: [
        CustomElevatedButton(
          text: "저장",
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              List<String> menuList = [];
              for (MenuInputTextField i in menuInputTextField) {
                if (i.controller.text.length != 0)
                  menuList.add(i.controller.text.trim());
                addMenu(date, time, menuList);
              }
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  content: Text("저장되었습니다."),
                ),
              );
            }
          },
        ),
        SizedBox(width: gap_m),
        CustomElevatedButton(text: "취소"),
      ],
    );
  }
}
