import 'package:admin/style.dart';
import 'package:flutter/material.dart';

import '../../../size.dart';

class ShowMenuList extends StatelessWidget {
  final String time;
  final List<String>? menus;

  const ShowMenuList({this.menus, required this.time});
  @override
  Widget build(BuildContext context) {
    return menus != null
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${time}",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: gap_s),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: menus!.map((e) => Text(e, style: body1())).toList(),
              ),
            ],
          )
        : Center(child: Text("입력된 식단 정보가 없습니다."));
  }
}
