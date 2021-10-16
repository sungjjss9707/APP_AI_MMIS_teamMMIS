import 'package:admin/domain/not_eating/not_eating.dart';
import 'package:admin/size.dart';
import 'package:flutter/material.dart';

import 'package:json_table/json_table.dart';

import '../../../style.dart';

class CustomSimpleTable extends StatelessWidget {
  final Map<String, NotEating> notEatings;
  const CustomSimpleTable(this.notEatings);
//미완
  @override
  Widget build(BuildContext context) {
    // string은 조식, 브런치, 중식, 석식
    Map<String, int> reasonData = convertReasonForSimpleTable(notEatings);
    Map<String, String> totalNumData =
        convertTotalNumForSimpleTable(notEatings);
    Map<String, int> dummyReasonData = {"조식": 3, "브런치": 3, "중식": 3, "석식": 2};
    Map<String, String> dummyTotalNumData = {
      "조식": "100",
      "브런치": "100",
      "중식": "100",
      "석식": "100"
    };
    return Column(
      children: [
        _totalNumTable(dummyTotalNumData),
        SizedBox(height: gap_m),
        _notEatingNumTable(dummyReasonData)
      ],
    );
  }

  Widget _totalNumTable(Map<String, String> totalNumData) {
    return Column(
      children: [
        Text(
          "전체 식수 인원",
          style: subtitle1(),
        ),
        SizedBox(height: gap_s),
        JsonTable(
          [totalNumData],
          tableHeaderBuilder: (header) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              decoration: BoxDecoration(
                  border: Border.all(width: 0.5), color: Colors.grey[300]),
              child: Text(
                header.toString(),
                textAlign: TextAlign.center,
              ),
            );
          },
          tableCellBuilder: (value) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
              decoration: BoxDecoration(
                  border: Border.all(
                      width: 0.5, color: Colors.grey.withOpacity(0.5))),
              child: Text(
                value,
                textAlign: TextAlign.center,
              ),
            );
          },
          columns: [
            JsonTableColumn("조식", label: "조식(명)"),
            JsonTableColumn("브런치", label: "브런치(명)"),
            JsonTableColumn("중식", label: "중식(명)"),
            JsonTableColumn("석식", label: "석식(명)"),
          ],
        ),
      ],
    );
  }

  Widget _notEatingNumTable(Map<String, int> reasonData) {
    return Column(
      children: [
        Text(
          "불취식 인원",
          style: subtitle1(),
        ),
        SizedBox(height: gap_s),
        JsonTable(
          [reasonData],
          tableHeaderBuilder: (header) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              decoration: BoxDecoration(
                  border: Border.all(width: 0.5), color: Colors.grey[300]),
              child: Text(
                header.toString(),
                textAlign: TextAlign.center,
              ),
            );
          },
          tableCellBuilder: (value) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
              decoration: BoxDecoration(
                  border: Border.all(
                      width: 0.5, color: Colors.grey.withOpacity(0.5))),
              child: Text(
                value,
                textAlign: TextAlign.center,
              ),
            );
          },
          columns: [
            JsonTableColumn("조식", label: "조식(명)"),
            JsonTableColumn("브런치", label: "브런치(명)"),
            JsonTableColumn("중식", label: "중식(명)"),
            JsonTableColumn("석식", label: "석식(명)"),
          ],
        ),
      ],
    );
  }
}
