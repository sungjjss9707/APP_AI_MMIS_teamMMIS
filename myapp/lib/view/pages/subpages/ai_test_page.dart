import 'package:flutter/material.dart';
import 'package:myapp/page_util/validators.dart';
import 'package:myapp/view/components/appBar/sub_page_appbar.dart';
import 'package:myapp/view/components/custom_drawer.dart';
import 'package:myapp/view/components/textfield/custom_text_form_field.dart';

class AiTestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: subPageAppBar("AI 실험실"),
      body: MenuInputs(count: 3),
    );
  }
}

class MenuInputs extends StatefulWidget {
  int count;
  MenuInputs({required this.count});
  @override
  _MenuInputsState createState() => _MenuInputsState(count: count);
}

class _MenuInputsState extends State<MenuInputs> {
  int count;
  final _formKey = GlobalKey<FormState>();
  _MenuInputsState({required this.count});
  @override
  Widget build(BuildContext context) {
    List<TextEditingController> controllers =
        List.generate(count, (i) => TextEditingController());
    return Padding(
      padding: EdgeInsets.all(10),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            ...List.generate(
                count,
                (e) => CustomTextFormField(
                    hint: "메뉴 입력",
                    funValidate: validateName(),
                    controller: controllers[e])),
            Row(
              children: [
                TextButton(
                    child: Text("메뉴 추가"),
                    onPressed: () {
                      setState(() {
                        count++;
                      });
                    }),
                TextButton(
                    child: Text("제출"),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        for (int i = 0; i < count; ++i) {
                          print(controllers[i].text);
                        }
                        showDialog(
                          context: context,
                          builder: (context) => SimpleDialog(
                            title: Center(child: Text("결과")),
                            contentPadding: const EdgeInsets.all(16),
                            children: [
                              Center(child: Text("예상점수")),
                            ],
                          ),
                        );
                      }
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
