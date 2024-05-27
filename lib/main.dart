import 'dart:io';

import 'package:firedart/firedart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tat_win/Hive/Bills.dart';
import 'package:tat_win/Hive/FileAdapter.dart';
import 'package:tat_win/Screens/UserInterface.dart';
import 'package:tat_win/Welcome.dart';

import 'Screens/Navigation.dart';

const apiKey = "AIzaSyBlOmgdhLKTyjzSan09wNLZrHEGFunMoRc";
const projectId = "tharani-a-traders";

void main() async {
  //WidgetsFlutterBinding.ensureInitialized();
  FirebaseAuth.initialize(apiKey, VolatileStore());
  Firestore.initialize(projectId); // Firestore reuses the auth client

  final documentdir = await getApplicationDocumentsDirectory();
  final desktopDirectory = await getDownloadsDirectory();
  final newFolder = Directory('${desktopDirectory!.path}/TAT');
  await newFolder.create();
  print(desktopDirectory.path);
  Hive
    ..init(documentdir.path)
    ..registerAdapter(BillsAdapter())
    ..registerAdapter(FileAdapter());
  //await Hive.deleteBoxFromDisk('appSettings');
  await Hive.openBox('appSettings').then((box) {
    box.add({
      'path': desktopDirectory.path,
      'tat path': '${desktopDirectory.path}/TAT'
    });
  });

  // runApp(MaterialApp(home: StreamBuilder(stream: ,),));
  runApp(App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TAT',
      theme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 129, 91, 91)),
      ),
      //home: NavigationPaneDemo(),
      home: StreamBuilder(
          stream: FirebaseAuth.instance.signInState,
          builder: (context, snapshot) {
            // if (snapshot.connectionState == ConnectionState.waiting) {
            //   // Get.dialog(AlertDialog(
            //   //   title: Text("Try Again"),
            //   // ));
            //   return CircularProgressIndicator();
            // }
            if (snapshot.hasData) {
              //return UserInterface();
              return NavigationPaneDemo();
            } else {
              return const Welcome();
            }
          }),
    );
  }
}
