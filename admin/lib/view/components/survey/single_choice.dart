import 'package:admin/view/components/survey/single_choice_form_field.dart';
import 'package:flutter/material.dart';

import '../../../size.dart';

class SingleChoice extends StatefulWidget {
  @override
  _SingleChoiceState createState() => _SingleChoiceState();
}

class _SingleChoiceState extends State<SingleChoice> {
  final _formKey = GlobalKey<FormState>();
  final List<SingleChoiceFormField> choices = [];

  @override
  void initState() {
    choices.add(
      SingleChoiceFormField(index: 0),
    );
    choices.add(
      SingleChoiceFormField(index: 1),
    );
    choices.add(
      SingleChoiceFormField(index: 2),
    );
    choices.add(
      SingleChoiceFormField(index: 3),
    );
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
      choices.add(SingleChoiceFormField(index: choices.length));
    });
  }

  void _singleChoiceFormFieldRemove(int index) {
    setState(() {
      choices.removeAt(index);
      for (SingleChoiceFormField i in choices) {
        i.index = choices.indexOf(i);
      }
    });
  }
}
