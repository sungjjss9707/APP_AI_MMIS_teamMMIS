import 'package:admin/view/components/survey/single_choice_form_field.dart';

import 'package:flutter/material.dart';

import '../../../size.dart';

class SingleChoice extends StatefulWidget {
  const SingleChoice({Key? key}) : super(key: key);
  @override
  SingleChoiceState createState() => SingleChoiceState();
}

class SingleChoiceState extends State<SingleChoice> {
  final List<ChoiceFormField> choices = [];
  @override
  void initState() {
    choices.addAll([
      ChoiceFormField(
        index: 0,
      ),
      ChoiceFormField(
        index: 1,
      ),
      ChoiceFormField(
        index: 2,
      ),
      ChoiceFormField(
        index: 3,
      ),
    ]);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = _choicesCustom();
    return Column(
      children: [
        Column(
          children: children,
        ),
        IconButton(
          onPressed: () {
            _singleChoiceFormFieldAdd();
          },
          icon: Icon(Icons.add),
        ),
      ],
    );
  }

  List<Widget> _choicesCustom() {
    return List.generate(
      choices.length,
      (index) => Row(
        children: [
          Icon(Icons.radio_button_on, size: 14),
          SizedBox(width: gap_xs),
          choices[index],
          SizedBox(width: gap_s),
          index > 0
              ? IconButton(
                  iconSize: 14,
                  icon: Icon(
                    Icons.cancel,
                  ),
                  onPressed: () {
                    setState(() {
                      _singleChoiceFormFieldRemove(index);
                    });
                  },
                )
              : Container(),
        ],
      ),
    );
  }

  void _singleChoiceFormFieldAdd() {
    setState(() {
      choices.add(ChoiceFormField(index: choices.length));
      // controllers.add(TextEditingController());
    });
  }

  void _singleChoiceFormFieldRemove(int index) {
    setState(() {
      choices.removeAt(index);
      // controllers.removeAt(index);
      for (ChoiceFormField i in choices) {
        i.index = choices.indexOf(i);
      }
    });
  }

  List<String> getData() {
    print('3');
    return choices.map((e) => e.controller.text).toList();
  }
}
