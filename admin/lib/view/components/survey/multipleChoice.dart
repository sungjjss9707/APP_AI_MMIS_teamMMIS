import 'package:admin/view/components/survey/single_choice_form_field.dart';
import 'package:flutter/material.dart';

import '../../../size.dart';

class MultipleChoice extends StatefulWidget {
  @override
  _MultipleChoiceState createState() => _MultipleChoiceState();
}

class _MultipleChoiceState extends State<MultipleChoice> {
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
            _addSingleChoiceFormField();
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
          Icon(Icons.check_box_outline_blank_rounded, size: 14),
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
                      _removeSingleChoiceFormField(index);
                    });
                  },
                )
              : Container(),
        ],
      ),
    );
  }

  void _addSingleChoiceFormField() {
    setState(() {
      choices.add(SingleChoiceFormField(index: choices.length));
    });
  }

  void _removeSingleChoiceFormField(int index) {
    setState(() {
      choices.removeAt(index);
      for (SingleChoiceFormField i in choices) {
        i.index = choices.indexOf(i);
      }
    });
  }
}
