import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:myapp/date_functions.dart';
import 'package:myapp/model/menu.dart';
import 'package:myapp/user/user.dart';
import 'package:myapp/view/pages/initialpages/framepage.dart';
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
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.offAll(() => FramePage());
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text("8전투비행단"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            _arrowAndDate(), // < 날짜(석식) 취식여부 >
            _menuAndRatings(),
            _saveRating(),
            Spacer(),
            _notEatingApplyButton(),
            _suggestingButton(),
          ],
        ),
      ),
    );
  }

  Widget _arrowAndDate() {
    return Padding(
      padding: const EdgeInsets.only(right: 8, left: 8, bottom: 16.0),
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

  Widget _menuAndRatings() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(menuPlate!.length, (index) {
          if (index != menuPlate!.length - 1)
            return Column(
              children: [
                _menuAndRating(menuPlate!, index),
                SizedBox(height: 16),
              ],
            );
          return _menuAndRating(menuPlate!, index);
        }),
      ),
    );
  }

  Widget _menuAndRating(List<String> menu, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          menu[index],
          style: TextStyle(fontSize: 16),
        ),
        Spacer(),
        RatingBar(
          itemPadding: EdgeInsets.symmetric(horizontal: 1),
          itemSize: 16,
          initialRating: rating![index],
          itemCount: 5,
          unratedColor: Colors.pink.withAlpha(50),
          allowHalfRating: false,
          ratingWidget: RatingWidget(
            full: Image.asset(
              "hearts/heart.png",
              color: Colors.pink,
            ),
            half: Image.asset(
              "hearts/heart_half.png",
              color: Colors.pink,
            ),
            empty: Image.asset(
              "hearts/heart_border.png",
              color: Colors.pink,
            ),
          ),
          onRatingUpdate: (score) {
            setState(() {
              rating![index] = score;
              print(rating);
            });
          },
        )
      ],
    );
  }

  Row _saveRating() {
    return Row(
      children: [
        Spacer(),
        TextButton(
          onPressed: () {
            //여기서 통신해야 됨.
          },
          child: Text("저장하기"),
        ),
      ],
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
            } else {
              removeUserNotEating(date, time);
              isEating = true;
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
