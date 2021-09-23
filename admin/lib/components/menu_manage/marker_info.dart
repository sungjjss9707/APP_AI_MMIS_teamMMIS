import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../size.dart';

class MarkerInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 4, left: 32, right: 4, bottom: 4),
      padding: EdgeInsets.all(4),
      width: 330,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black45,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Text("조식 : "),
            Image.asset(
              "brunch.png",
              width: 14,
              height: 14,
            ),
            SizedBox(
              width: gap_m,
            ),
            Text("중식 : "),
            FaIcon(
              FontAwesomeIcons.solidSun,
              color: Colors.red,
              size: 14,
            ),
            SizedBox(
              width: gap_m,
            ),
            Text("석식 : "),
            FaIcon(
              FontAwesomeIcons.solidMoon,
              color: Colors.yellow,
              size: 14,
            ),
            SizedBox(
              width: gap_m,
            ),
            Text("브런치 : "),
            Image.asset(
              "brunch.png",
              width: 14,
              height: 14,
            ),
            SizedBox(
              width: gap_m,
            ),
          ],
        ),
      ),
    );
  }
}
