import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gf/src/modules/dashboard/services/chart_service.dart';
import 'package:gf/src/shared/colors/colors.dart';

class RevenueChart extends StatefulWidget {
  const RevenueChart({Key? key}) : super(key: key);

  @override
  _RevenueChartState createState() => _RevenueChartState();
}

class _RevenueChartState extends State<RevenueChart> {
  String _selectedPeriod = 'Mensal';
  List<FlSpot> _dataPoints = [];
  List<String> _titles = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    var data = await ChartService.getRevenueByPeriod(_selectedPeriod);
    setState(() {
      _dataPoints = data.entries
          .map((e) => FlSpot(_titles.length.toDouble(), e.value))
          .toList();
      _titles = data.keys.toList();
    });
  }

  @override
  void didUpdateWidget(covariant RevenueChart oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget != widget) {
      _fetchData();
    }
  }

  String _getBottomTitle(double value) {
    final index = value.toInt();
    if (index >= 0 && index < _titles.length) {
      return _titles[index];
    }
    return '';
  }

  String _getLeftTitle(double value) {
    return '\$${value.toInt()}';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.buttonColor,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Receita',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                Column(
                  children: [
                    DropdownButton<String>(
                      value: _selectedPeriod,
                      dropdownColor: AppColors.buttonColor,
                      style: const TextStyle(color: Colors.blueAccent),
                      items: const [
                        DropdownMenuItem(
                          value: 'Diário',
                          child: Text('Diário', style: TextStyle(color: Colors.white)),
                        ),
                        DropdownMenuItem(
                          value: 'Semanal',
                          child: Text('Semanal', style: TextStyle(color: Colors.white)),
                        ),
                        DropdownMenuItem(
                          value: 'Mensal',
                          child: Text('Mensal', style: TextStyle(color: Colors.white)),
                        ),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            _selectedPeriod = value;
                            _fetchData();
                          });
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 250,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(
                    leftTitles: SideTitles(
                      showTitles: true,
                      getTitles: (value) => _getLeftTitle(value),
                      interval: 200,
                      reservedSize: 40,
                    ),
                    bottomTitles: SideTitles(
                      showTitles: true,
                      getTitles: (value) => _getBottomTitle(value),
                      interval: 1,
                      reservedSize: 45,
                      rotateAngle: 0,
                    ),
                  ),
                  borderData: FlBorderData(show: true, border: Border.all(color: Colors.grey)),
                  lineBarsData: [
                    LineChartBarData(
                      spots: _dataPoints,
                      isCurved: true,
                      barWidth: 4,
                      colors: [AppColors.deleteIconColor],
                      belowBarData: BarAreaData(show: true, colors: [AppColors.deleteIconColor.withOpacity(0.9)]),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
