import 'package:admin/model/survey.dart';
import 'package:admin/size.dart';
import 'package:admin/view/components/home/customTitle.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../style.dart';
import '../frame_page.dart';
import '../login_page.dart';

class SurveyResultPage extends StatelessWidget {
  final String title;
  final String writer;
  final String date;
  final List questionSets;

  SurveyResultPage(
      {required this.title,
      required this.writer,
      required this.date,
      required this.questionSets});
  @override
  Widget build(BuildContext context) {
    double _width = getMediaQueryWidth(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: InkWell(
          onTap: () {
            Get.offAll(() => FramePage());
          },
          child: Text(
            "MMIS",
            style: h4(),
          ),
        ),
        actions: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  Get.offAll(() => LoginPage());
                },
                child: Text("로그아웃", style: h5()),
              ),
            ],
          ),
          SizedBox(width: gap_s),
        ],
      ),
      body: ListView(
        children: [
          Container(
            width: _width,
            padding: _width < 540
                ? const EdgeInsets.all(gap_m)
                : const EdgeInsets.all(gap_xl),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomTitle("[설문] $title 설문 결과"),
                Divider(color: Colors.grey),
                _showResult(context),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _showResult(BuildContext context) {
    Map questionSet;
    String question;
    List choice;
    List answerCount;
    List<List> data;
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: List.generate(
        questionSets.length,
        (index) {
          questionSet = questionSets[index];
          question = questionSet["질문"];
          choice = questionSet["선지"];
          answerCount = questionSet["결과"];
          data = zip(choice, answerCount);
          return Padding(
            padding: const EdgeInsets.all(gap_xl),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(10),
              ),
              width: MediaQuery.of(context).size.width * 0.4,
              child: SfCircularChart(
                tooltipBehavior: TooltipBehavior(enable: true, duration: 0.5),
                title: ChartTitle(text: question),
                legend: Legend(
                    isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
                series: [
                  PieSeries<List, String>(
                    dataSource: data,
                    xValueMapper: (datum, _) => datum[0],
                    yValueMapper: (datum, _) => datum[1],
                    dataLabelSettings: DataLabelSettings(
                      isVisible: true,
                    ),
                    enableTooltip: true,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
