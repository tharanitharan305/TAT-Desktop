import 'package:firedart/firedart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tat_win/Firebase/NewOrder.dart';
import 'package:tat_win/Screens/splashScreen.dart';

import '../PDF/PDF.dart';
import '../PDF/PdfGenerator.dart';
import '../Widgets/Areas.dart';
import '../Widgets/DateTime.dart';
import '../Widgets/Info.dart';
import '../Widgets/OrderFormat.dart';
import '../Widgets/Orders.dart';
import '../Widgets/OrderviewCard.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() {
    return _AdminScreen();
  }
}

class _AdminScreen extends State<AdminScreen> {
  bool isPrinting = false;
  String DropDownView = "--select--";
  String Location = "--select--";
  List<Orders> fromBase = [];
  List<String> send = [];
  String Today = DateTimeTat().GetDate();
  String dayTotal = "0";
  bool isFullpage = false;
  List<String> Time = [
    DateTimeTat().GetpreDate(0),
    DateTimeTat().GetpreDate(1),
    DateTimeTat().GetpreDate(2),
    DateTimeTat().GetpreDate(3),
    DateTimeTat().GetpreDate(4),
    DateTimeTat().GetpreDate(5),
    DateTimeTat().GetpreDate(6),
    DateTimeTat().GetpreDate(7),
    DateTimeTat().GetpreDate(8),
  ];
  Set<String> locations = {};
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

  Future<bool> generate() async {
    var list = await Firestore.instance
        .collection(Location)
        .where('Date', isEqualTo: Today)
        .get();
    return list.isEmpty || list == null;
  }

  generatingFullBills() async {
    Get.dialog(Center(child: CircularProgressIndicator()));
    var list = await Firestore.instance
        .collection(Location)
        .where('Date', isEqualTo: Today)
        .get();
    if (list.isEmpty || list == null || list.length <= 0) {
      Get.snackbar("No bills", "There are no Bills $Location in $Today date",
          duration: Duration(seconds: 5));
      return;
    } else {
      for (int i = 0; i < list.length; i++) {
        var e = list[i];
        var filteredOrder = "";
        var order = e['Orders'].toString().split(",");
        // OrderFormat().ViewFormat(order);
        for (int i = 0; i < order.length; i++) {
          if (!order[i].endsWith('null')) {
            filteredOrder += order[i];
          }
        }
        send = filteredOrder.split(";");
        fromBase = OrderFormat().ViewFormat(send);
        PDF pdf = PDF(
          phno: e["phno"],
          Date: e['Date'],
          items: fromBase,
          Shopname: e['Shopname'],
          useremail: e['Ordered by'],
          timestamp: e['Ordered time'],
          total: e['Total'],
          location: Location,
        );
        PdfGenerator(
          pdf: pdf,
          isFullPage: false,
        ).generatePdf();
      }
    }
    Get.back();
  }

  // Widget build(context) {
  //   return TextButton(onPressed: generate, child: Text("press"));
  // }
  @override
  Widget build(context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(222, 217, 217, 1),
          shape: const RoundedRectangleBorder(),
          actions: [
            IconButton(
                onPressed: generatingFullBills,
                icon: Icon(Icons.print_rounded)),
            DropdownButton(
                elevation: 50,
                autofocus: true,
                dropdownColor: Color.fromRGBO(222, 217, 217, 1),
                borderRadius: BorderRadius.circular(20),
                value: DropDownView,
                items: locations
                    .map((e) => DropdownMenuItem(
                          value: e,
                          key: UniqueKey(),
                          child: Text(e),
                        ))
                    .toList(),
                onChanged: (values) {
                  setState(() {
                    DropDownView = values!;
                    Location = values.toString();
                  });
                }),
            SizedBox(
              width: 20,
            ),
            DropdownButton(
                elevation: 50,
                autofocus: true,
                dropdownColor: Color.fromRGBO(222, 217, 217, 1),
                borderRadius: BorderRadius.circular(20),
                value: Today,
                items: Time.map((e) => DropdownMenuItem(
                      value: e,
                      key: UniqueKey(),
                      child: Text(e),
                    )).toList(),
                onChanged: (values) {
                  setState(() {
                    Today = values!;
                  });
                })
          ],
        ),
        body: StreamBuilder(
          stream: Firestore.instance
              .collection(Location)
              .where('Date', isEqualTo: Today)
              .get()
              .asStream(),
          builder: (context, OrderSnapCuts) {
            NewOrder().getOrder(Location, Today);
            if (OrderSnapCuts.connectionState == ConnectionState.waiting) {
              return Center(
                  child: SplashScreen(
                height: 50,
                width: 50,
              ));
            }
            if (!OrderSnapCuts.hasData || OrderSnapCuts.data!.isEmpty) {
              return Center(
                child: Text('No Orders Found at $Location'),
              );
            }
            if (OrderSnapCuts.hasError) {
              return const Center(
                  child: Text(
                      'An Error Occured Try To Restart or Contact +91 9787874607'));
            }
            final RecivedOrders = OrderSnapCuts.data!;
            //print(RecivedOrders);
            return ListView.builder(
              itemCount: RecivedOrders.length,
              itemBuilder: (context, index) {
                var filteredOrder = "";
                var order =
                    RecivedOrders[index]['Orders'].toString().split(",");
                // OrderFormat().ViewFormat(order);
                for (int i = 0; i < order.length; i++) {
                  if (!order[i].endsWith('null')) {
                    filteredOrder += order[i];
                  }
                }
                send = filteredOrder.split(";");
                fromBase = OrderFormat().ViewFormat(send);

                return Column(
                  children: [
                    GestureDetector(
                      onLongPress: () {
                        PDF pdf = PDF(
                          Date: RecivedOrders[index]['Date'],
                          items: fromBase,
                          Shopname: RecivedOrders[index]['Shopname'],
                          useremail: RecivedOrders[index]['Ordered by'],
                          timestamp: RecivedOrders[index]['Ordered time'],
                          total: RecivedOrders[index]['Total'],
                          location: Location,
                          phno: RecivedOrders[index]["phno"],
                        );
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text("Conformation.."),
                            content: Text("Confirm to get bill on full A4"),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('Cancel')),
                              TextButton(
                                  onPressed: () async {
                                    PdfGenerator(
                                      isFullPage: true,
                                      pdf: pdf,
                                    ).generatePdf();
                                    Navigator.pop(context);
                                  },
                                  child: Text("Get Bill"))
                            ],
                          ),
                        );
                      },
                      child: OrderViewCard(
                        items: fromBase,
                        Shopname: RecivedOrders[index]['Shopname'],
                        useremail: RecivedOrders[index]['Ordered by'],
                        timestamp: RecivedOrders[index]['Ordered time'],
                        total: RecivedOrders[index]['Total'],
                        location: Location,
                        uid: RecivedOrders[index]['uid'],
                      ),
                    )
                  ],
                );
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return Info();
              },
            );
          },
          child: Icon(Icons.currency_rupee),
        ),
      ),
    );
  }
}
