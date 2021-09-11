import 'package:flutter/material.dart';
import 'package:myapp/components/custom_text_form_field_search.dart';
import 'package:myapp/model/notice.dart';



class NoticePage extends StatefulWidget {
  @override
  _NoticePageState createState() => _NoticePageState();
}

class _NoticePageState extends State<NoticePage> {
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
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: const CustomTextFormFieldSearch(
                hint: "제목으로 검색해 보세요.",
              ),
            ),
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  Inform notice = dummyNotice[index];
                  return ListTile(
                    onTap: () {},
                    title: Text(
                      "[${notice.type}] ${notice.title}",
                    ),
                    trailing: Text(notice.writer),
                    subtitle: Text(notice.date),
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider(
                    color: Colors.grey,
                  );
                },
                itemCount: dummyNotice.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Notice {
}
