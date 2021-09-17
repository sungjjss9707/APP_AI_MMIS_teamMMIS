import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

String changeDate(String date) {
  return DateFormat('yyyy년 MM월 dd일').format(DateTime.parse(date)).toString();
}

class DeductionPage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "공제",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white),
        ),
        elevation: 2,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DeductionCount(count: 5),
            SizedBox(height: 20),
            Text("공제 내역",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            Divider(),
            DeductionHistory(
                date: changeDate("20210101"),
                time: "조식",
                onTap: () {
                  print("조식 확인");
                }),
            DeductionHistory(
                date: changeDate("20210101"),
                time: "중식",
                onTap: () {
                  print("중식 확인");
                }),
            DeductionHistory(
                date: changeDate("20210101"),
                time: "석식",
                onTap: () {
                  print("석식 확인");
                }),
            DeductionHistory(
                date: changeDate("20210102"),
                time: "조식",
                onTap: () {
                  print("조식 확인");
                }),
            DeductionHistory(
                date: changeDate("20210103"),
                time: "조식",
                onTap: () {
                  print("조식 확인");
                }),
          ],
        ),
      ),
    );
  }
}

class DeductionCount extends StatelessWidget {
  int count;
  DeductionCount({required this.count});
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black12, width: 3),
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 20, bottom: 20, right: 50, left: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "이번달 총 공제는 $count회 입니다.",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DeductionHistory extends StatelessWidget {
  String date;
  String time;
  final onTap;
  DeductionHistory(
      {required this.date, required this.time, required this.onTap});
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "$date $time",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.black54,
              ),
            ),
            Spacer(),
            OutlinedButton(
              child: Text(
                "내역확인",
                style: TextStyle(fontSize: 15, color: Colors.blue),
              ),
              style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                20,
              ))),
              onPressed: onTap,
            ),
          ],
        ),
        Divider(),
      ],
    );
  }
}
