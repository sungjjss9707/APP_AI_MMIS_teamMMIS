import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:myapp/controller/suggestion_controller.dart';
import 'package:myapp/model/suggestion.dart';
import 'package:myapp/view/components/appBar/sub_page_appbar.dart';
import 'package:myapp/view/components/custom_drawer.dart';

import 'package:myapp/view/pages/subpages/write_suggestion_page.dart';

import '../../../date_functions.dart';

class SuggestionPage extends StatefulWidget {
  @override
  _SuggestionPageState createState() => _SuggestionPageState();
}

class _SuggestionPageState extends State<SuggestionPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _filter = TextEditingController();
  final s = Get.put(SuggestionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: subPageAppBar("건의사항"),
      body: Padding(
        padding: EdgeInsets.all(16.0.r),
        child: Obx(
          () => Column(
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
                            size: 14.r,
                          ),
                          SizedBox(width: 4.w),
                          Text("건의하기"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    Suggestion suggestion = dummySuggestion[index];
                    return ExpansionTile(
                      childrenPadding: EdgeInsets.all(8.0.r),
                      initiallyExpanded: false,
                      textColor: Colors.black,
                      title: Text(
                        "${s.suggestions[index].title}",
                      ),
                      subtitle:
                          Text(editDateFormat(s.suggestions[index].updated!)),
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            children: [
                              Text("${s.suggestions[index].content}"),
                              Row(
                                children: [
                                  Spacer(),
                                  Text(
                                      "작성자 : ${s.suggestions[index].writer!["name"]}")
                                ],
                              ),
                              const Divider(
                                color: Colors.grey,
                              ),
                              ...List.generate(
                                s.suggestions[index].comments!.length,
                                (i) => Column(
                                  children: [
                                    Text(
                                        "${s.suggestions[index].comments![i].content}"),
                                    Row(
                                      children: [
                                        Spacer(),
                                        const Text("관리자"),
                                      ],
                                    ),
                                    i !=
                                            s.suggestions[index].comments!
                                                    .length -
                                                1
                                        ? SizedBox(
                                            height: 8.h,
                                          )
                                        : SizedBox(),
                                  ],
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                ),
                              ),
                            ],
                            crossAxisAlignment: CrossAxisAlignment.start,
                          ),
                        ),
                      ],
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider();
                  },
                  itemCount: s.suggestions.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
