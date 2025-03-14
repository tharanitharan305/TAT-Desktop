import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hive/hive.dart';

Future<String> getTatPath() async {
  String tatPath = "";
  await Hive.openBox('appSettings').then((box) {
    tatPath = box.getAt(0)['tat path'];
  });
  return tatPath;
}

Future<String> getPath() async {
  String path = "";
  await Hive.openBox('appSettings').then((box) {
    path = box.getAt(0)['path'];
  });
  return path;
}

void updateTatPath(String path) async {
  // String tatPath = "";
  // await Hive.openBox('appSettings').then((box) {
  //   box.putAt(0, {'tat path': path});
  // });
  print('hai');
  Get.snackbar(
    'PATH..',
    'Cannot set path currently..',
    duration: Duration(seconds: 2),
  );
}

Future<String> getDatePath(String date) async {
  final returnPath = await Hive.openBox('appSettings').then((box) async {
    String tatPath = box.getAt(0)['tat path'];
    return '$tatPath/Bills/ByDate/$date';
  });
  return returnPath;
}
