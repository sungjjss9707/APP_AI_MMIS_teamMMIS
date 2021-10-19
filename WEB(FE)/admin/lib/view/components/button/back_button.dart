import 'package:flutter/material.dart';

Widget CustomBackButton(BuildContext context) {
  return ElevatedButton(
    onPressed: () {
      Navigator.pop(context);
    },
    child: Text("돌아가기"),
  );
}
