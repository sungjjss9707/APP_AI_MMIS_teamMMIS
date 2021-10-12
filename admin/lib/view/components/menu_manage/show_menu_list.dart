import 'package:admin/style.dart';
import 'package:flutter/material.dart';

import '../../../size.dart';

class ShowMenuList extends StatelessWidget {
  final String time;
  final List<String>? menus;

  const ShowMenuList({this.menus, required this.time});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      margin: const EdgeInsets.all(gap_m),
      padding: const EdgeInsets.all(gap_m),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            time,
            style: subtitle1(),
          ),
          menus != null
              ? Column(
                  children: menus!.map((e) => Text(e, style: body1())).toList(),
                )
              : Text("입력된 정보가 없습니다."),
        ],
      ),
    );
  }
}
