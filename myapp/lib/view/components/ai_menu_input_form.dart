import 'package:flutter/material.dart';
import 'package:myapp/page_util/validators.dart';
import 'package:myapp/view/components/textfield/menu_input_textfield.dart';

import '../../../size.dart';

class AIMenuInputForm extends StatefulWidget {
  final formKey = GlobalKey<FormState>();
  AIMenuInputForm({Key? key}) : super(key: key);
  final List<MenuInputTextField> menuInputTextField = [];
  @override
  _AIMenuInputFormState createState() => _AIMenuInputFormState();
}

class _AIMenuInputFormState extends State<AIMenuInputForm> {
  List<TextEditingController> textEditingControllerList = [];

  @override
  void initState() {
    widget.menuInputTextField.add(
      MenuInputTextField(
        index: widget.menuInputTextField.length,
        funValidate: validateMenu(),
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    for (MenuInputTextField i in widget.menuInputTextField) {
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
      int index = widget.menuInputTextField.length;
      widget.menuInputTextField.add(
        MenuInputTextField(
          index: index,
          funValidate: validateMenu(),
        ),
      );
    });
  }

  void menuInputTextFieldRemove(int index) {
    setState(() {
      widget.menuInputTextField.removeAt(index);
      for (MenuInputTextField i in widget.menuInputTextField) {
        i.index = widget.menuInputTextField.indexOf(i);
      }
    });
  }

  List<Widget> _menuInputTextFieldGenerate() {
    return List.generate(
      widget.menuInputTextField.length,
      (index) => Row(
        children: [
          Flexible(child: widget.menuInputTextField[index]),
          SizedBox(width: gap_xs),
          index == widget.menuInputTextField.length - 1
              ? IconButton(
                  onPressed: () {
                    menuInputTextFieldAdd();
                  },
                  icon: Icon(
                    Icons.add,
                    color: Colors.black,
                  ),
                )
              : IconButton(
                  onPressed: () {
                    menuInputTextFieldRemove(index);
                  },
                  icon: Icon(
                    Icons.delete,
                    color: Colors.black,
                  ),
                ),
          index > 0 && index == widget.menuInputTextField.length - 1
              ? IconButton(
                  onPressed: () {
                    menuInputTextFieldRemove(index);
                  },
                  icon: Icon(
                    Icons.delete,
                    color: Colors.black,
                  ),
                )
              : IconButton(onPressed: () {}, icon: Container()),
        ],
      ),
    );
  }
}
