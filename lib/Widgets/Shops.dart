import 'package:firedart/firestore/firestore.dart';

import 'Shops.dart';

class Shop {
  Shop(
      {required this.shopName,
      required this.phno,
      required this.balance,
      required this.purchase});
  String shopName;
  String phno;
  String balance;
  String purchase;
}

class Shops {
  Future<Set<Shop>> getShops(String Locations) async {
    Set<Shop> shops;
    final list = await Firestore.instance
        .collection(Locations + "Shops")
        .orderBy("Time")
        .get();
    shops = list
        .map((e) => Shop(
            shopName: e["Shop Name"],
            phno: e["Phone Number"],
            balance: e["Total Balance"].toString(),
            purchase: e["Total Balance"].toString()))
        .toSet();
    return shops;
  }
}
