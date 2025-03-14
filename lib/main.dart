import 'dart:io';

import 'package:firedart/firedart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tat_windows/AdminScreen/bloc/AdminBloc.dart';
import 'package:tat_windows/Beat/bloc/BeatBloc.dart';
import 'package:tat_windows/Firebase/bloc/FirebaseBloc.dart';

import 'package:tat_windows/Hive/Bills.dart';
import 'package:tat_windows/Hive/bloc/Hivebloc.dart';
import 'package:tat_windows/Printing/Bloc/print_bloc.dart';
import 'package:tat_windows/Products/bloc/Product_bloc.dart';
import 'package:tat_windows/companies/bloc/companyBloc.dart';

import 'BillingScreen/bloc/billing_bloc.dart';
import 'Hive/FileAdapter.dart';
import 'Screens/Navigation.dart';
import 'Welcome.dart';

const apiKey = "AIzaSyBlOmgdhLKTyjzSan09wNLZrHEGFunMoRc";
const projectId = "tharani-a-traders";

void main() async {
  //WidgetsFlutterBinding.ensureInitialized();
  FirebaseAuth.initialize(apiKey, VolatileStore());
  Firestore.initialize(projectId); // Firestore reuses the auth client
  // sqfliteFfiInit();
  // databaseFactory = databaseFactoryFfi; // shutting down the sql testing
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
    box.close();
  });
  await Hive.openBox('billNumber').then((box) async {
    if (box.isEmpty) {
      await box.put('billNumber', 1);
      print(await box.get('billNumber'));
    }
    box.close();
  });
  // runApp(MaterialApp(home: StreamBuilder(stream: ,),));

  runApp(MultiBlocProvider(providers: [
    BlocProvider(
      create: (context) => HiveBloc(),
    ),
    BlocProvider(
      create: (context) => FirebaseBloc(),
    ),
    BlocProvider(
      create: (context) => BillingBloc(),
    ),
    BlocProvider(
      create: (context) => PrintBloc(),
    ),
    BlocProvider(create: (context) => ProductBloc()),BlocProvider(
      create: (context) => BeatBloc(),
    ),
    BlocProvider(
      create: (context) => AdminBloc(firebaseBloc: context.read<FirebaseBloc>(),hiveBloc: context.read<HiveBloc>()),
    ),
    BlocProvider(
      create: (context) => CompanyBloc(),
    ),
  ], child: App()));
}

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    context.read<HiveBloc>().add(FetchTatPath());
    context.read<HiveBloc>().add(FetchPath());
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
