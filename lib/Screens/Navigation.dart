import 'dart:math';

import 'package:animated_icon/animated_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tat_win/Firebase/NewOrder.dart';
import 'package:tat_win/Screens/AddCompany.dart';
import 'package:tat_win/Screens/AddLocation.dart';
import 'package:tat_win/Screens/AdminScreen.dart';
import 'package:tat_win/Screens/Attendance.dart';
import 'package:tat_win/Screens/BillScreen.dart';
import 'package:tat_win/Screens/Employees.dart';
import 'package:tat_win/Screens/OrderScreen.dart';
import 'package:tat_win/Screens/Settings.dart';
import 'package:tat_win/Screens/Shops.dart';
import 'package:tat_win/Widgets/Add.dart';
import 'package:tat_win/Widgets/ShopGetter.dart';

class NavigationPaneDemo extends StatefulWidget {
  @override
  _NavigationPaneDemoState createState() => _NavigationPaneDemoState();
}

class _NavigationPaneDemoState extends State<NavigationPaneDemo> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    AdminScreen(),
    OrderScreen(),
    Add(),
    ShopGetter(),
    BillScreen(),
    Settings(),
    Attendance(),
    Employees(),
    AddLocation(),
    AddCompany(),
    ShopDet()
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  backgroundColor: Color.fromRGBO(241, 228, 218, 1),
      appBar: AppBar(
        title: Text(
          "TAT",
          style: GoogleFonts.lexend(),
        ),
      ),
      body: Row(
        children: <Widget>[
          Container(
            color: Colors.white,
            // height: MediaQuery.of(context).size.height,
            // width: 89,
            child: Drawer(
              backgroundColor: Color.fromRGBO(241, 228, 218, 1),
              width: MediaQuery.of(context).size.width * 0.20,
              child: ListView(
                //padding: EdgeInsets.zero,
                children: <Widget>[
                  ListTile(
                    title: Text('View Order'),
                    leading: Icon(Icons.shopping_cart_checkout_rounded),
                    onTap: () {
                      setState(() {
                        _selectedIndex = 0;
                      });
                      // Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: Text('Place Order'),
                    leading: Icon(Icons.shopping_bag_rounded),
                    onTap: () {
                      setState(() {
                        _selectedIndex = 1;
                      });
                      // Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: Text('Add Produt'),
                    leading: Icon(Icons.add_shopping_cart_rounded),
                    onTap: () {
                      setState(() {
                        _selectedIndex = 2;
                      });
                      //  Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: Text('Add Shop'),
                    leading: Icon(Icons.add_business_rounded),
                    onTap: () {
                      setState(() {
                        _selectedIndex = 3;
                      });
                      //  Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: Text('Add Location'),
                    leading: Icon(Icons.add_location),
                    onTap: () {
                      setState(() {
                        _selectedIndex = 8;
                      });
                      //  Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: Text('Add Company'),
                    leading: Icon(Icons.factory_rounded),
                    onTap: () {
                      setState(() {
                        _selectedIndex = 9;
                      });
                      //  Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: Text('Bills'),
                    leading: Icon(Icons.print_rounded),
                    onTap: () {
                      setState(() {
                        _selectedIndex = 4;
                      });
                      //  Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: Text('Attendance'),
                    leading: Icon(Icons.fingerprint_rounded),
                    onTap: () {
                      // setState(() {
                      //   _selectedIndex = 6;
                      // });
                      Get.dialog(AlertDialog(
                        title: Text("Update Requeried"),
                        content: Text("contact +919787874607"),
                      ));
                      //  Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: Text('Employees'),
                    leading: Icon(Icons.people_outline_rounded),
                    onTap: () {
                      setState(() {
                        _selectedIndex = 7;
                      });
                      //  Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: Text('Shops'),
                    leading: Icon(Icons.people_outline_rounded),
                    onTap: () {
                      setState(() {
                        _selectedIndex = 10;
                      });
                      //  Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: Text('Settings'),
                    leading: Icon(Icons.settings_rounded),
                    onTap: () {
                      setState(() {
                        _selectedIndex = 5;
                      });
                      //  Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: _widgetOptions.elementAt(_selectedIndex),
            ),
          ),
        ],
      ),
    );
  }
}
