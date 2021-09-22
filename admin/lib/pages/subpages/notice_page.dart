// 공지사항 관리 페이지
import 'package:admin/components/textfield/custom_text_form_field.dart';
import 'package:admin/components/textfield/custom_writing_area.dart';
import 'package:admin/model/notice.dart';
import 'package:admin/page_util/validators.dart';
import 'package:flutter/material.dart';

import '../../size.dart';
import '../../style.dart';

class NoticePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double _width = getBodyWidth(context);
    return Container(
      width: _width,
      padding: EdgeInsets.all(gap_xl),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _pageTitle(),
          Divider(color: Colors.grey),
          _header(),
          _noticeList(context),
        ],
      ),
    );
  }

  Widget _pageTitle() {
    return Text(
      "공지사항 관리",
      style: h4(),
    );
  }

  Widget _header() {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Container(
            child: Center(
              child: Text(
                "번호",
                style: subtitle1(),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 10,
          child: Container(
            child: Center(
              child: Text(
                "제목",
                style: subtitle1(),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Container(
            child: Center(
              child: Text(
                "작성자",
                style: subtitle1(),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Container(
            child: Center(
              child: Text(
                "작성날짜",
                style: subtitle1(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _noticeList(BuildContext context) {
    List<Map> _dummyNotice = dummyNotice;
    return Column(
      children: List.generate(_dummyNotice.length, (index) {
        Map notice = _dummyNotice[index];
        String title = notice["제목"];
        String writer = notice["작성자"];
        String date = notice["작성날짜"];
        String content = notice["내용"];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: InkWell(
            onTap: () {
              _showContent(context, title, content);
            },
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    child: Center(
                      child: Text(
                        "${index + 1}",
                        style: body1(),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 10,
                  child: Container(
                    child: Center(
                      child: Text(
                        "$title",
                        style: body1(),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    child: Center(
                      child: Text(
                        "$writer",
                        style: body1(),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    child: Center(
                      child: Text(
                        "$date",
                        style: body1(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Future<dynamic> _showContent(
      BuildContext context, String title, String content) {
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          contentPadding: EdgeInsets.all(10),
          children: [
            Container(
              width: 500,
              height: 500,
              child: Column(
                children: [
                  CustomTextFormField(
                    value: title,
                  ),
                  CustomWritingArea(
                    value: content,
                    funValidate: validateContent(),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
