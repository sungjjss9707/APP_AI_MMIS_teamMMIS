import 'package:admin/components/home/customTitle.dart';
import 'package:admin/components/home/home_header.dart';
import 'package:admin/size.dart';
import 'package:flutter/material.dart';

class CreateSurveyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          HomeHeader(),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(gap_xl),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomTitle("설문조사 생성"),
                Divider(color: Colors.grey),
              ],
            ),
          )
        ],
      ),
    );
  }
}
