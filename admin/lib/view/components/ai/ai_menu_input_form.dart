import 'package:admin/util/validators.dart';
import 'package:admin/view/components/menu_manage/menuInputTextField.dart';
import 'package:flutter/material.dart';

import '../../../size.dart';

class AIMenuInputForm extends StatefulWidget {
  final formKey = GlobalKey<FormState>();
  AIMenuInputForm({Key? key}) : super(key: key);

  @override
  _AIMenuInputFormState createState() => _AIMenuInputFormState();
}

class _AIMenuInputFormState extends State<AIMenuInputForm> {
  List<TextEditingController> textEditingControllerList = [];

  List<MenuInputTextField> menuInputTextField = [];

  @override
  void initState() {
    menuInputTextField.add(
      MenuInputTextField(
        index: menuInputTextField.length,
        funValidate: validateMenu(),
      ),
    );
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
    return Container(
      child: Form(
        key: widget.formKey,
        child: Column(
          children: _menuInputTextFieldGenerate(),
        ),
      ),
    );
  }

  void menuInputTextFieldAdd() {
    setState(() {
      int index = menuInputTextField.length;
      menuInputTextField.add(
        MenuInputTextField(
          index: index,
          funValidate: validateMenu(),
        ),
      );
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
          Flexible(child: menuInputTextField[index]),
          SizedBox(width: gap_xs),
          index == menuInputTextField.length - 1
              ? IconButton(
                  onPressed: () {
                    menuInputTextFieldAdd();
                  },
                  icon: Icon(Icons.add),
                )
              : IconButton(
                  onPressed: () {
                    menuInputTextFieldRemove(index);
                  },
                  icon: Icon(Icons.delete),
                ),
          index > 0 && index == menuInputTextField.length - 1
              ? IconButton(
                  onPressed: () {
                    menuInputTextFieldRemove(index);
                  },
                  icon: Icon(Icons.delete),
                )
              : IconButton(onPressed: () {}, icon: Container()),
        ],
      ),
    );
  }

  // Widget _buttons() {
  //   return Row(
  //     children: [
  //       CustomElevatedButton(
  //         text: "저장",
  //         onPressed: () {
  //           if (_formKey.currentState!.validate()) {
  //             List<String> menuList = [];
  //             for (MenuInputTextField i in menuInputTextField) {
  //               if (i.controller.text.length != 0)
  //                 menuList.add(i.controller.text.trim());
  //               addMenu(widget.date, widget.time, menuList);
  //             }
  //             showDialog(
  //               context: context,
  //               builder: (context) => AlertDialog(
  //                 content: Text("저장되었습니다."),
  //               ),
  //             );
  //           }
  //         },
  //       ),
  //       SizedBox(width: gap_m),
  //       CustomElevatedButton(text: "취소"),
  //     ],
  //   );
  // }
}
