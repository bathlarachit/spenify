import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:spenify/utils.dart';

class Home extends StatefulWidget {
  @override
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double sum = 0;
  bool loading = false;
  int amount = 0;
  var t1, t2;
  late Box hive;
  String name = "Alex";
  String strDate = '${DateTime.now().month}/${DateTime.now().year}';
  @override
  void initState() {
    hive = Hive.box('mybox');
    if (hive.containsKey('lT-1')) {
      t1 = hive.get('lT-1');
    } else {
      t1 = "";
    }
    if (hive.containsKey('lT-2')) {
      t2 = hive.get('lT-2');
    } else {
      t2 = "";
    }
    if (hive.containsKey('${DateTime.now().month}/${DateTime.now().year}')) {
      amount = hive.get('${DateTime.now().month}/${DateTime.now().year}');
    } else {
      amount = 0;
      hive.put('${DateTime.now().month}/${DateTime.now().year}', 0);
    }
    if (hive.containsKey('name')) {
      name = hive.get('name');
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () => Navigator.pushNamed(context, '/trans'),
            ),
            body: (loading == false)
                ? Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Image(
                            image: AssetImage('assets/Boy.png'),
                            height: 40,
                            width: 40),
                        const SizedBox(
                          height: 30,
                        ),
                        Text(
                          "Hi, $name",
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w400),
                        ),
                        const Text(
                          "Welcome Back!",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w900),
                        ),
                        const Divider(),
                        const Text(
                          "Balance",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 100,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: const Color.fromRGBO(139, 179, 255, 1),
                              borderRadius: BorderRadius.circular(15)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Row(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('Total Balance'),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Text(
                                        '\$${hive.get(strDate)}',
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 28.0),
                                  child: IconButton(
                                      onPressed: () async {
                                        setState(() {
                                          loading = true;
                                        });
                                        var newmsg = await feedDb();
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          duration: const Duration(
                                              milliseconds: 1500),
                                          content: (newmsg != 0)
                                              ? Text("Added $newmsg Messages")
                                              : const Text(
                                                  'No new transaction'),
                                        ));
                                        setState(() {
                                          loading = false;
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.refresh,
                                      )),
                                ),
                                IconButton(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                        context,
                                        '/list',
                                      );
                                    },
                                    icon: const Icon(Icons
                                        .keyboard_double_arrow_right_outlined))
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'Last Operations',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w700),
                        ),
                        (t1 != '')
                            ? Card(
                                elevation: 0.5,
                                child: ListTile(
                                  trailing: Text(
                                    "Rs ${t1['amount']}",
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  title: Text(
                                    t1['des'],
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  subtitle: Text(
                                      '${t1['date'].day} ${months[t1['date'].month - 1]} ${t1['date'].year}'),
                                ),
                              )
                            : const Text(''),
                        (t2 != '')
                            ? Card(
                                elevation: 0.5,
                                child: ListTile(
                                  trailing: Text(
                                    "Rs ${t2['amount']}",
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  title: Text(
                                    t2['des'],
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  subtitle: Text(
                                      '${t2['date'].day} ${months[t2['date'].month - 1]} ${t2['date'].year}'),
                                ),
                              )
                            : const Text(''),
                      ],
                    ),
                  )
                : const Center(child: CircularProgressIndicator())));
  }
}
