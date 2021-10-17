import 'package:admin/size.dart';
import 'package:admin/style.dart';
import 'package:flutter/material.dart';

class GuideSection1 extends StatelessWidget {
  final String imageName;
  final String title;
  final String content;

  const GuideSection1(
      {required this.imageName, required this.title, required this.content});
  @override
  Widget build(BuildContext context) {
    double _width = getMediaQueryWidth(context);
    return _width > 540
        ? Row(
            children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(gap_l * 2),
                  child: Image.asset(
                    imageName,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  child: Column(
                    children: [
                      Text(
                        title,
                        style: h5(),
                      ),
                      SizedBox(
                        height: gap_s,
                      ),
                      SizedBox(
                        width: 300,
                        child: Text(
                          content,
                          style: subtitle1(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        : Column(children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(gap_l),
                child: Image.asset(
                  imageName,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              child: Column(
                children: [
                  Text(
                    title,
                    style: h5(),
                  ),
                  SizedBox(
                    height: gap_s,
                  ),
                  SizedBox(
                    width: 300,
                    child: Text(
                      content,
                      style: subtitle1(),
                    ),
                  ),
                ],
              ),
            ),
          ]);
  }
}
