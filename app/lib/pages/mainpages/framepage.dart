import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_mmis/pages/mainpages/homepage.dart';
import 'package:project_mmis/pages/mainpages/setting_page.dart';
import 'package:project_mmis/pages/mainpages/show_photo_of_meal_page.dart';
import '../../get_today.dart';

class FramePage extends StatefulWidget {
  @override
  _FramePageState createState() => _FramePageState();
}

class _FramePageState extends State<FramePage> {
  int _selectedTapIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _drawer(context),
      appBar: _buildAppBar(),
      bottomNavigationBar: _buildBottomNavigationBar(),
      body: _selectedTapIndex == 0
          ? HomePage()
          : _selectedTapIndex == 1
              ? ShowPhotoOfMealPage()
              : SettingPage(),
    );
  }

  Widget _drawer(BuildContext context) {
    return Container(
      color: Colors.blueAccent,
      width: MediaQuery.of(context).size.width * 0.5,
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(
        getTodayInKorean(),
        style: TextStyle(fontSize: 16),
      ),
      actions: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("8전투비행단"),
            Text("병장 최윤호님"),
          ],
        ),
        SizedBox(width: 4),
      ],
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      backgroundColor: Colors.grey[300],
      unselectedFontSize: 10,
      selectedFontSize: 10,
      iconSize: 20,
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
