import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gf/src/modules/dashboard/components/bar_data.dart';

class MyBarGraph extends StatefulWidget {
  final List<double> weeklySummary;

  const MyBarGraph({Key? key, required this.weeklySummary}) : super(key: key);

  @override
  State<MyBarGraph> createState() => _MyBarGraphState();
}

class _MyBarGraphState extends State<MyBarGraph> {
  @override
  Widget build(BuildContext context) {
    BarData myBarData = BarData(
      sunday: widget.weeklySummary[0],
      monday: widget.weeklySummary[1],
      tuesday: widget.weeklySummary[2],
      wednesday: widget.weeklySummary[3],
      thursday: widget.weeklySummary[4],
      friday: widget.weeklySummary[5],
      saturday: widget.weeklySummary[6],
    );

    myBarData.initializeBarData(); // Inicializar os dados de barras

    return Center(
      child: SizedBox(
        height: 200,
        width: 500,
        child: BarChart(
          BarChartData(
            maxY: 300, // Ajuste o valor conforme necessário
            minY: 0,
            barGroups: myBarData.barData
                .map(
                  (data) => BarChartGroupData(
                x: data.x,
                barRods: [BarChartRodData(s
                  toY: data.y,
                  color: Colors.red,
                )],
              ),
            )
                .toList(),
            borderData: FlBorderData(show: false),
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: true, getTitlesWidget: (value, meta) {
                  return Text('${value.toInt()}');
                }),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    switch (value.toInt()) {
                      case 0:
                        return Text('Sun');
                      case 1:
                        return Text('Mon');
                      case 2:
                        return Text('Tue');
                      case 3:
                        return Text('Wed');
                      case 4:
                        return Text('Thu');
                      case 5:
                        return Text('Fri');
                      case 6:
                        return Text('Sat');
                      default:
                        return Text('');
                    }
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
