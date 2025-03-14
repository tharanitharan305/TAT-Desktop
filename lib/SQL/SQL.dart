import 'package:firedart/generated/google/protobuf/timestamp.pb.dart';

import '../Products/model/Product.dart';
import '../Widgets/Orders.dart';

class SQL {
  SQL(
      {required this.items,
      required this.Shopname,
      required this.useremail,
      required this.timestamp,
      required this.total,
      required this.Date,
      required this.location,
      required this.phno,
      required this.uid});
  List<Product> items;
  String Date;
  String Shopname;
  String useremail;
  DateTime timestamp;
  String total;
  String location;
  String phno;
  String uid;
  String itemsToString() {
    String order = '';
    for (Product o in items) {
      // order +=
      //     "${o.product_name};${o.quantity};${o.free};${o.selling_price};${o.mrp}";
    }
    return order;
  }

  Map<String, dynamic> toMap() {
    return {
      'Date': Date,
      "ShopName": Shopname,
      "useremail": useremail,
      "timestamp": timestamp.toIso8601String(),
      "orders": itemsToString(),
      "total": total,
      "location": location,
      "phno": phno,
      'uid': uid
    };
  }
}
