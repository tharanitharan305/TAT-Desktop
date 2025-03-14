import 'package:hive/hive.dart';
import 'dart:async';

Future<int> getbillNumber() async {
  final box = await Hive.openBox('billNumber');
  return box.get('billNumber', defaultValue: 0);
}

Future<int> upDateBillNumber(int oldBillNumber) async {
  final box = await Hive.openBox('billNumber');
  int newBillNumber = oldBillNumber + 1;
  await box.put('billNumber', newBillNumber);
  return newBillNumber;
}

