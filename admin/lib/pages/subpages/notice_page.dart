// 공지사항 관리 페이지
import 'package:admin/components/button/custom_elevated_button.dart';
import 'package:admin/components/textfield/custom_text_form_field.dart';
import 'package:admin/components/textfield/custom_writing_area.dart';
import 'package:admin/model/notice.dart';
import 'package:admin/page_util/validators.dart';
import 'package:flutter/material.dart';
import 'package:number_pagination/number_pagination.dart';

import '../../size.dart';
import '../../style.dart';

class NoticePage extends StatefulWidget {
  @override
  _NoticePageState createState() => _NoticePageState();
}

class _NoticePageState extends State<NoticePage> {
  late int _currentPage;
  List<Map> _dummyNotice = dummyNotice;

  @override
  void initState() {
    _currentPage = 1;
    super.initState();
  }

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
          Row(
            children: [
              Spacer(),
              CustomElevatedButton(
                text: "글쓰기",
                onPressed: () {
                  _showContentDialog(context, "", "");
                },
              ),
            ],
          ),
          _numberPagination(),
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
    return _contentHeader();
  }

  Row _contentHeader() {
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
          flex: 2,
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
    String title;
    String writer;
    String date;
    String content;
    return Column(
      children: List.generate(15, (int index) {
        index += 15 * (_currentPage - 1);
        try {
          Map notice = _dummyNotice[index];
          title = notice["제목"];
          writer = notice["작성자"];
          date = notice["작성날짜"];
          content = notice["내용"];
        } catch (e) {
          title = "";
          writer = "";
          date = "";
          content = "";
        }
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: title != ""
              ? InkWell(
                  onTap: () {
                    _showContentDialog(context, title, content);
                  },
                  child: _content(index, title, writer, date),
                )
              : InkWell(
                  child: _content(index, title, writer, date),
                ),
        );
      }),
    );
  }

  Widget _numberPagination() {
    return NumberPagination(
      listner: (int selectedPage) {
        setState(() {
          _currentPage = selectedPage;
        });
      },
      totalPage: _dummyNotice.length % 15 == 0
          ? _dummyNotice.length ~/ 15
          : _dummyNotice.length ~/ 15 + 1,
      currentPage: _currentPage,
    );
  }

  Row _content(int index, String title, String writer, String date) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Container(
            height: 30,
            child: Center(
              child: Text(
                title == "" ? "" : "${index + 1}",
                style: body1(),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 10,
          child: Container(
            height: 30,
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
            height: 30,
            child: Center(
              child: Text(
                "$writer",
                style: body1(),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            height: 30,
            child: Center(
              child: Text(
                "$date",
                style: body1(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<dynamic> _showContentDialog(
      BuildContext context, String title, String content) {
    TextEditingController titleController = TextEditingController();
    TextEditingController contentController = TextEditingController();
    titleController.text = title;
    contentController.text = content;
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          contentPadding: EdgeInsets.all(32),
          children: [
            Container(
              width: 500,
              height: 500,
              child: Column(
                children: [
                  CustomTextFormField(
                    controller: titleController,
                    hint: "제목",
                    funValidate: validateTitle(),
                  ),
                  CustomWritingArea(
                    controller: contentController,
                    hint: "내용",
                    funValidate: validateContent(),
                  ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomElevatedButton(
                        text: "수정",
                        onPressed: () {
                          if (titleController.text != title ||
                              contentController.text != content) {
                            setState(() {
                              // 여기서 글을 수정된 내용을 서버로 통신.
                              title = titleController.text;
                              content = contentController.text;
                            });
                          }
                        },
                      ),
                      SizedBox(width: gap_s),
                      CustomElevatedButton(
                        text: "삭제",
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      SizedBox(width: gap_s),
                      CustomElevatedButton(
                        text: "닫기",
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
