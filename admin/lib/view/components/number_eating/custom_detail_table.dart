import 'package:admin/domain/not_eating/not_eating.dart';
import 'package:admin/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:json_table/json_table.dart';

class CustomDetailTable extends StatelessWidget {
  final Map<String, NotEating> notEatings;
  CustomDetailTable(this.notEatings);

  @override
  Widget build(BuildContext context) {
    // string은 조식, 브런치, 중식, 석식
    Map<String, List> reasonData = convertReasonForDetailTable(notEatings);
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 30,
        runSpacing: 20,
        children: _dummyReasonData.entries.map((e) {
          return Column(
            children: [
              Text(e.key, style: subtitle1()),
              JsonTable(
                e.value,
                tableCellBuilder: (value) {
                  return Center(
                    child: Container(
                      height: 35,
                      padding:
                          EdgeInsets.symmetric(horizontal: 2.0, vertical: 2.0),
                      decoration: BoxDecoration(
                          border: Border.all(width: 0.5, color: Colors.grey)),
                      child: Text(
                        value,
                        textAlign: TextAlign.center,
                        style: body1(),
                      ),
                    ),
                  );
                },
                allowRowHighlight: true,
                columns: [
                  JsonTableColumn("name", label: " 이름 "),
                  JsonTableColumn("militaryNumber", label: "군번"),
                  //여기 rank 대신 고쳐야 겠지.
                  JsonTableColumn("grade", label: "계급"),
                  JsonTableColumn("notEatingReason", label: "사유"),
                ],
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  final Map<String, List> _dummyReasonData = {
    "조식": [
      {
        "name": "성준혁",
        "militaryNumber": "10-11111",
        "password": "1234",
        "grade": "일병",
        "belong": "xx사단",
        "notEatingReason": "당직"
      },
      {
        "name": "최윤호",
        "militaryNumber": "21-12325",
        "password": "1234",
        "grade": "병장",
        "belong": "xx사단",
        "notEatingReason": "당직"
      }
    ],
    "중식": [
      {
        "name": "문철운",
        "militaryNumber": "10-11111",
        "password": "1234",
        "grade": "일병",
        "belong": "xx사단",
        "notEatingReason": "당직"
      },
      {
        "name": "홍길동",
        "militaryNumber": "21-12325",
        "password": "1234",
        "grade": "일병",
        "belong": "xx사단",
        "notEatingReason": "당직"
      }
    ],
    "석식": [
      {
        "name": "성준혁",
        "militaryNumber": "10-11111",
        "password": "1234",
        "grade": "일병",
        "belong": "xx사단",
        "notEatingReason": "당직"
      },
    ],
  };
}
