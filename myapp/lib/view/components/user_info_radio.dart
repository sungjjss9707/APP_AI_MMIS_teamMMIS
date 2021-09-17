import 'package:flutter/material.dart';
import 'package:myapp/user/user.dart';

class UserInfoRadio extends StatefulWidget {
  String text;
  bool enabled;
  UserInfoRadio({required this.text, required this.enabled});
  _UserInfoRadioState createState() =>
      _UserInfoRadioState(text: text, enabled: enabled);
}

enum YesOrNo { yes, no }

class _UserInfoRadioState extends State<UserInfoRadio> {
  String text;
  bool enabled;
  YesOrNo? v;
  _UserInfoRadioState({required this.text, required this.enabled})
      : v = userAllergy[text] == true ? YesOrNo.yes : YesOrNo.no;

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
              onChanged: enabled == false
                  ? (YesOrNo? value) {}
                  : (YesOrNo? value) {
                      setState(() {
                        v = value;
                        localUserAllergy[text] = true;
                      });
                    },
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
              onChanged: enabled == false
                  ? (YesOrNo? value) {}
                  : (YesOrNo? value) {
                      setState(() {
                        v = value;
                        localUserAllergy[text] = false;
                      });
                    },
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
