import 'package:admin/controller/diet_controller.dart';
import 'package:admin/domain/diet/diet.dart';
import 'package:admin/util/editDateFormat.dart';
import 'package:admin/view/components/button/custom_elevated_button.dart';
import 'package:admin/view/components/menu_manage/menu_input_form.dart';
import 'package:admin/view/components/menu_manage/newMenuInputDialog.dart';
import 'package:admin/view/components/menu_manage/show_menu_list.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuInputContainer extends StatelessWidget {
  final DateTime date;
  final DietController dietCon = Get.find();
  final Map<String, List<String>> _menuForDays = {};

  MenuInputContainer({required this.date});
  @override
  Widget build(BuildContext context) {
    String year = getYear(date);
    String month = getMonth(date);
    String day = getDay(date);

    return Center(
      child: Column(
        children: [
          _menuAddButton(context),
          FutureBuilder(
            future: _EditMenuForDays(year, month, day),
            builder: (context, snapshot) {
              if (snapshot.hasData == false) {
                return CircularProgressIndicator(
                  color: Colors.grey,
                );
              }
              //error가 발생하게 될 경우 반환하게 되는 부분
              else if (snapshot.hasError) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Error: ${snapshot.error}',
                    style: TextStyle(fontSize: 15),
                  ),
                );
              } else
                return Wrap(
                  children: [
                    MenuInputForm(
                      time: "조식",
                      date: date,
                      menus: _menuForDays["조식"],
                      key: UniqueKey(),
                    ),
                    MenuInputForm(
                      time: "브런치",
                      date: date,
                      menus: _menuForDays["브런치"],
                      key: UniqueKey(),
                    ),
                    MenuInputForm(
                      time: "중식",
                      date: date,
                      menus: _menuForDays["중식"],
                      key: UniqueKey(),
                    ),
                    MenuInputForm(
                      time: "석식",
                      date: date,
                      menus: _menuForDays["석식"],
                      key: UniqueKey(),
                    ),
                  ],
                );
            },
          ),
        ],
      ),
    );
  }

  Future<Map<String, List<String>>> _EditMenuForDays(
      String year, month, day) async {
    await dietCon.findDay(year, month, day);
    Map<String, List<String>> result = {};
    for (Diet diet in dietCon.diets) {
      String a = diet.now!.substring(diet.now!.length - 2, diet.now!.length);
      List<String> menus =
          diet.menus!.map((e) => e["name"].toString()).toList();
      if (a == "조식")
        result["조식"] = menus;
      else if (a == "브런치")
        result["브런치"] = menus;
      else if (a == "중식")
        result["중식"] = menus;
      else
        result["석식"] = menus;
    }
    _menuForDays.addAll(result);
    return result;
  }

  Row _menuAddButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CustomElevatedButton(
          text: "메뉴 추가",
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => NewMenuInputDialog(),
            );
          },
        ),
      ],
    );
  }
}
