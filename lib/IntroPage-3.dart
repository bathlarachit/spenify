import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:spenify/constant.dart';

class IntroPage3 extends StatelessWidget {
  const IntroPage3({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset('assets/security.zip'),
          const Text(
            'Store Offline in your Phone Securily',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 50,
          ),
          GestureDetector(
            onTap: () {
              Navigator.popAndPushNamed(context, '/detail');
            },
            child: Container(
              height: 50,
              width: double.infinity,
              decoration: const BoxDecoration(
                  color: blueColor,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: const Center(child: Text('Start')),
            ),
          ),
        ],
      ),
    );
  }
}
