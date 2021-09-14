import 'package:flutter/material.dart';

class UserInfoRadio extends StatefulWidget {
  String text;
  bool allergy;
  UserInfoRadio({required this.allergy, required this.text});
  _UserInfoRadioState createState() =>
      _UserInfoRadioState(allergy: allergy, text: text);
}

enum YesOrNo { yes, no }

class _UserInfoRadioState extends State<UserInfoRadio> {
  String text;
  bool allergy;
  YesOrNo? v;
  _UserInfoRadioState({required this.allergy, required this.text})
      : v = allergy == true ? YesOrNo.yes : YesOrNo.no;

  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(text,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.black)),
            SizedBox(width: 50),
            Radio(
              value: YesOrNo.yes,
              groupValue: v,
              onChanged: (YesOrNo? value) {},
            ),
            Text("있음",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.black54)),
            SizedBox(width: 50),
            Radio(
              value: YesOrNo.no,
              groupValue: v,
              onChanged: (YesOrNo? value) {},
            ),
            Text("없음",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.black54)),
          ],
        ),
      ],
    );
  }
}
