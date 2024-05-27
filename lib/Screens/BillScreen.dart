import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:open_file/open_file.dart';
import 'package:tat_win/Hive/Hive.dart';

import '../Widgets/Areas.dart';
import '../Widgets/Shops.dart';

class BillScreen extends StatefulWidget {
  const BillScreen({super.key});

  @override
  State<BillScreen> createState() => _BillScreenState();
}

class _BillScreenState extends State<BillScreen> {
  late String path;
  late String tatPath;
  String shopname = "Shop name";
  String Location = "--select--";
  bool isLoading = false;
  Set<String> ShopsList = {"Shop name"};
  bool dirExtits = true;
  bool isShopLoding = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setup();
    SetLocations();
  }

  void setup() async {
    setState(() {
      isLoading = true;
    });
    final tempPath = await getPath();
    final tempTatPath = await getTatPath();
    setState(() {
      path = tempPath;
      tatPath = tempTatPath;
    });
    setState(() {
      isLoading = false;
    });
  }

  Future<void> GetitShops(String Location) async {
    final list = Shops().getShops(Location);
    final dupe = await list;
    setState(() {
      ShopsList = {"Shop name", ...dupe.map((e) => e.shopName)};
    });
    //print(ShopsList);
    //shopLoadStatus = false;
  }

  Set<String> locations = {};
  SetLocations() async {
    final temloc = await Areas().GetLocationsF();
    //print(temloc);
    setState(() {
      locations = temloc;
    });
  }

  Widget DropDownLocation() {
    return DropdownButton(
        elevation: 50,
        autofocus: true,
        dropdownColor: Color.fromRGBO(222, 217, 217, 1),
        borderRadius: BorderRadius.circular(20),
        value: Location,
        items: locations
            .map((e) => DropdownMenuItem(
                  value: e,
                  key: UniqueKey(),
                  child: Text(e),
                ))
            .toList(),
        onChanged: (values) async {
          setState(() {
            isShopLoding = true;
          });
          setState(() {
            // DropDownView = values!;
            Location = values.toString();
            shopname = "Shop name";
          });
          await GetitShops(Location);
          setState(() {
            isShopLoding = false;
          });
        });
  }

  Widget DropDownShops() {
    //GetitShops(Location);
    if (!isShopLoding)
      return DropdownButton(
          elevation: 50,
          autofocus: true,
          dropdownColor: Color.fromRGBO(222, 217, 217, 1),
          borderRadius: BorderRadius.circular(20),
          value: shopname,
          items: ShopsList.map((e) => DropdownMenuItem(
                value: e,
                key: UniqueKey(),
                child: Text(e),
              )).toList(),
          onChanged: (values) {
            setState(() {
              shopname = values.toString();
              // print(shopname);
            });
          });
    return CircularProgressIndicator();
  }

  Widget PdfList() {
    String documentaryPath = '$tatPath/Bills/$Location/$shopname';

    List<FileSystemEntity> files;
    try {
      Directory directory = Directory(documentaryPath);
      files = directory.listSync();

      return SingleChildScrollView(
          child: Column(
        children: [
          ...files
              .map((e) => GestureDetector(
                    onTap: () {
                      OpenFile.open(e.path);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.picture_as_pdf_rounded),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          e.path
                              .split('/')[e.path.split('/').length - 1]
                              .split("\\")[1],
                          style: GoogleFonts.lexend(fontSize: 18),
                        ),
                      ],
                    ),
                  ))
              .toList()
        ],
      ));
    } catch (e) {
      Get.snackbar("ERROR", '${e.toString()}', duration: Duration(seconds: 3))
          .show();
      //print(e.toString());
      return Center(
          child: Text('No Bills till now for $shopname in $Location'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.all(10),
            child: Center(
              child: Column(
                children: [
                  DropDownLocation(),
                  if (Location != "--select--") DropDownShops(),
                  if (Location != "--select--" && shopname != "Shop name")
                    //Text("")
                    Container(child: PdfList())
                ],
              ),
            )));
  }
}
