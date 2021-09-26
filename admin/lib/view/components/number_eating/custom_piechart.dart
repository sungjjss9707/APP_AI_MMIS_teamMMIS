import 'package:admin/model/numberOfEating.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CustomPieChart extends StatelessWidget {
  final DateTime date;
  final TooltipBehavior _tooltipBehavior1 =
      TooltipBehavior(enable: true, duration: 0.5);
  final TooltipBehavior _tooltipBehavior2 =
      TooltipBehavior(enable: true, duration: 0.5);
  CustomPieChart({required this.date});

  @override
  Widget build(BuildContext context) {
    final notEatingInfo = getNotEatingInfo(date);
    final List<NotEatingData> _notEatingData = getNotEatingData(notEatingInfo);
    final List<ReasonNotEatingData> _reasonNotEatingData =
        getReaSonNotEatingData(notEatingInfo);
    return Center(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [_chart1(_notEatingData), _chart2(_reasonNotEatingData)],
          ),
        ),
      ),
    );
  }

  Container _chart1(List<NotEatingData> _notEatingData) {
    return Container(
      width: 350,
      height: 300,
      child: SfCircularChart(
        title: ChartTitle(text: "식수 인원(명)"),
        legend:
            Legend(isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
        tooltipBehavior: _tooltipBehavior1,
        series: [
          PieSeries<NotEatingData, String>(
            dataSource: _notEatingData,
            xValueMapper: (NotEatingData data, _) => data.isEating,
            yValueMapper: (NotEatingData data, _) => data.numOfPeople,
            dataLabelSettings: DataLabelSettings(
              isVisible: true,
            ),
            enableTooltip: true,
          ),
        ],
      ),
    );
  }

  Container _chart2(List<ReasonNotEatingData> _reasonNotEatingData) {
    return Container(
      width: 350,
      height: 300,
      child: SfCircularChart(
        title: ChartTitle(text: "불취식 사유(명)"),
        legend:
            Legend(isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
        tooltipBehavior: _tooltipBehavior2,
        series: [
          PieSeries<ReasonNotEatingData, String>(
            dataSource: _reasonNotEatingData,
            xValueMapper: (ReasonNotEatingData data, _) => data.reason,
            yValueMapper: (ReasonNotEatingData data, _) => data.numOfPeople,
            dataLabelSettings: DataLabelSettings(
              isVisible: true,
            ),
            enableTooltip: true,
          ),
        ],
      ),
    );
  }
}
