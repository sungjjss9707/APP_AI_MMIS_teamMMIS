import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:myapp/date_functions.dart';
import 'package:myapp/model/menu.dart';
import 'package:myapp/user/user_ex.dart';
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
  List<String>? menuPlate;
  int? index;
  bool isLeft = false, isRight = false;
  bool? isEating;
  bool isSave = false;
  late double initialRate;
  late double rate;
  _RateMenuPageState(this.date, this.time);

  @override
  void initState() {
    initialRate = 0;
    rate = initialRate;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    isEating = checkIfEating(date, time);
    menu = getMenuByDateAndTime(date, time, dummyMenu);
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
        padding: EdgeInsets.all(16.w),
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
          Center(
              child: Text("${getMonthDayAndWeekdayInKorean(date)} (${time})")),
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
          childrenPadding: EdgeInsets.all(8.0.r),
          title: Row(
            children: [
              Spacer(),
              Text(
                "-Kcal",
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 12.sp,
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
                  fontSize: 12.sp,
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
        childrenPadding: EdgeInsets.all(8.0.r),
        initiallyExpanded: false,
        title: Text(
          menu[index],
          style: TextStyle(fontSize: 13.sp),
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
      child: Container(
        padding: EdgeInsets.all(8.r),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[200]!),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "오늘 식사는 어떠셨나요?",
              style: TextStyle(
                fontSize: 14.sp,
              ),
            ),
            Row(
              children: [
                RatingBar(
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.w),
                  itemSize: 20.w,
                  initialRating: initialRate,
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
                      rate = score;
                    });
                  },
                ),
                Spacer(),
                TextButton(
                  onPressed: () {
                    isSave = true;
                    //rate을 저장하면 됨.
                    //여기서 통신해야 됨.
                  },
                  child: Text("저장하기"),
                ),
              ],
            ),
          ],
        ),
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
