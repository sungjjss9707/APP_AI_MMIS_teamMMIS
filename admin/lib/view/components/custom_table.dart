import 'package:admin/controller/not_eating_controller.dart';
import 'package:admin/domain/not_eating/not_eating.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:json_table/json_table.dart';

class CustomTable extends StatefulWidget {
  @override
  _CustomTableState createState() => _CustomTableState();
}

class _CustomTableState extends State<CustomTable> {
  final NotEatingController not = Get.find();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Reason reason = Reason.fromNotEatings(not.notEatings);

    return reason.reasonBreakFast!.length != 0
        ? JsonTable(
            reason.reasonBreakFast![0],
            columns: [
              JsonTableColumn("name", label: "이름"),
              JsonTableColumn("militaryNumber ", label: "군번"),
              JsonTableColumn("rank", label: "계급"),
            ],
          )
        : Container();
  }
}
