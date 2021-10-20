import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../../../size.dart';

class TagAndTextAheadFormField extends StatelessWidget {
  final String text;
  final controller;
  final funValidate;
  final obscureText;
  final suggestionsCallback;
  final String hint;

  const TagAndTextAheadFormField(
      {this.text = "",
      this.controller,
      this.funValidate,
      this.obscureText = false,
      this.suggestionsCallback,
      this.hint = ""});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$text",
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        SizedBox(height: gap_xs),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: TypeAheadFormField(
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
            suggestionsCallback: suggestionsCallback,
          ),
        ),
        SizedBox(height: gap_xs),
      ],
    );
  }
}
