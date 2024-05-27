import 'package:firedart/auth/firebase_auth.dart';
import 'package:firedart/firestore/firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:tat_win/Widgets/DateTime.dart';

import '../Screens/splashScreen.dart';
import 'Areas.dart';

class ShopGetter extends StatefulWidget {
  State<ShopGetter> createState() => _ShopGetterState();
}

class _ShopGetterState extends State<ShopGetter> {
  String Location = "--select--";
  final key = GlobalKey<FormState>();
  String Shopname = '';
  bool uploadStatus = false;
  Set<String> locations = {};
  String phoneNumber = "";
  SetLocations() async {
    final temloc = await Areas().GetLocationsF();
    //print(temloc);
    setState(() {
      locations = temloc;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SetLocations();
  }

  void AddShop() async {
    final user = await FirebaseAuth.instance.getUser();
    if (key.currentState!.validate()) {
      key.currentState!.save();
      setState(() {
        uploadStatus = true;
      });
      try {
        await Firestore.instance
            .collection(Location + "Shops")
            .document(Shopname)
            .set({
          'Shop Name': Shopname,
          'Phone Number': phoneNumber,
          'Total Purchase': 0.0,
          'Total Balance': 0.0,
          'Time': DateTimeTat().GetDate(),
          'Created by': user.email,
        });
        Get.snackbar("Sucess", "$Shopname added Sucessfully",
            icon: Icon(Icons.done_outline), duration: Duration(seconds: 3));
        setState(() {
          uploadStatus = false;
        });
        key.currentState!.reset();
      } catch (e) {
        Get.snackbar("Fail", "$Shopname  not added",
            icon: Icon(Icons.warning),
            duration: Duration(seconds: 3),
            shouldIconPulse: true);
        setState(() {
          uploadStatus = false;
        });
      }
    } // Navigator.pop(context);
  }

  Widget build(context) {
    return Padding(
      padding: EdgeInsets.all(40),
      child: Container(
        width: double.infinity,
        child: Form(
          key: key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // if (widget.Status == "p")
              DropdownButton(
                  elevation: 50,
                  autofocus: true,
                  dropdownColor: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(20),
                  value: Location,
                  items: locations
                      .map((e) => DropdownMenuItem(
                            value: e,
                            key: UniqueKey(),
                            child: Text(e),
                          ))
                      .toList(),
                  onChanged: (values) {
                    setState(() {
                      Location = values!;
                    });
                  }),
              if (Location != "--select--")
                TextFormField(
                  decoration: InputDecoration(labelText: "Shop Name"),
                  validator: (value) {
                    if (value!.isEmpty || value.length < 3)
                      return "Enter a valid shopname";
                  },
                  onChanged: (values) {
                    setState(() {
                      Shopname = values!;
                    });
                  },
                  onSaved: (values) {
                    setState(() {
                      Shopname = values!;
                    });
                  },
                ),
              if (Location != "--select--")
                TextFormField(
                  decoration: InputDecoration(labelText: "Phone number"),
                  validator: (value) {
                    if (value!.isEmpty ||
                        value.length != 10 ||
                        !value.isNumericOnly)
                      return "Enter a valid phone number";
                  },
                  onChanged: (values) {
                    setState(() {
                      phoneNumber = values!;
                    });
                  },
                  onSaved: (values) {
                    setState(() {
                      phoneNumber = values!;
                    });
                  },
                ),
              SizedBox(
                height: 20,
              ),
              if (Shopname != null && !Shopname.isEmpty && Shopname.length >= 5)
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (uploadStatus) CircularProgressIndicator(),
                    if (!uploadStatus)
                      ElevatedButton(
                        onPressed: AddShop,
                        child: Text('Upload'),
                        style: ElevatedButton.styleFrom(
                            elevation: 10,
                            backgroundColor:
                                Theme.of(context).colorScheme.primaryContainer),
                      )
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }
}
