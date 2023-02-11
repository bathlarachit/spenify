import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:spenify/constant.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class NewTransaction extends StatefulWidget {
  const NewTransaction({super.key});

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction>
    with SingleTickerProviderStateMixin {
  String des = "";
  String amount = "";
  String dateInString =
      "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}";
  final _formKey = GlobalKey<FormState>();
  late DateTime dt;
  late final txt = TextEditingController(text: dateInString);
  late final AnimationController _controller;
  var lastTrans1 = 0;
  var lastTrans2 = 0;
  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    hive = Hive.box('mybox');
    if (hive.containsKey('lt-1')) {
      lastTrans1 = hive.get('lt-1');
    }
    if (hive.containsKey('lt-2')) {
      lastTrans2 = hive.get('lt-2');
    }

    //lastTrans1
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  bool isClicked = false;
  DateTime date = DateTime.now();
  late Box hive;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: Padding(
          padding: const EdgeInsets.only(left: 18.0, right: 18),
          child: (isClicked == false)
              ? Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter Description";
                          }
                          return null;
                        },
                        decoration:
                            const InputDecoration(hintText: "Description"),
                        onChanged: ((value) => des = value),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Amount";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(hintText: "Amount"),
                        onChanged: ((value) => amount = value),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(labelText: "Date"),
                        readOnly: true,
                        controller: txt,
                        onTap: (() async {
                          DateTime? newDate = (await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(DateTime.now().year,
                                  DateTime.now().month, DateTime.now().day)));
                          newDate ??= DateTime.now();
                          date = newDate;

                          setState(() {
                            txt.text = "${date.day}/${date.month}/${date.year}";
                          });
                        }),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Amount";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 50),
                      InkWell(
                        onTap: (() {
                          if (_formKey.currentState!.validate()) {
                            //Transaction trans = new Transaction(date, double.parse(amount), des)
                            setState(() {
                              isClicked = true;
                              _controller.forward();
                              int id = 1;

                              if (hive.containsKey(
                                  '${date.month}/${date.year}-id')) {
                                id = hive.get('${date.month}/${date.year}-id') +
                                    1;
                              } else {
                                hive.put('${date.month}/${date.year}-id', 1);
                              }
                              List trans = [];

                              if (hive.containsKey(
                                  '${date.month}/${date.year}-trans')) {
                                trans = hive
                                    .get('${date.month}/${date.year}-trans');
                              }
                              trans.add({
                                'id': id,
                                'des': des,
                                'date': date,
                                'amount': amount
                              });
                              if (lastTrans1 == 0) {
                                hive.put('lT-1', {
                                  'id': id,
                                  'des': des,
                                  'date': date,
                                  'amount': amount
                                });
                              } else {
                                hive.put('lT-1', {
                                  'id': id,
                                  'des': des,
                                  'date': date,
                                  'amount': amount
                                });
                                hive.put('lT-2', lastTrans1);
                              }

                              hive.put(
                                  '${date.month}/${date.year}-trans', trans);
                              int prev = hive.get('${date.month}/${date.year}');
                              prev += int.parse(amount);
                              hive.put(
                                  '${DateTime.now().month}/${DateTime.now().year}',
                                  prev);
                            });
                          }
                        }),
                        child: Ink(
                          height: 40,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: blueColor,
                              borderRadius: BorderRadius.circular(20)),
                          child: const Center(child: Text("Create")),
                        ),
                      )
                    ],
                  ),
                )
              : Lottie.asset('assets/done.zip',
                  height: 200, width: double.infinity, controller: _controller),
        ),
      ),
    );
  }
}
