import 'package:firedart/auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Firebase/NewOrder.dart';
import 'Orders.dart';

class OrderPreview extends StatefulWidget {
  OrderPreview({
    super.key,
    required this.Order,
    required this.Shopname,
    required this.Location,
    required this.phno
  });
  Set<Orders> Order;
  String Shopname;
  String Location;
String phno;
  @override
  State<OrderPreview> createState() => _OrderPreview();
}

class _OrderPreview extends State<OrderPreview> {
  final spkey = GlobalKey<FormState>();
  bool changeQuan = true;
  late final user;
  bool isWorking = true;
  void Upload() {
    NewOrder().putOrder(widget.Order, widget.Shopname, widget.Location,widget.phno);
    Navigator.pop(context);
  }

  void setup() async {
    setState(() {
      isWorking = true;
    });
    var tempUser = await FirebaseAuth.instance.getUser();
    setState(() {
      user = tempUser;
    });
    setState(() {
      isWorking = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setup();
  }

  @override
  Widget build(context) {
    double total = 0;
    for (Orders o in widget.Order) {
      total += double.parse(o.SellingPrice) * double.parse(o.Quantity);
    }
    if (!isWorking) {
      return AlertDialog(
          actions: [TextButton(onPressed: Upload, child: const Text("upload"))],
          title: Text("Checking..."),
          content: SingleChildScrollView(
            child: Column(
              children: [
                Text("Shopname : ${widget.Shopname}"),
                Text(
                    "Order by : ${user.displayName == null ? user.email : user.displayName}"),
                SizedBox(
                  height: 15,
                ),
                DataTable(columns: [
                  DataColumn(label: Text("Name")),
                  DataColumn(label: Text("S.P")),
                  DataColumn(label: Text("Quantity")),
                  DataColumn(label: Text("FREE"))
                ], rows: [
                  ...widget.Order.map((e) => DataRow(
                          onLongPress: () {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                        actions: [
                                          IconButton(
                                              onPressed: () {
                                                if (spkey.currentState!
                                                    .validate()) {
                                                  spkey.currentState!.save();
                                                  Navigator.pop(context);
                                                }
                                              },
                                              icon: Icon(Icons
                                                  .currency_exchange_rounded))
                                        ],
                                        title: Text("Changing..."),
                                        content: Form(
                                          key: spkey,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              TextFormField(
                                                decoration: InputDecoration(
                                                    label:
                                                        Text("Selling Price")),
                                                keyboardType:
                                                    TextInputType.number,
                                                validator: (value) {
                                                  if (double.tryParse(value!) ==
                                                      null) {
                                                    return "Enter a valid Selling price";
                                                  }

                                                  return null;
                                                },
                                                onSaved: (values) {
                                                  if (double.parse(values!) !=
                                                      0)
                                                    setState(() {
                                                      e.SellingPrice = values!;
                                                    });
                                                },
                                              ),
                                              TextFormField(
                                                decoration: InputDecoration(
                                                    label: Text("Quantity")),
                                                keyboardType:
                                                    TextInputType.number,
                                                validator: (value) {
                                                  return null;
                                                },
                                                onSaved: (values) {
                                                  if (values != null &&
                                                      !values.isEmpty) {
                                                    setState(() {
                                                      e.Quantity = values!;
                                                    });
                                                  }
                                                },
                                              ),
                                              TextFormField(
                                                decoration: InputDecoration(
                                                    label: Text("FREE")),
                                                keyboardType:
                                                    TextInputType.number,
                                                validator: (value) {
                                                  return null;
                                                },
                                                onSaved: (values) {
                                                  if (values != null &&
                                                      !values.isEmpty) {
                                                    setState(() {
                                                      e.Free = values!;
                                                    });
                                                  }
                                                },
                                              )
                                            ],
                                          ),
                                        )));
                          },
                          cells: [
                            DataCell(Text(
                              e.Products,
                              style: TextStyle(
                                  fontSize: 11, fontWeight: FontWeight.bold),
                            )),
                            DataCell(Text(e.SellingPrice)),
                            DataCell(Text(e.Quantity)),
                            DataCell(Text(e.Free)),
                          ]))
                ]),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Total :",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(total.toString())
                  ],
                )
              ],
            ),
          ));
    }
    return Center(child: CircularProgressIndicator());
  }
}