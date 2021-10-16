import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myapp/user/user_ex.dart';
import 'package:myapp/view/components/custom_drawer.dart';

import '../../../date_functions.dart';
import '../mainpages/homepage.dart';
import '../mainpages/setting_page.dart';
import '../mainpages/show_photo_of_meal_page.dart';

class FramePage extends StatefulWidget {
  @override
  _FramePageState createState() => _FramePageState();
}

class _FramePageState extends State<FramePage> {
  int _selectedTapIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: _buildAppBar(),
      bottomNavigationBar: _buildBottomNavigationBar(),
      body: _selectedTapIndex == 0
          ? HomePage()
          : _selectedTapIndex == 1
              ? ShowPhotoOfMealPage()
              : SettingPage(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(
        getTodayInKorean(),
        style: TextStyle(fontSize: 14.sp, color: Colors.white),
      ),
      actions: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              unit,
              style: TextStyle(color: Colors.white),
            ),
            Text(
              "${classes} ${userName}님",
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        SizedBox(width: 4.w),
      ],
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      backgroundColor: Colors.grey[200],
      unselectedFontSize: 10.sp,
      selectedFontSize: 10.sp,
      iconSize: 20.r,
      currentIndex: _selectedTapIndex,
      onTap: (index) {
        setState(() {
          _selectedTapIndex = index;
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "홈",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.photo_camera),
          label: "급식 자랑",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: "설정",
        ),
      ],
    );
  }
}
