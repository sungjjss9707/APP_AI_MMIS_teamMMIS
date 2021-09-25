import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:myapp/date_functions.dart';
import 'package:myapp/model/menu.dart';
import 'package:myapp/user/user.dart';
import 'package:myapp/view/components/appBar/sub_page_appbar.dart';
import 'package:myapp/view/components/button/back_button.dart';
import 'package:myapp/view/components/custom_drawer.dart';
import 'package:myapp/view/components/nutrition_box.dart';
import 'package:myapp/view/pages/subpages/write_suggestion_page.dart';

class RateMenuPage extends StatefulWidget {
  final String date;
  final String time;

  const RateMenuPage(this.date, this.time);
  @override
  _RateMenuPageState createState() => _RateMenuPageState(date, time);
}

class _RateMenuPageState extends State<RateMenuPage> {
  String date, time; // 오늘 날짜
  String? beforeDate, beforeTime, afterDate, afterTime; // 어제, 내일 날짜
  Menu? menu;
  List<double>? rating;
  List<String>? menuPlate;
  int? index;
  bool isLeft = false, isRight = false;
  bool? isEating;
  bool isSave = false;

  _RateMenuPageState(this.date, this.time);

  @override
  Widget build(BuildContext context) {
    isEating = checkIfEating(date, time);
    menu = getMenuByDateAndTime(date, time, dummyMenu);
    rating = menu!.rating;
    menuPlate = menu!.menuPlate;
    index = getMenuIndexByDateAndTime(date, time, dummyMenu);
    if (index != 0) {
      isLeft = true;
      beforeDate = dummyMenu[index! - 1].date;
      beforeTime = dummyMenu[index! - 1].time;
    }
    if (index != dummyMenu.length - 1) {
      isRight = true;
      afterDate = dummyMenu[index! + 1].date;
      afterTime = dummyMenu[index! + 1].time;
    }
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: subPageAppBar("8전투비행단"),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            _arrowAndDate(), // < 날짜(석식) 취식여부 >
            _nutritionInfo(),
            _menuLists(),
            _saveRating(),
            _notEatingApplyButton(),
            _suggestingButton(),
          ],
        ),
      ),
    );
  }

  Widget _arrowAndDate() {
    return Padding(
      padding: const EdgeInsets.only(right: 8, left: 8, bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              if (isLeft == true) {
                setState(() {
                  date = beforeDate!;
                  time = beforeTime!;
                  isLeft = isRight = false;
                });
              }
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: isLeft ? Colors.grey[800] : Colors.grey[500],
            ),
          ),
          Spacer(),
          Container(
            child: Center(
                child:
                    Text("${getMonthDayAndWeekdayInKorean(date)} (${time})")),
            width: 140,
          ),
          Spacer(),
          IconButton(
            onPressed: () {
              if (isRight == true) {
                setState(() {
                  date = afterDate!;
                  time = afterTime!;
                  isLeft = isRight = false;
                });
              }
            },
            icon: Icon(
              Icons.arrow_forward_ios,
              color: isRight ? Colors.grey[800] : Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  Widget _nutritionInfo() => Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          title: Row(
            children: [
              Spacer(),
              Text(
                "-Kcal",
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 13,
                ),
              ),
              Container(
                height: 14,
                child: VerticalDivider(
                  color: Colors.black54,
                ),
              ),
              Text(
                "한끼 영양량",
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 13,
                ),
              )
            ],
          ),
          children: [
            NutritionBox(),
          ],
        ),
      );

  Widget _menuLists() {
    return Expanded(
      child: ListView(
        children: List.generate(
          menuPlate!.length,
          (index) {
            return Column(
              children: [
                _menuTitle(menuPlate!, index),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _menuTitle(List<String> menu, int index) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        initiallyExpanded: false,
        title: Text(
          menu[index],
          style: TextStyle(fontSize: 14),
        ),
        children: [
          NutritionBox(),
        ],
      ),
    );
  }

  Widget _saveRating() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        children: [
          RatingBar(
            itemPadding: EdgeInsets.symmetric(horizontal: 1),
            itemSize: 16,
            initialRating: 0,
            itemCount: 5,
            unratedColor: Colors.red.withAlpha(50),
            allowHalfRating: false,
            ratingWidget: RatingWidget(
              full: Image.asset(
                "hearts/heart.png",
                color: Colors.red,
              ),
              half: Image.asset(
                "hearts/heart_half.png",
                color: Colors.red,
              ),
              empty: Image.asset(
                "hearts/heart_border.png",
                color: Colors.grey,
              ),
            ),
            onRatingUpdate: (score) {
              setState(() {
                print(score);
              });
            },
          ),
          Spacer(),
          TextButton(
            onPressed: () {
              isSave = true;
              print(rating);
              //여기서 통신해야 됨.
            },
            child: Text("저장하기"),
          ),
        ],
      ),
    );
  }

  Widget _notEatingApplyButton() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            if (isEating!) {
              addUserNotEating(date, time);
              isEating = false;
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => AlertDialog(
                  content: Text("불취식 신청 되었습니다."),
                  actions: [
                    CustomBackButton(text: "돌아가기"),
                  ],
                ),
              );
            } else {
              removeUserNotEating(date, time);
              isEating = true;
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => AlertDialog(
                  content: Text("취식 신청 되었습니다."),
                  actions: [
                    CustomBackButton(text: '돌아가기'),
                  ],
                ),
              );
            }
          });
        },
        child: isEating! ? Text("불취식신청") : Text("취식신청"),
        style: ElevatedButton.styleFrom(
          primary: isEating! ? Colors.lightGreen[400] : Colors.lightBlue,
          minimumSize: Size(double.infinity, 50),
        ),
      ),
    );
  }

  Widget _suggestingButton() {
    return ElevatedButton(
      onPressed: () {
        Get.to(() => WriteSuggestionPage());
      },
      child: Text("건의하기"),
      style: ElevatedButton.styleFrom(
        primary: Colors.green,
        minimumSize: Size(double.infinity, 50),
      ),
    );
  }
}
