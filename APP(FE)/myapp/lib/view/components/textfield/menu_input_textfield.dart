import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:myapp/page_util/Info.dart';

import '../../../size.dart';

class MenuInputTextField extends StatelessWidget {
  int index;
  final String hint;
  final String? value;
  final funValidate;
  final controller = TextEditingController();
  final bool isFirst;
  final addOnPressed;
  final backOnPressed;

  //final String type;

  MenuInputTextField({
    this.hint = "메뉴",
    this.value,
    this.funValidate,
    this.isFirst = false,
    this.addOnPressed,
    this.backOnPressed,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: gap_s),
      child: TypeAheadFormField(
        validator: funValidate,
        suggestionsBoxVerticalOffset: 2,
        textFieldConfiguration: TextFieldConfiguration(
          controller: controller,
          decoration: InputDecoration(
            hintText: "$hint", //이렇게 넣는게 더 좋음 걍 힌트 하지말고
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.lightGreen[600]!,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(7),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.lightGreen[600]!,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(7),
            ),
          ),
        ),
        onSuggestionSelected: (String suggestion) {
          controller.text = suggestion;
        },
        itemBuilder: (context, String suggestion) {
          return ListTile(
            title: Text(suggestion),
          );
        },
        suggestionsCallback: (pattern) => Menus.getSuggestions(pattern),
      ),
    );
  }
}
