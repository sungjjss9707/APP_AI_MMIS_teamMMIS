import 'package:flutter/material.dart';
import 'package:myapp/view/components/appBar/sub_page_appbar.dart';
import 'package:myapp/view/components/custom_drawer.dart';

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
  _MenuInputsState({required this.count});
  @override
  Widget build(BuildContext context) {
    List<TextEditingController> controllers =
        List.generate(count, (i) => TextEditingController());
    return Padding(
      padding: EdgeInsets.all(10),
      child: Form(
        child: ListView(
          children: [
            ...List.generate(
              count,
              (e) => TextFormField(
                controller: controllers[e],
                validator: null,
              ),
            ),
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
                      for (int i = 0; i < count; ++i) {
                        print(controllers[i].text);
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
