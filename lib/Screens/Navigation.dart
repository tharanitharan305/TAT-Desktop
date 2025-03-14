import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tat_windows/BillingScreen/bloc/billing_bloc.dart';
import 'package:tat_windows/Printing/print.dart';
import 'package:tat_windows/Products/Widgets/Product_Getter.dart';
import 'package:tat_windows/Screens/excel%20add.dart';

import 'package:tat_windows/Widgets/SilentPrinting.dart';

import '../AdminScreen/Admin.dart';
import '../Printing/Bloc/print_bloc.dart';
import '../Widgets/Add.dart';
import '../Widgets/ShopGetter.dart';
import 'AddCompany.dart';
import 'AddLocation.dart';
import 'AdminScreen.dart';
import 'BillScreen.dart';
import '../BillingScreen/Billing.dart';
import 'Employees.dart';
import 'OrderScreen.dart';
import 'Settings.dart';
import 'Shops.dart';

class NavigationPaneDemo extends StatefulWidget {
  @override
  _NavigationPaneDemoState createState() => _NavigationPaneDemoState();
}

class _NavigationPaneDemoState extends State<NavigationPaneDemo> {
  int _selectedIndex = 0;
  double _drawerWidth = 0.8; // Initial width 10% of the screen
  static final List<Widget> _widgetOptions = <Widget>[
    AdminScreen(), //0
  //  BillScreen(), // OrderScreen(), //1
    ProductGetter(), //AddProduct(), //2
    ShopGetter(), //3
    //BillScreen(), //4
    Settings(), //5
    Employees(), //6
    AddLocation(), //7
    AddCompany(), //8
    Billing(), //9
    //ShopDet(), //10
    PrintingFiles(), //SilentPdfPrinter(), //11
    AddProductE() //12
  ];
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "TAT",
          style: GoogleFonts.lexend(),
        ),
      ),
      body: Row(
        children: <Widget>[
          MouseRegion(
            onEnter: (_) {
              setState(() {
                _drawerWidth = 0.25; // Increase width to 25% on hover
              });
            },
            onExit: (_) {
              setState(() {
                _drawerWidth = 0.10; // Revert back to 10% when mouse leaves
              });
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              width: MediaQuery.of(context).size.width *
                  _drawerWidth, // Control width dynamically
              color: Colors.white,
              child: Drawer(
                backgroundColor: Color.fromRGBO(241, 228, 218, 1),
                child: ListView(
                  children: <Widget>[
                    // Use a Column with only the icon visible in the collapsed state
                    ListTile(
                      leading: Icon(Icons.shopping_cart_checkout_rounded),
                      title: _drawerWidth > 0.15
                          ? Text('View Order')
                          : null, // Show text only when drawer is expanded
                      onTap: () {
                        setState(() {
                          _selectedIndex = 0;
                        });
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.shopping_bag_rounded),
                      title: _drawerWidth > 0.15 ? Text('Place Order') : null,
                      onTap: () {
                        setState(() {
                          _selectedIndex = 1;
                        });
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.add_shopping_cart_rounded),
                      title: _drawerWidth > 0.15 ? Text('Add Product') : null,
                      onTap: () {
                        setState(() {
                          _selectedIndex = 2;
                        });
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.add_business_rounded),
                      title: _drawerWidth > 0.15 ? Text('Add Shop') : null,
                      onTap: () {
                        setState(() {
                          _selectedIndex = 3;
                        });
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.add_location),
                      title: _drawerWidth > 0.15 ? Text('Add Location') : null,
                      onTap: () {
                        setState(() {
                          _selectedIndex = 7;
                        });
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.factory_rounded),
                      title: _drawerWidth > 0.15 ? Text('Add Company') : null,
                      onTap: () {
                        setState(() {
                          _selectedIndex = 8;
                        });
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.print_rounded),
                      title: _drawerWidth > 0.15 ? Text('Bills') : null,
                      onTap: () {
                        setState(() {
                          _selectedIndex = 4;
                        });
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.fingerprint_rounded),
                      title: _drawerWidth > 0.15 ? Text('Attendance') : null,
                      onTap: () {
                        Get.dialog(AlertDialog(
                          title: Text("Update Required"),
                          content: Text("contact +919787874607"),
                        ));
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.people_outline_rounded),
                      title: _drawerWidth > 0.15 ? Text('Employees') : null,
                      onTap: () {
                        setState(() {
                          _selectedIndex = 6;
                        });
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.store_rounded),
                      title: _drawerWidth > 0.15 ? Text('Shops') : null,
                      onTap: () {
                        setState(() {
                          _selectedIndex = 10;
                        });
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.settings_rounded),
                      title: _drawerWidth > 0.15 ? Text('Settings') : null,
                      onTap: () {
                        setState(() {
                          _selectedIndex = 5;
                        });
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.format_align_left_rounded),
                      title: _drawerWidth > 0.15 ? Text('Billing') : null,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Billing(),
                            ));
                        // setState(() {
                        //   _selectedIndex = 9;
                        // });
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.print),
                      title: _drawerWidth > 0.15 ? Text('Printing') : null,
                      onTap: () {
                        setState(() {
                          _selectedIndex = 11;
                        });
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.sd_card),
                      title: _drawerWidth > 0.15 ? Text('ADD EXCEL') : null,
                      onTap: () {
                        setState(() {
                          _selectedIndex = 12;
                        });
                      },
                    ),
                  ],
                ),
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
