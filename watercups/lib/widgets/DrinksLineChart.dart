import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class DrinksLineChart extends StatefulWidget {
  final Map<String, dynamic> userData;

  final List<FlSpot> userDataFlSpots = [];

  DrinksLineChart({super.key, required this.userData});

  @override
  State<DrinksLineChart> createState() => _DrinksLineChartState();
}

class _DrinksLineChartState extends State<DrinksLineChart> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.userData.isNotEmpty) {
      double cnt = 0;
      for (var element in widget.userData.entries) {
        widget.userDataFlSpots.add(FlSpot(cnt, element.value.toDouble()));
        cnt += 1;
      }
    }
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.70,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: LineChart(
              mainData(),
            ),
          ),
        ),
      ],
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: widget.userData.isNotEmpty
          ? Text(
              widget.userData.keys.toList()[value.toInt()],
              style: style,
            )
          : const Text(""),
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );
    return Text(value.toInt().toString(),
        style: style, textAlign: TextAlign.left);
  }

  LineChartData mainData() {
    return LineChartData(
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
            getTitlesWidget: (value, meta) => const Text("hello"),
          ),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 500,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      lineBarsData: [
        LineChartBarData(
          spots: widget.userDataFlSpots,
          isCurved: false,
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
        ),
      ],
    );
  }
}
