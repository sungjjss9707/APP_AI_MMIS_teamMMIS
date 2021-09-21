import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PieChart extends StatefulWidget {
  const PieChart({Key? key}) : super(key: key);

  @override
  _PieChartState createState() => _PieChartState();
}

class _PieChartState extends State<PieChart> {
  late List<PieData> _chartData;
  @override
  void initState() {
    _chartData = getChartData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            children: [
              SfCircularChart(
                title: ChartTitle(text: "식수 인원"),
                series: [
                  PieSeries<PieData, int>(
                    dataSource: _chartData,
                    xValueMapper: (PieData data, _) => data.numOfPeople,
                    yValueMapper: (PieData data, _) => data.numOfPeople,
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

List<PieData> getChartData() {
  final List<PieData> chartData = [
    PieData("취식", 30),
    PieData("불취식", 10),
  ];
  return chartData;
}

class PieData {
  PieData(this.isEating, this.numOfPeople);
  final String isEating;
  final int numOfPeople;
}
