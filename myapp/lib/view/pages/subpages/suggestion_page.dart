import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:myapp/model/suggestion.dart';
import 'package:myapp/view/components/custom_text_form_field_search.dart';
import 'package:myapp/view/pages/subpages/write_suggestion_page.dart';

class SuggestionPage extends StatefulWidget {
  @override
  _SuggestionPageState createState() => _SuggestionPageState();
}

class _SuggestionPageState extends State<SuggestionPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _filter = TextEditingController();
  FocusNode focusNode = FocusNode();
  String _searchText = "";

  _NoticePageState() {
    _filter.addListener(() {
      setState(() {
        _searchText = _filter.text;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("건의사항"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextButton(
                    onPressed: () {
                      Get.to(() => WriteSuggestionPage());
                    },
                    child: Row(
                      children: [
                        FaIcon(
                          FontAwesomeIcons.pen,
                          size: 14,
                        ),
                        SizedBox(width: 4),
                        Text("건의하기"),
                      ],
                    ),
                  ),
                  CustomTextFormFieldSearch(
                    hint: "제목으로 검색해 보세요.",
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  Suggestion suggestion = dummySuggestion[index];
                  return ListTile(
                    onTap: () {},
                    title: Text(
                      "${suggestion.title}",
                    ),
                    trailing: Text(suggestion.writer),
                    subtitle: Text(suggestion.date),
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider(
                    color: Colors.grey,
                  );
                },
                itemCount: dummySuggestion.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
