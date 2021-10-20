import 'package:flutter/material.dart';
import 'package:myapp/view/components/appBar/sub_page_appbar.dart';
import 'package:myapp/view/components/custom_drawer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: subPageAppBar("앱정보"),
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
                      "앱소개",
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          children: [
                            Image.asset(
                              "logo/logo_mmis.png",
                              fit: BoxFit.cover,
                            ),
                            Text(
                                "MMIS는 장병들을 위한 병영식 정보 모바일 앱입니다. 최신화된 기술환경에 맞춰 인트라넷 및 수기 식에 머물러 있는 병영식 정보 수집, 불취식신청을 포함한 식수 인원 파악 등 장정들이 해야하는 병영식 관련 행정 처리를 일반 스마트폰에서 처리할 수 있는 플랫폼입니다."),
                          ],
                        ),
                      ),
                    ],
                  ),
                  ExpansionTile(
                    initiallyExpanded: false,
                    textColor: Colors.black,
                    title: Text(
                      "개발자 정보",
                    ),
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Column(
                          children: [
                            Text(
                                "팀장 : 최윤호 (potatohead12@gmail.com), Github Id: potatohead12"),
                            SizedBox(
                              height: 14.h,
                            ),
                            Text(
                                "문철운 (heiyin315@gmail.com), Github Id: cjfdns007"),
                            Text("성민 (pho0570@gmail.com), Github Id: mini-777"),
                            SizedBox(
                              height: 14.h,
                            ),
                            Text(
                                "성준혁 (sungjjh9707@gmail.com), Github Id: sungjjss9707"),
                            SizedBox(
                              height: 14.h,
                            ),
                            Text(
                                "최민호 (minhochoi.korea@gmail.com), Github Id: Paspachu"),
                            SizedBox(
                              height: 14.h,
                            ),
                            Text(
                                "홍유찬 (hychan0709@gmail.com), Github Id: onlyshine"),
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
