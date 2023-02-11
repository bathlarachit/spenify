import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:hive_flutter/hive_flutter.dart';

bool isUseFull(SmsMessage sms) {
  var msgBody = sms.body;
  var debitMsg = "debited";
  var reqMsg = "will be debited";

  if (msgBody!.contains(reqMsg)) return false;
  if (msgBody.contains(debitMsg)) return true;
  return false;
}

bool filterMessage(SmsMessage sms, int month, int year) {
  if (month == sms.date!.month && sms.date!.year == year) {
    return true;
  } else {
    return false;
  }
}

Future<List<SmsMessage>> getMessage(int month, int year) async {
  final List<SmsMessage> msgs = [];
  final SmsQuery query = SmsQuery();
  var permission = await Permission.sms.status;
  while (permission.isDenied) {
    await Permission.sms.request();
  }

  final messages = await query.querySms(
    kinds: [SmsQueryKind.inbox],
    //address: 'AD-SBIUPI',
    // address: '+254712345789',
    count: 1000,
    sort: true,
  );

  for (int i = 0; i < messages.length; i++) {
    if (filterMessage(messages[i], month, year) && isUseFull(messages[i])) {
      msgs.add(messages[i]);
    }
  }
  return msgs;
}

int getMoney(String? STR) {
  String s = "";
  String str = STR!;
  var ar = '0123456789';
  if (str.contains('Rs') || str.contains('INR')) {
    if (str.contains('Rs')) {
      int i = str.indexOf('Rs');

      int flag = 0;
      for (i; i < str.length; i++) {
        if ((str[i] == ' ' || str[i] == '.') && flag == 1) {
          break;
        }

        if (ar.contains(str[i])) {
          flag = 1;
        }
        if (flag == 1) {
          s = s + str[i];
        }
      }
    } else {
      if (str.contains('INR')) {
        int i = str.indexOf('INR');

        int flag = 0;
        for (i; i < str.length; i++) {
          if ((str[i] == ' ' || str[i] == '.') && flag == 1) {
            break;
          }

          if (ar.contains(str[i])) {
            flag = 1;
          }
          if (flag == 1) {
            s = s + str[i];
          }
        }
      }
    }
  }

  if (s.isEmpty) {
    return 0;
  }
  return int.parse(s);
}

Future<int> feedDb() async {
  int newMsg = 0;
  final Box hive = Hive.box('mybox');
  // print('feedDb');
  var list = await getMessage(DateTime.now().month, DateTime.now().year);
  //print("list:::::${list.length}");
  DateTime date = DateTime.now();
  late DateTime lastUpdate;
  bool up = true;

  if (hive.containsKey('lastUpdate')) {
    lastUpdate = hive.get('lastUpdate');
    //print(lastUpdate);
  } else {
    up = false;
  }

  int prev = 0;
  if (hive.containsKey('${DateTime.now().month}/${DateTime.now().year}')) {
    prev = hive.get('${DateTime.now().month}/${DateTime.now().year}');
  }

  var transList = [];
  if (hive.containsKey('${date.month}/${date.year}-trans')) {
    transList = hive.get('${date.month}/${date.year}-trans');
  }
  int id = 0;
  if (hive.containsKey('${DateTime.now().month}/${DateTime.now().year}-id')) {
    id = hive.get('${DateTime.now().month}/${DateTime.now().year}-id');
  }
  id++;
  for (int i = 0; i < list.length; i++) {
    if (up == false || list[i].date!.isAfter(lastUpdate)) {
      newMsg++;
      int amt = getMoney(list[i].body);
      transList.add({
        'id': id++,
        'des': list[i].body,
        'amount': amt,
        'date': list[i].date
      });
      prev += amt;
    }
  }
  await hive.put(
      '${DateTime.now().month}/${DateTime.now().year}-trans', transList);
  await hive.put('${DateTime.now().month}/${DateTime.now().year}', prev);
  hive.put('lastUpdate', DateTime.now());
  return newMsg;
}

List<FlSpot> drawMonthGraph(int month, int year) {
  List<FlSpot> list = [];

  final Box hive = Hive.box('mybox');

  var msg = [];
  if (hive.containsKey('$month/$year-trans')) {
    msg = hive.get('$month/$year-trans');
  }

  var map = {};
  // print(msg.length);
  for (int i = 0; i < msg.length; i++) {
    if (!map.containsKey(msg[i]['date'].day)) {
      map[msg[i]['date'].day] = int.parse(msg[i]['amount']);
    } else {
      int x = map[msg[i]['date'].day];
      x = x + int.parse(msg[i]['amount'].toString());
      map[msg[i]['date'].day] = x;
    }
  }
  double x = 1;
  for (int i = 1; i <= 31; i++) {
    if (map.containsKey(i)) {
      double y = double.parse(map[i].toString());
      list.add(FlSpot(x, y));
      x = x + 1;
    }
  }

  return list;
}

final months = [
  'Jan',
  "Feb",
  'Mar',
  'Apr',
  'Jun',
  'Jul',
  'Aug',
  'Sep',
  'Oct',
  'Nov',
  'Dec'
];
