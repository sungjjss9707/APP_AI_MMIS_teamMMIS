import 'package:admin/domain/not_eating/not_eating.dart';
import 'package:flutter/material.dart';

import 'package:json_table/json_table.dart';

class CustomSimpleTable extends StatelessWidget {
  final Map<String, NotEating> notEatings;
  const CustomSimpleTable(this.notEatings);
//미완
  @override
  Widget build(BuildContext context) {
    // string은 조식, 브런치, 중식, 석식
    Map<String, int> reasonData = convertReasonForSimpleTable(notEatings);
    return JsonTable(
      [reasonData],
      columns: [JsonTableColumn("조식")],
    );
  }
}
