import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:spenify/utils.dart';

class TransList extends StatefulWidget {
  const TransList({super.key});

  @override
  State<TransList> createState() => _TransListState();
}

class _TransListState extends State<TransList> {
  final Box hive = Hive.box('mybox');
  var list;
  @override
  void initState() {
    if (hive.containsKey('1/2023-trans')) {
      list = hive.get('1/2023-trans');
    } else {
      list = 0;
    }
    // print(drawMonthGraph(1, 2023));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: (list != 0)
            ? ListView.builder(
                itemBuilder: ((context, index) => Card(
                      child: Card(
                        elevation: 0.5,
                        child: ListTile(
                          trailing: Text(
                            "Rs ${list[index]['amount']}",
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                          title: Text(
                            list[index]['des'],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                          subtitle: Text(
                              '${list[index]['date'].day} ${months[list[index]['date'].month - 1]} ${list[index]['date'].year}'),
                        ),
                      ),
                    )),
                itemCount: list.length,
              )
            : const Text("No Transaction"));
  }
}
