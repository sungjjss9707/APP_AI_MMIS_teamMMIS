import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myapp/allergy.dart';
import 'package:myapp/user/user_ex.dart';
import 'package:myapp/view/components/appBar/sub_page_appbar.dart';
import 'package:myapp/view/components/custom_drawer.dart';

class AllergyInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: subPageAppBar("알레르기 정보"),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 20.h, bottom: 10.h),
            child: Center(
              child: Text("내 알레르기",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  )),
            ),
          ),
          ...allergyName.map((allergy) => userAllergy[allergy] == true
              ? AllergyInfo(allergy: allergy)
              : SizedBox(width: 0, height: 0)),
          if (userAllergy.values.toList().contains(false)) Divider(),
          if (userAllergy.values.toList().contains(false))
            Padding(
              padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
              child: Center(
                child: Text("기타 알레르기",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    )),
              ),
            ),
          ...allergyName.map((allergy) => userAllergy[allergy] == false
              ? AllergyInfo(allergy: allergy)
              : SizedBox(width: 0, height: 0))
        ],
      ),
    );
  }
}

class AllergyInfo extends StatelessWidget {
  final String allergy;
  AllergyInfo({required this.allergy});
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      initiallyExpanded: false,
      textColor: Colors.black,
      title: Text("$allergy 알레르기",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 13.sp,
            color: Colors.black54,
          )),
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Wrap(
            children: [
              Text(allergyInfo[allergy]!,
                  style: TextStyle(fontSize: 12.sp, color: Colors.black87)),
            ],
          ),
        ),
        SizedBox(height: 10.h)
      ],
    );
  }
}
