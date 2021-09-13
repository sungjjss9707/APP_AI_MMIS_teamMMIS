import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:myapp/model/menu.dart';
import 'package:myapp/user/user.dart';

import 'notice_page.dart';

class RateMenuPage extends StatefulWidget {
  final String date;
  final String time;

  const RateMenuPage(this.date, this.time);
  @override
  _RateMenuPageState createState() => _RateMenuPageState(date, time);
}

class _RateMenuPageState extends State<RateMenuPage> {
  String date, time; // 오늘 날짜
  String? beforeDate, beforeTime; // 내일 날짜
  String? afterDate, afterTime; // 어제 날짜
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
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            _arrowAndDate(), // < 날짜(석식) 취식여부 >
            _menuAndRatings(),
            _saveRating(),
            TextButton(
              onPressed: () {
                setState(() {
                  if (isEating!) {
                    addUserNotEating(date, time);
                    isEating = false;
                  } else {
                    removeUserNotEating(date, time);
                    isEating = true;
                  }
                  print(userNotEating);
                });
              },
              child: isEating! ? Text("불취식신청") : Text("취식신청"),
            ),
            TextButton(
              onPressed: () {},
              child: Text("건의하기"),
            ),
          ],
        ),
      ),
    );
  }

  Row _arrowAndDate() {
    return Row(
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
            color: isLeft ? Colors.black : Colors.grey,
          ),
        ),
        SizedBox(width: 10),
        Container(
          child: Center(child: Text("$date ($time)")),
          width: 140,
        ),
        SizedBox(width: 10),
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
            color: isRight ? Colors.black : Colors.grey,
          ),
        ),
      ],
    );
  }

  Column _menuAndRatings() {
    return Column(
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
}
