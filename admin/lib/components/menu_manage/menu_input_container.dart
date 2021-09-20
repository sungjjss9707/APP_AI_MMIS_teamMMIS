import 'package:admin/components/menu_manage/menu_input_form.dart';
import 'package:admin/model/menu.dart';

import 'package:flutter/material.dart';

class MenuInputContainer extends StatelessWidget {
  final DateTime day;

  MenuInputContainer({required this.day});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        children: [
          MenuInputForm(time: "조식"),
          MenuInputForm(time: "브런치"),
          MenuInputForm(time: "중식"),
          MenuInputForm(time: "석식"),
        ],
      ),
    );
  }

  List<String> inputTime() {
    return getMenuData(day).keys.toList();
  }
}

//
// class MenuInputContainer extends StatefulWidget {
//   final DateTime day;
//   final List<String>? inputTime=[] ;
//   MenuInputContainer({required this.day});
//   @override
//   _MenuInputContainerState createState() => _MenuInputContainerState(day,inputTime);
// }
//
// class _MenuInputContainerState extends State<MenuInputContainer> {
//   final DateTime day;
//   final List<String>? inputTime;
//
//   _MenuInputContainerState(this.day, this.inputTime);
//
//   ini
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Wrap(
//         children: [
//           MenuInputForm(time: "조식"),
//           MenuInputForm(time: "브런치"),
//           MenuInputForm(time: "중식"),
//           MenuInputForm(time: "석식"),
//         ],
//       ),
//     );
//   }
// }
