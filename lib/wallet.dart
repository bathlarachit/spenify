import 'package:flutter/material.dart';
import 'package:spenify/constant.dart';
import 'package:spenify/graph.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class Expenses extends StatelessWidget {
  const Expenses({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: pinkColor,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.2,
          backgroundColor: pinkColor,
          title: const Text(
            "Wallet",
            style: TextStyle(color: Colors.black),
          ),
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.arrow_back_ios),
            color: Colors.black,
          ),
        ),
        body: Column(
          children: [
            Row(
              children: const [
                Padding(
                  padding: EdgeInsets.only(left: 28.0, top: 20),
                  child: Text(
                    "Month",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            const MonthlyExpense(),
            Padding(
              padding: const EdgeInsets.only(left: 18.0, right: 18),
              child: Container(
                height: 80,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      const SizedBox(height: 40, child: Text("")),
                      Column(),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
