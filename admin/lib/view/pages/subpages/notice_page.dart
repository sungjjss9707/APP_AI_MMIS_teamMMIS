// 공지사항 관리 페이지

import 'package:admin/model/notice.dart';
import 'package:admin/view/components/button/custom_elevated_button.dart';
import 'package:admin/view/components/dialog/notice_content_dialog.dart';
import 'package:admin/view/components/home/customTitle.dart';
import 'package:flutter/material.dart';
import 'package:number_pagination/number_pagination.dart';

import '../../../size.dart';
import '../../../style.dart';

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
          CustomTitle("공지사항 관리"),
          Divider(color: Colors.grey),
          _contentHeader(),
          _noticeList(context),
          _buildWriteButton(context),
          _numberPagination(),
        ],
      ),
    );
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

  Widget _buildWriteButton(BuildContext context) {
    return Row(
      children: [
        Spacer(),
        CustomElevatedButton(
          text: "글쓰기",
          onPressed: () {
            _showContentDialog(context, "", "");
          },
        ),
      ],
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
    return showDialog(
      context: context,
      builder: (context) {
        return NoticeContentDialog(
          title: title,
          content: content,
        );
      },
    );
  }
}
