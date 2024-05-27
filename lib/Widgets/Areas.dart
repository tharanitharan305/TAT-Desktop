import 'package:firedart/firestore/firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

import 'DateTime.dart';

class Areas {
  var Locations = {
    "--select--",
    "Karur_Local",
    "China tharapuram",
    "velayuthapalayam",
    "Tharagampatti",
    "Pallapatti",
    "Thennilai",
    "lalapetai",
    "Panjapatti",
    "Aravakurichi"
  };
  bool check(String str, var file) {
    for (int i = 0; i < file.length; i++) {
      if (file[i]["locations"] == str) {
        // Get.closeAllSnackbars();
        // Get.snackbar(
        //   "Location Exists",
        //   "$str is alread there",
        //   duration: Duration(seconds: 5),
        // );
        return false;
      }
    }
    return true;
  }

  Uuid uuid = Uuid();
  Future<void> AddLocation(String location) async {
    String uid = uuid.v4();

    try {
      final file = await Firestore.instance.collection("locations").get();
      if (location.length <= 0) throw Error();
      if (!check(location, file)) throw Error();
      Firestore.instance.collection("locations").document(uid).set(
          {"locations": location, "uid": uid, "date": DateTimeTat().GetDate()});
      Get.snackbar("Sucess", "$location added SucessFully",
          duration: Duration(seconds: 5));
    } on Error catch (e) {
      //Get.closeAllSnackbars();
      if (Get.isSnackbarOpen) {
        print(Get.isSnackbarOpen);
        // Get.closeAllSnackbars();
      }
      Get.dialog(AlertDialog(
        icon: Icon(
          Icons.warning_rounded,
          color: Colors.redAccent,
        ),
        title: Text("Error "),
        content: Text("Error in adding locations $location Error=${e}"),
      ));
    }
    // Get.back();
  }

  Future<Set<String>> GetLocationsF() async {
    Set<String> Firelocations = {"--select--"};
    final firebase = await Firestore.instance.collection("locations").get();

    try {
      for (int i = 0; i < firebase.length; i++) {
        Firelocations.add(firebase[i]["locations"]);
      }
      //print(locations);
    } on HiveError catch (e) {
      Get.dialog(Icon(Icons.warning_rounded));
    }
    if (Firelocations.length <= 1) return Locations;
    return Firelocations;
  }
}
