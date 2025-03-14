import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../Widgets/DateTime.dart';

class Companies {
  var companies = {"--select--", "GRB", "Elite", "Tata", "Unibic", "Beros"};

  bool check(String str, List<Document> file) {
    for (var doc in file) {
      if (doc["Company name"] == str) {
        return false;
      }
    }
    return true;
  }

  Uuid uuid = Uuid();

  Future<void> AddCompany(String location) async {
    String uid = uuid.v4();
    try {
      final file = await Firestore.instance.collection("companies").get();

      if (location.isEmpty) throw "Enter a valid company name";
      if (!check(location, file)) throw "$location already exists";

      await Firestore.instance.collection("companies").document(uid).set({
        "Company name": location,
        "uid": uid,
        "date": DateTimeTat().GetDate(),
      });

      Get.snackbar("Success", "$location added successfully",
          duration: Duration(seconds: 5));
    } catch (e) {
      Get.dialog(AlertDialog(
        icon: Icon(Icons.warning_rounded, color: Colors.redAccent),
        title: Text("Error"),
        content: Text("Error in adding company: $e"),
      ));
    }
  }

  Future<Set<String>> GetCompany() async {
    Set<String> locations = {"--select--"};

    try {
      final firebase = await Firestore.instance.collection("companies").get();
      for (var doc in firebase) {
        locations.add(doc["Company name"]);
      }
    } catch (e) {
      Get.dialog(Icon(Icons.warning_rounded));
    }

    return locations.isNotEmpty ? locations : companies;
  }
}
