import 'package:flutter/material.dart';

class AppInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "앱정보",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                Text("앱 버전",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                Spacer(),
                Text("1.0.0",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              ],
            ),
            Divider(),
            Expanded(
              child: ListView(
                children: [
                  ExpansionTile(
                    initiallyExpanded: false,
                    textColor: Colors.black,
                    title: Text(
                      "개인정보이용",
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          children: [
                            Text("개인정보 이용 관련 내용들"),
                          ],
                        ),
                      ),
                    ],
                  ),
                  ExpansionTile(
                    initiallyExpanded: false,
                    textColor: Colors.black,
                    title: Text(
                      "이용약관",
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          children: [
                            Text("이용약관 내용들"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
