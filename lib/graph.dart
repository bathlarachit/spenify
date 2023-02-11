import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:spenify/utils.dart';

class MonthlyExpense extends StatefulWidget {
  const MonthlyExpense({super.key});

  @override
  State<MonthlyExpense> createState() => _MonthlyExpenseState();
}

class _MonthlyExpenseState extends State<MonthlyExpense> {
  late List<FlSpot> list;
  late Box hive;
  @override
  void initState() {
    hive = Hive.box('myBox');
    list = drawMonthGraph(1, 2023);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: SizedBox(
          height: 350,
          width: double.infinity,
          child: (list.isNotEmpty)
              ? LineChart(
                  LineChartData(
                    gridData: FlGridData(show: false),
                    titlesData: FlTitlesData(
                      leftTitles:
                          AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      rightTitles:
                          AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      bottomTitles:
                          AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      topTitles:
                          AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    ),
                    borderData: FlBorderData(show: false),
                    backgroundColor: const Color.fromRGBO(255, 204, 228, 1),
                    minX: 1,
                    minY: 0,
                    lineBarsData: [
                      LineChartBarData(
                        barWidth: 4,
                        color: Colors.white,
                        isCurved: true,
                        spots: list,
                      )
                    ],
                  ),
                )
              : const Center(
                  child: Text('No Transaction this month'),
                ),
        ),
      ),
    );
  }
}
