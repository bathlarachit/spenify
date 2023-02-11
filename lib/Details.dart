import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:spenify/constant.dart';

class Details extends StatefulWidget {
  const Details({super.key});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  String name = "Alex";
  late Box hive;
  @override
  void initState() {
    hive = Hive.box('myBox');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: Form(
            child: Padding(
          padding: const EdgeInsets.only(left: 18.0, right: 18, top: 20),
          child: Column(
            children: [
              const SizedBox(
                height: 80,
              ),
              const Image(
                image: AssetImage('assets/signIn.png'),
                height: 200,
                width: double.infinity,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Let's start by with your name",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 50,
              ),
              TextFormField(
                onChanged: ((value) {
                  name = value;
                }),
                decoration: const InputDecoration(
                    hintText: "Enter Your Name", label: Text('Name')),
              ),
              const SizedBox(
                height: 50,
              ),
              InkWell(
                  onTap: () {
                    if (name == "") name = 'Alex';

                    hive.put('name', name);
                    Navigator.popAndPushNamed(context, '/home');
                  },
                  child: Ink(
                    height: 50,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: blueColor,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: const Center(child: Text('Start')),
                  ))
            ],
          ),
        )),
      ),
    );
  }
}
