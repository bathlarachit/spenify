import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:spenify/Details.dart';
import 'package:spenify/GraphPage.dart';
import 'package:spenify/Home.dart';
import 'package:spenify/SplashScreen.dart';
import 'package:spenify/monthList.dart';
import 'NewTransaction.dart';

void main() async {
  await Hive.initFlutter();
  var box = await Hive.openBox("mybox");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: const Color.fromRGBO(255, 204, 228, 1),
      debugShowCheckedModeBanner: false,
      routes: {
        "/": (context) => const OnBoardScreen(),
        '/home': (context) => const Home(),
        '/trans': (context) => const NewTransaction(),
        '/graph': (context) => const GraphPage(),
        '/list': (context) => const TransList(),
        '/detail': (context) => const Details()
      },
    );
  }
}
