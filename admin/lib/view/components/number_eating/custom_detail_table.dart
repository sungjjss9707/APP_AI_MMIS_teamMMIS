import 'package:admin/domain/not_eating/not_eating.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:json_table/json_table.dart';

class CustomDetailTable extends StatelessWidget {
  final Map<String, NotEating> notEatings;
  const CustomDetailTable(this.notEatings);

  @override
  Widget build(BuildContext context) {
    // string은 조식, 브런치, 중식, 석식
    Map<String, List> reasonData = convertReasonForDetailTable(notEatings);
    return Column(
      children: reasonData.entries.map((e) {
        return Column(
          children: [
            Text(e.key),
            JsonTable(
              e.value,
              columns: [
                JsonTableColumn("name", label: "이름"),
                JsonTableColumn("militaryNumber", label: "군번"),
                //여기 rank 대신 고쳐야 겠지.
                JsonTableColumn("rank", label: "계급"),
                JsonTableColumn("notEatingReason", label: "사유"),
              ],
            ),
          ],
        );
      }).toList(),
    );
  }
}
