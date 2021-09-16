import 'package:flutter/material.dart';
import 'package:myapp/model/inform.dart';
import 'package:myapp/view/components/appBar/sub_page_appbar.dart';
import 'package:myapp/view/components/custom_drawer.dart';
import 'package:myapp/view/components/textfield/custom_text_form_field_search.dart';

class NoticePage extends StatefulWidget {
  @override
  _NoticePageState createState() => _NoticePageState();
}

class _NoticePageState extends State<NoticePage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: subPageAppBar("공지사항"),
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
                  Inform notice = dummyInform[index];
                  return ExpansionTile(
                    initiallyExpanded: false,
                    textColor: Colors.black,
                    title: Text(
                      "[${notice.type}] ${notice.title}",
                    ),
                    // trailing: Text(notice.writer),
                    subtitle: Text(notice.date),
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(notice.main),
                      ),
                    ],
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider(
                    color: Colors.grey,
                  );
                },
                itemCount: dummyInform.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Notice {}
