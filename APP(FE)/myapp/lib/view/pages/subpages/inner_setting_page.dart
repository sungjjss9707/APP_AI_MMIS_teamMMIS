import 'package:flutter/material.dart';

class InnerSettingPage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("설정내부",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.white)),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 20, left: 50, right: 50),
        child: Column(
          children: [
            SwitchForm(isChecked: false, text: "알림"),
            Divider(),
            SwitchForm(isChecked: false, text: "소리"),
            Divider(),
            SwitchForm(isChecked: false, text: "팝업"),
            Divider(),
            SwitchForm(isChecked: false, text: "일반"),
            Divider(),
            SwitchForm(isChecked: false, text: "배너"),
          ],
        ),
      ),
    );
  }
}

class SwitchForm extends StatefulWidget {
  String text;
  bool isChecked;
  SwitchForm({required this.isChecked, required this.text});
  _SwitchFormState createState() =>
      _SwitchFormState(isChecked: isChecked, text: text);
}

class _SwitchFormState extends State<SwitchForm> {
  String text;
  bool isChecked;
  _SwitchFormState({required this.isChecked, required this.text});
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            )),
        Spacer(),
        Switch(
          value: isChecked,
          onChanged: (value) {
            setState(() {
              isChecked = value;
            });
          },
        ),
      ],
    );
  }
}
