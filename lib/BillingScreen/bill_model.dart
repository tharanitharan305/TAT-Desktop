import 'dart:ffi';

import 'package:tat_windows/Widgets/Orders.dart';
import 'package:tat_windows/Widgets/Shops.dart';

import '../Products/model/Product.dart';

class Bill {
  final Shop shop;
  final Set<Product> orderList;
  final int billNumber;
  final DateTime dateTime;
  final String userName;
  final Double total;
  final String? uid;
  Bill(
      {required this.shop,
      required this.orderList,
      required this.billNumber,
      required this.dateTime,
      this.uid,
      required this.total,
      required this.userName});
}
