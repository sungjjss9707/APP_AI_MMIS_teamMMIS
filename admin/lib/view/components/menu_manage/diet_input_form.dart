import 'package:admin/controller/diet_controller.dart';
import 'package:admin/util/validators.dart';

import 'package:admin/view/components/button/custom_elevated_button.dart';
import 'package:admin/view/components/menu_manage/show_menu_list.dart';
import 'package:admin/view/components/textfield/menuInputTextField.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../size.dart';

class MenuInputForm extends StatefulWidget {
  final String year;
  final String month;
  final String day;
  final String time;
  List<String>? menus;
  MenuInputForm(
      {Key? key,
      required this.time,
      required this.menus,
      required this.year,
      required this.month,
      required this.day})
      : super(key: key);

  @override
  _MenuInputFormState createState() => _MenuInputFormState();
}

class _MenuInputFormState extends State<MenuInputForm> {
  final _formKey = GlobalKey<FormState>();
  final DietController dietCon = Get.find();
  late bool enableInput;
  List<TextEditingController> textEditingControllerList = [];
  List<MenuInputTextField> menuInputTextField = [];

  @override
  void initState() {
    menuInputTextField.add(MenuInputTextField(
      index: menuInputTextField.length,
      funValidate: validateMenu(),
    ));
    enableInput = false;
    super.initState();
  }

  @override
  void dispose() {
    for (MenuInputTextField i in menuInputTextField) {
      i.controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[400]!),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(gap_m),
      margin: const EdgeInsets.all(gap_m),
      width: 350,
      child: Form(
        key: _formKey,
        child: enableInput == true
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                      Text(
                        "${widget.time}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ] +
                    _menuInputTextFieldGenerate() +
                    [
                      _buttons(),
                    ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShowMenuList(
                    time: "${widget.time}",
                    menus: widget.menus,
                  ),
                  SizedBox(height: gap_s),
                  widget.menus != null
                      ? Row(
                          children: [
                            CustomElevatedButton(
                              text: "수정하기",
                              onPressed: () {
                                setState(() {
                                  enableInput = true;
                                });
                              },
                            ),
                            SizedBox(width: gap_s),
                            CustomElevatedButton(
                              text: "삭제",
                              onPressed: () {
                                //delete들어가야 됨.
                              },
                            )
                          ],
                        )
                      : Row(
                          children: [
                            CustomElevatedButton(
                              text: "입력하기",
                              onPressed: () {
                                setState(() {
                                  enableInput = true;
                                });
                              },
                            ),
                          ],
                        ),
                ],
              ),
      ),
    );
  }

  void menuInputTextFieldAdd() {
    setState(() {
      int index = menuInputTextField.length;
      menuInputTextField.add(MenuInputTextField(
        index: index,
        funValidate: validateMenu(),
      ));
    });
  }

  void menuInputTextFieldRemove(int index) {
    setState(() {
      menuInputTextField.removeAt(index);
      for (MenuInputTextField i in menuInputTextField) {
        i.index = menuInputTextField.indexOf(i);
      }
    });
  }

  List<Widget> _menuInputTextFieldGenerate() {
    return List.generate(
      menuInputTextField.length,
      (index) => Row(
        children: [
          Flexible(child: menuInputTextField[index]),
          SizedBox(height: gap_xs),
          index == menuInputTextField.length - 1
              ? IconButton(
                  onPressed: () {
                    menuInputTextFieldAdd();
                  },
                  icon: Icon(Icons.add),
                )
              : IconButton(
                  onPressed: () {
                    menuInputTextFieldRemove(index);
                  },
                  icon: Icon(Icons.delete),
                ),
          index > 0 && index == menuInputTextField.length - 1
              ? IconButton(
                  onPressed: () {
                    menuInputTextFieldRemove(index);
                  },
                  icon: Icon(Icons.delete),
                )
              : IconButton(onPressed: () {}, icon: Container()),
        ],
      ),
    );
  }

  Widget _buttons() {
    return Row(
      children: [
        CustomElevatedButton(
          text: "저장",
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              List<String> menuList = [];
              for (MenuInputTextField i in menuInputTextField) {
                if (i.controller.text.length != 0)
                  menuList.add(i.controller.text.trim());
              }
              try {
                if (widget.menus == null) {
                  await dietCon.saveDiet(widget.year, widget.month, widget.day,
                      widget.time, menuList);
                } else {
                  await dietCon.upDateDiet(widget.year, widget.month,
                      widget.day, widget.time, menuList);
                }

                if (widget.menus != null) {
                  widget.menus!.clear();
                  widget.menus!.addAll(menuList);
                } else
                  widget.menus = menuList;
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    content: Text("저장되었습니다."),
                  ),
                );
                setState(() {
                  enableInput = false;
                });
              } catch (e) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    content: Text("입력실패"),
                  ),
                );
              }
            }
          },
        ),
        SizedBox(width: gap_s),
        CustomElevatedButton(
          text: "취소",
          onPressed: () {
            setState(() {
              enableInput = false;
            });
          },
        ),
      ],
    );
  }
}
