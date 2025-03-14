// import 'package:firedart/firedart.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:hive/hive.dart';
// import 'package:tat_windows/Screens/AddCompany.dart';
// import 'package:tat_windows/Widgets/DateTime.dart';
// import 'package:uuid/uuid.dart';
//
// class Companies {
//   var companies = {"--select--", "GRB", "Elite", "Tata", "Unibic", "Beros"};
//   bool check(String str, var file) {
//     for (int i = 0; i < file.length; i++) {
//       if (file[i]['Company name'] == str) {
//         // Get.closeAllSnackbars();
//         // Get.snackbar(
//         //   "Location Exists",
//         //   "$str is alread there",
//         //   duration: Duration(seconds: 5),
//         // );
//         return false;
//       }
//     }
//     return true;
//   }
//
//   Uuid uuid = Uuid();
//   Future<void> AddCompany(String location) async {
//     String uid = uuid.v4();
//
//     try {
//       final file = await Firestore.instance.collection("companies").get();
//       if (location.length <= 0) throw Error();
//       if (!check(location, file)) throw Error();
//       Firestore.instance.collection("companies").document(uid).set({
//         "Company name": location,
//         "uid": uid,
//         "date": DateTimeTat().GetDate()
//       });
//       Get.snackbar("Sucess", "$location added SucessFully",
//           duration: Duration(seconds: 5));
//     } on Error catch (e) {
//       //Get.closeAllSnackbars();
//       if (Get.isSnackbarOpen) {
//         print(Get.isSnackbarOpen);
//         // Get.closeAllSnackbars();
//       }
//       Get.dialog(AlertDialog(
//         icon: Icon(
//           Icons.warning_rounded,
//           color: Colors.redAccent,
//         ),
//         title: Text("Error "),
//         content: Text("Error in adding Company $location Error=${e}"),
//       ));
//     }
//     // Get.back();
//   }
//
//   Future<Set<String>> GetCompany() async {
//     Set<String> locations = {"--select--"};
//     final firebase = await Firestore.instance.collection("companies").get();
//
//     await Hive.openBox("companies").then((box) {
//       try {
//         for (int i = 0; i < firebase.length; i++) {
//           locations.add(firebase[i]['Company name']);
//         }
//         print(locations);
//       } on HiveError catch (e) {
//         Get.dialog(Icon(Icons.warning_rounded));
//       }
//     });
//     return locations;
//   }
// }
