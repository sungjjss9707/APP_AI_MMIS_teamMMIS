import 'package:admin/size.dart';

import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lightGreen[400],
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            SizedBox(
              width: gap_s,
            ),
            InkWell(
              onTap: () {},
              child: Text(
                "MMIS",
                style: TextStyle(fontSize: 30),
              ),
            ),
            Spacer(),
            InkWell(
              onTap: () {},
              child: Text(
                "로그아웃",
                style: TextStyle(fontSize: 30),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
