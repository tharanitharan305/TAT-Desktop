import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Firebase/NewOrder.dart';

import '../Firebase/models/OrderFormat.dart';

class OrderViewCard extends StatelessWidget {
  final FirebaseOrder order;

  OrderViewCard({super.key, required this.order});

  void delete() {
    Get.dialog(
      AlertDialog(
        title: const Text("Delete"),
        content: Text('Are you sure you want to delete the order for ${order.shop.name}?'),
        actions: [
          TextButton(
            onPressed: () async {
              Get.back();
              Get.dialog(const Center(child: CircularProgressIndicator()));
              await NewOrder().deleteOrder(order.uid, order.beat);
              Get.back();
            },
            child: const Text('YES'),
          ),
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('NO'),
          ),
        ],
      ),
    );
  }

  void _sendMessage() {
    var messageText = "Products     qty     free    S.price    MRP";
    for (var e in order.orders) {
      messageText += "\n${e.product.productName}    ${e.qty}    ${e.free}    ${e.product.sPrice}    ${e.product.mrp}";
    }

    Get.dialog(
      AlertDialog(
        icon: const Icon(Icons.sms_rounded),
        actions: [
          TextButton(onPressed: () {}, child: const Text("Send")),
          TextButton(onPressed: () => Get.back(), child: const Text("No")),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(children: [Expanded(child: Text("Shop: ${order.shop.name}"))]),
          Row(
            children: [
              const Spacer(),
              Expanded(child: Text("Order by: ${order.user.userEmail}")),
              IconButton(onPressed: delete, icon: const Icon(Icons.delete_rounded)),
            ],
          ),
          const SizedBox(height: 15),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: const [
                DataColumn(label: Text("Name")),
                DataColumn(label: Text("s.p")),
                DataColumn(label: Text("Quantity")),
                DataColumn(label: Text("FREE")),
                DataColumn(label: Text("MRP")),
                DataColumn(label: Text("Discount")),
              ],
              rows: order.orders.map((e) {
                return DataRow(cells: [
                  DataCell(Text(e.product.productName, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold))),
                  DataCell(Text(e.product.sPrice.toString())),
                  DataCell(Text(e.qty.toString())),
                  DataCell(Text(e.free.toString())),
                  DataCell(Text(e.product.mrp.toString())),
                  DataCell(Text("${e.product.discound}%")),
                ]);
              }).toList(),
            ),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Spacer(),
              const Text("Time:", style: TextStyle(fontSize: 10)),
              Text(order.date, style: const TextStyle(fontSize: 10)),
            ],
          ),
        ],
      ),
    );
  }
}
