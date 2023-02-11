import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Graph extends StatefulWidget {
  const Graph({
    Key? key,
    required this.list,
  }) : super(key: key);
  final List<FlSpot> list;

  @override
  State<Graph> createState() => _GraphState();
}

class _GraphState extends State<Graph> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Text(""),
    );
  }
}
