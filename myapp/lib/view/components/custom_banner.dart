import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:myapp/controller/notice_controller.dart';
import 'package:myapp/view/pages/subpages/notice_page.dart';

class CustomBanner extends StatelessWidget {
  final n = Get.put(NoticeController());
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: SizedBox(
        width: double.infinity,
        child: Obx(
          () => InkWell(
            onTap: () {
              Get.to(() => NoticePage());
            },
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.black26),
              ),
              child: Text(
                  n.notices.length == 0 ? "" : "[공지] ${n.notices.first.title}",
                  style: TextStyle(fontSize: 15.sp)),
            ),
          ),
        ),
      ),
    );
  }
}
