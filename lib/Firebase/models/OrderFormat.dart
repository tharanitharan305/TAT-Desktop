import 'dart:developer';


import '../../Widgets/Orders.dart';
import '../../Widgets/Shops.dart';
import 'User.dart';

class FirebaseOrder {
  List<Order> orders;
  Shop shop;
  String beat;
  String uid;
  double total;
  TatUser user;
  String date;
  FirebaseOrder({
    required this.user,
    required this.orders, // Accepting List<Order>
    required this.shop,
    required this.beat,
    required this.total,
    required this.uid,
    required this.date,
  }); // Converting to List<Map>
  Map<String, dynamic> toMap() {
    log("Generating Map From Firebase Orders");
    Map<String ,dynamic> map={"User": user.toMap(),
      "Beat": beat,
      "Uid": uid,
      "Total": total,
      "Shop": shop.toMap(),
      "Orders": orders.map((e) => e.toMap(),).toList(),
      "Date": date};
    return {"User": user.toMap(),
      "Beat": beat,
      "Uid": uid,
      "Total": total,
      "Shop": shop.toMap(),
      "Orders": orders.map((e) => e.toMap(),).toList(),
      "Date": date};
  }

  factory FirebaseOrder.fromMap(Map<String, dynamic> map) {
    log("🔍 Converting FirebaseOrder from map: $map");

    return FirebaseOrder(
      user: TatUser.fromMap(map["User"] ?? {}),
      orders: (map["Orders"] != null) // ✅ Handle null case
          ? (map["Orders"] as List<dynamic>).map((e) {
              log("🛠️ Processing order entry: $e");
              return Order.fromMap(e);
            }).toList()
          : [], // If "Orders" is null, return an empty list
      shop: Shop.fromMap(map["Shop"] ?? {}),
      beat: map["Beat"] ?? "",
      total: (map["Total"] ?? 0.0).toDouble(),
      uid: map["Uid"] ?? "",
      date: map["Date"] ?? "",
    );
  }
}
