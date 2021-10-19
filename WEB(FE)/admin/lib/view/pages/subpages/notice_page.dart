// 공지사항 관리 페이지

import 'package:admin/controller/notice_controller.dart';
import 'package:admin/util/editDateFormat.dart';
import 'package:admin/view/components/button/custom_elevated_button.dart';
import 'package:admin/view/components/dialog/notice_content_dialog.dart';
import 'package:admin/view/components/dialog/notice_write_dialog.dart';
import 'package:admin/view/components/home/customTitle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:number_pagination/number_pagination.dart';

import '../../../size.dart';
import '../../../style.dart';

class NoticePage extends StatefulWidget {
  @override
  _NoticePageState createState() => _NoticePageState();
}

class _NoticePageState extends State<NoticePage> {
  late int _currentPage;
  final NoticeController n = Get.put(NoticeController());

  @override
  void initState() {
    _currentPage = 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _width = getMediaQueryWidth(context);
    return Padding(
      padding: _width < 540
          ? const EdgeInsets.all(gap_m)
          : const EdgeInsets.all(gap_xl),
      child: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTitle("공지사항 관리"),
              Divider(color: Colors.grey),
              _width > 850 ? _contentHeader() : Container(),
              _noticeList(context, _width),
              _buildWriteButton(context),
              _numberPagination(),
            ],
          ),
        ],
      ),
    );
  }

  Row _contentHeader() {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Center(
            child: Text(
              "번호",
              style: subtitle1(),
            ),
          ),
        ),
        Expanded(
          flex: 8,
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
          child: Center(
            child: Text(
              "작성날짜",
              style: subtitle1(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _noticeList(BuildContext context, double mediaWidth) {
    return Obx(
      () => Column(
        children: List.generate(15, (int index) {
          String title;
          String writer;
          String date;
          String content;
          int id;
          index += 15 * (_currentPage - 1);
          try {
            title = n.notices[index].title!;
            writer = "관리자";
            date = editDateFormat(n.notices[index].updated!);
            content = n.notices[index].content!;
            id = n.notices[index].id!;
          } catch (e) {
            title = "";
            writer = "";
            date = "";
            content = "";
            id = -1;
          }
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: id != -1
                ? InkWell(
                    onTap: () async {
                      _showContentDialog(context, title, content, id);
                    },
                    child: mediaWidth > 850
                        ? _contentForWide(index, title, writer, date)
                        : _contentForNarrow(index, title, writer, date),
                  )
                : InkWell(
                    child: _contentForWide(index, title, writer, date),
                  ),
          );
        }),
      ),
    );
  }

  Widget _buildWriteButton(BuildContext context) {
    return Row(
      children: [
        Spacer(),
        CustomElevatedButton(
          text: "글쓰기",
          onPressed: () {
            _showWriteDialog(context);
          },
        ),
      ],
    );
  }

  Widget _numberPagination() {
    print("pagenation");
    return NumberPagination(
      listner: (int selectedPage) {
        setState(() {
          _currentPage = selectedPage;
        });
      },
      totalPage: n.notices.length % 15 == 0
          ? n.notices.length ~/ 15
          : n.notices.length ~/ 15 + 1,
      currentPage: _currentPage,
    );
  }

  Widget _contentForWide(int index, String title, String writer, String date) {
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
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 8,
          child: Container(
            height: 30,
            child: Center(
              child: Text(
                "$title",
                style: body1(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
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
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
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
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _contentForNarrow(
      int index, String title, String writer, String date) {
    return ListTile(
      title: Text(
        "${index + 1} $title",
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        date,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Text(
        writer,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Future<dynamic> _showContentDialog(
      BuildContext context, String title, String content, int id) {
    return showDialog(
      context: context,
      builder: (context) {
        return NoticeContentDialog(
          title: title,
          content: content,
          id: id,
        );
      },
    );
  }

  Future<dynamic> _showWriteDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return NoticeWriteDialog();
      },
    );
  }
}
