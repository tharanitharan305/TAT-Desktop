import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tat_win/Firebase/NewOrder.dart';

import 'Orders.dart';

class OrderViewCard extends StatelessWidget {
  OrderViewCard(
      {super.key,
      required this.items,
      required this.Shopname,
      required this.useremail,
      required this.timestamp,
      required this.total,
      required this.location,
      required this.uid});
  List<Orders> items;
  //var items;
  String Shopname;
  String useremail;
  DateTime timestamp;
  String total;
  List<Orders> fromBase = [];
  String location;
  String uid;
  void delete() {
    Get.dialog(AlertDialog(
      title: Text("Delete"),
      content: Text('Are You Sure to detlete $Shopname Order'),
      actions: [
        TextButton(
            onPressed: () async {
              Get.back();
              Get.dialog(Center(
                child: CircularProgressIndicator(),
              ));
              await NewOrder().deleteOrder(uid, location);
              Get.back();
            },
            child: Text('YES')),
        TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text('NO'))
      ],
    ));
  }

  @override
  Widget build(context) {
    return Container(
        decoration: BoxDecoration(
            color: Color.fromRGBO(222, 217, 217, 1),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.all(10),
        width: double.infinity,
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(child: Text("Shopname : ${Shopname}")),
                Spacer(),
                Expanded(child: Text("Order by : ${useremail}")),
                IconButton(onPressed: delete, icon: Icon(Icons.delete_rounded))
              ],
            ),
            // Row(
            //   children: [
            //     Spacer(),
            //     Expanded(child: Text("Order by : ${useremail}")),
            //   ],
            // ),
            SizedBox(
              height: 15,
            ),
            DataTable(columns: [
              DataColumn(label: Text("Name")),
              DataColumn(label: Text("S.P")),
              DataColumn(label: Text("Quantity")),
              DataColumn(label: Text("FREE")),
            ], rows: [
              ...items.map((e) => DataRow(cells: [
                    DataCell(Text(
                      e.Products,
                      style:
                          TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
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
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Time:",
                  style: TextStyle(fontSize: 10),
                ),
                Text(
                  timestamp.toString(),
                  style: TextStyle(fontSize: 10),
                )
              ],
            ),
          ],
        ));
  }
}
