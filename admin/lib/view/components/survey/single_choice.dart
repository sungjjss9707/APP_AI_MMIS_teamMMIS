import 'package:admin/view/components/survey/single_choice_form_field.dart';

import 'package:flutter/material.dart';

import '../../../size.dart';

class SingleChoice extends StatefulWidget {
  final List<TextEditingController> textEditingControllers = [];
  SingleChoice({Key? key}) : super(key: key);
  @override
  SingleChoiceState createState() => SingleChoiceState();
}

class SingleChoiceState extends State<SingleChoice> {
  final List<ChoiceFormField> choices = [];
  @override
  void initState() {
    widget.textEditingControllers.clear();
    widget.textEditingControllers.add(TextEditingController());
    widget.textEditingControllers.add(TextEditingController());
    widget.textEditingControllers.add(TextEditingController());
    widget.textEditingControllers.add(TextEditingController());
    choices.addAll([
      ChoiceFormField(
        controller: widget.textEditingControllers[0],
        index: 0,
      ),
      ChoiceFormField(
        controller: widget.textEditingControllers[1],
        index: 1,
      ),
      ChoiceFormField(
        controller: widget.textEditingControllers[2],
        index: 2,
      ),
      ChoiceFormField(
        controller: widget.textEditingControllers[3],
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
        SizedBox(height: gap_s),
        Container(
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(10),
          ),
          child: IconButton(
            onPressed: () {
              _ChoiceFormFieldAdd();
            },
            icon: Icon(
              Icons.add,
            ),
          ),
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
                      _ChoiceFormFieldRemove(index);
                    });
                  },
                )
              : Container(),
        ],
      ),
    );
  }

  void _ChoiceFormFieldAdd() {
    setState(() {
      widget.textEditingControllers.add(TextEditingController());
      choices.add(
        ChoiceFormField(
          index: choices.length,
          controller: widget.textEditingControllers[choices.length],
        ),
      );
      // controllers.add(TextEditingController());
    });
  }

  void _ChoiceFormFieldRemove(int index) {
    setState(() {
      choices.removeAt(index);
      widget.textEditingControllers.removeAt(index);
      // controllers.removeAt(index);
      for (ChoiceFormField i in choices) {
        i.index = choices.indexOf(i);
      }
    });
  }
}
