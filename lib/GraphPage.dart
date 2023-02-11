import 'package:flutter/material.dart';
import 'package:spenify/utils.dart';

import 'graph.dart';

class GraphPage extends StatefulWidget {
  const GraphPage({super.key});

  @override
  State<GraphPage> createState() => _GraphPageState();
}

class _GraphPageState extends State<GraphPage> {
  String val = months[DateTime.now().month - 1];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: Column(
          children: [
            DropdownButton(
              value: val,
              items: months.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              onChanged: ((value) {
                setState(() {
                  val = value!;
                });
              }),
            ),
            const SizedBox(height: 400, child: MonthlyExpense()),
            const Text("Balance"),
          ],
        ),
      ),
    );
  }
}
