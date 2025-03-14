import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../Widgets/DateTime.dart';

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

  bool check(String str, List<Document> docs) {
    for (var doc in docs) {
      if (doc['locations'] == str) {
        return false;
      }
    }
    return true;
  }

  Uuid uuid = Uuid();

  Future<void> AddLocation(String location) async {
    String uid = uuid.v4();

    try {
      final collection = Firestore.instance.collection("locations");
      final docs = await collection.get();

      if (location.isEmpty) throw "Enter a valid shop name";
      if (!check(location, docs)) throw "$location already exists";

      await collection.document(uid).set({
        "locations": location,
        "uid": uid,
        "date": DateTimeTat().GetDate(),
      });

      Get.snackbar("Success", "$location added successfully",
          duration: Duration(seconds: 5));
    } catch (e) {
      Get.dialog(AlertDialog(
        icon: Icon(
          Icons.warning_rounded,
          color: Colors.redAccent,
        ),
        title: Text("Error"),
        content: Text("Error in adding Company $location. Error=${e.toString()}"),
      ));
    }
  }

  Future<Set<String>> GetLocations() async {
    Set<String> locations = {"--select--"};

    try {
      final collection = Firestore.instance.collection("locations");
      final docs = await collection.get();

      for (var doc in docs) {
        locations.add(doc['locations']);
      }
    } catch (e) {
      Get.dialog(AlertDialog(
        icon: Icon(Icons.warning_rounded),
        title: Text("Error"),
        content: Text("Error fetching locations: ${e.toString()}"),
      ));
    }

    return locations.length > 1 ? locations : Locations;
  }
}
