import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/allergy.dart';
import 'package:myapp/view/components/appBar/sub_page_appbar.dart';
import 'package:myapp/view/components/custom_drawer.dart';

class AllergyInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: subPageAppBar("알레르기 정보"),
      body: ListView(
        children: [
          ...allergyName.map((allergy) => AllergyInfo(allergy: allergy))
        ],
      ),
    );
  }
}

class AllergyInfo extends StatelessWidget {
  final String allergy;
  AllergyInfo({required this.allergy});
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      initiallyExpanded: false,
      textColor: Colors.black,
      title: Text("$allergy 알레르기",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.black54,
          )),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Wrap(
            children: [
              Text(allergyInfo[allergy]!),
            ],
          ),
        ),
      ],
    );
  }
}
