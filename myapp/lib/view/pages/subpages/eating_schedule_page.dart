import 'package:flutter/material.dart';
import 'package:myapp/user/user.dart';

class EatingSchedulePage extends StatefulWidget {
  @override
  _EatingSchedulePageState createState() => _EatingSchedulePageState();
}

class _EatingSchedulePageState extends State<EatingSchedulePage> {
  late int month;
  late int totalAmount;

  @override
  void initState() {
    DateTime now = DateTime.now();
    month = now.month;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("불취식 관리"),
      ),
      body: Column(
        children: [
          Text(
            "${userName}님의 ${month.toString()}월 공제예정금액은 ",
          )
        ],
      ),
    );
  }
}
