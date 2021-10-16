import 'package:admin/size.dart';
import 'package:admin/style.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double _width = getMediaQueryWidth(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 600,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("food.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Align(
            child: Opacity(
              opacity: 0.7,
              child: Container(
                padding: EdgeInsets.all(gap_m),
                width: 800,
                height: 400,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[300],
                ),
                child: Column(
                  children: [
                    Image.asset(
                      "black_logo_transparent.png",
                      height: _width > 540 ? 190 : 150,
                      fit: BoxFit.cover,
                    ),
                    Text(
                      "MMIS 군 급식 정보 체계",
                      style: _width > 540 ? h4() : h5(),
                    ),
                    Divider(),
                    Text(
                      "군 급식 정보 체계 관리자 홈페이지에 오신 것을 환영합니다. 부대원들에게 최고의 급식을 제공하기 위한 플랫폼입니다.",
                      style: h5(),
                      textAlign: TextAlign.center,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
