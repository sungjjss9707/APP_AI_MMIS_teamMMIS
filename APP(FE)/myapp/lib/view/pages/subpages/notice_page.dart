import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/controller/notice_controller.dart';
import 'package:myapp/date_functions.dart';
import 'package:myapp/view/components/appBar/sub_page_appbar.dart';
import 'package:myapp/view/components/custom_drawer.dart';
import 'package:myapp/view/components/textfield/custom_text_form_field_search.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NoticePage extends StatefulWidget {
  @override
  _NoticePageState createState() => _NoticePageState();
}

class _NoticePageState extends State<NoticePage> {
  final _formKey = GlobalKey<FormState>();
  final NoticeController n = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: subPageAppBar("공지사항"),
      body: Padding(
        padding: EdgeInsets.all(8.0.r),
        child: Obx(
          () => Column(
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
                    return ExpansionTile(
                      expandedCrossAxisAlignment: CrossAxisAlignment.start,
                      childrenPadding: EdgeInsets.all(8.0.r),
                      initiallyExpanded: false,
                      textColor: Colors.black,
                      title: Text(
                        "${n.notices[index].title}",
                      ),
                      // trailing: Text(notice.writer),
                      subtitle: Text(editDateFormat(n.notices[index].updated!)),
                      children: [
                        Text(n.notices[index].content ?? ""),
                      ],
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider(
                      color: Colors.grey,
                    );
                  },
                  itemCount: n.notices.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
