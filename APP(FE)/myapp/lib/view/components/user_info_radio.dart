import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myapp/user/user_ex.dart';

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
      children: [
        Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 50.w,
              child: Text(
                  text.length == 3 ? text : "  " * (3 - text.length) + text,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13.sp,
                      color: Colors.black)),
            ),
            SizedBox(width: 50.w),
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
                    fontSize: 13.sp,
                    color: Colors.black54)),
            SizedBox(width: 50.w),
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
                    fontSize: 13.sp,
                    color: Colors.black54)),
          ],
        ),
      ],
    );
  }
}
