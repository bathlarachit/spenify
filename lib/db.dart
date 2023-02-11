import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class MyDb extends StatelessWidget {
  MyDb({super.key});
  final _myBox = Hive.box("mybox");
  void write() {
    _myBox.put(1, "Rachit");
  }

  void delete() {}

  void read() {
    print(_myBox.get(1));
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            onPressed: () => write(),
            child: const Text("Write"),
          ),
          ElevatedButton(
            onPressed: () => read(),
            child: const Text("Read"),
          ),
          ElevatedButton(
            onPressed: () {},
            child: const Text("Deleted"),
          )
        ],
      ),
    );
  }
}
