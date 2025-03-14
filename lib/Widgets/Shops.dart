// import 'package:firedart/firestore/firestore.dart';
//
// import 'Shops.dart';
//
// class Shop {
//   Shop(
//       {required this.shopName,
//       required this.phno,
//       required this.balance,
//       required this.purchase});
//   String shopName;
//   String phno;
//   String balance;
//   String purchase;
//   factory Shop.fromMap(Map<String, dynamic> map) {
//     return Shop(
//       map["name"] ?? "Unknown",
//       (map["balance"] ?? 0).toDouble(),
//       (map["total"] ?? 0).toDouble(),
//       map["time"] ?? "",
//       map["phno"] ?? "Not Available",
//       map["lat"] ?? "Location Not Added",
//       map["long"] ?? "Location Not Added",
//       map["street"] ?? "Location Not Added",
//       map["area"] ?? "Location Not Added",
//       map["district"] ?? "Location Not Added",
//       map["pin"] ?? "Location Not Added",
//     );
//   }
// }
//
//
//   Future<Set<Shop>> getShops(String Locations) async {
//     Set<Shop> shops;
//     final list = await Firestore.instance
//         .collection(Locations + "Shops")
//         .orderBy("Time")
//         .get();
//     shops = list
//         .map((e) => Shop(
//             shopName: e["Shop Name"],
//             phno: e["Phone Number"],
//             balance: e["Total Balance"].toString(),
//             purchase: e["Total Balance"].toString()))
//         .toSet();
//     return shops;
//   }


import 'package:firedart/firestore/firestore.dart';

class Shop {
  Shop(this.name, this.balance, this.total, this.time, this.phno, this.lat,
      this.long, this.street, this.area, this.district, this.pin);
  String name = "";
  String time = "";
  double balance = 0;
  double total = 0;
  String phno = "";
  String lat = "";
  String long = "";
  String street = "";
  String area = "";
  String district = "";
  String pin = "";
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'time': time,
      'balance': balance,
      'total': total,
      'phno': phno,
      'lat': lat,
      'long': long,
      'street': street,
      'area': area,
      'district': district,
      'pin': pin,
    };
  }

  factory Shop.fromMap(Map<String, dynamic> map) {
    return Shop(
      map["name"] ?? "Unknown",
      (map["balance"] ?? 0).toDouble(),
      (map["total"] ?? 0).toDouble(),
      map["time"] ?? "",
      map["phno"] ?? "Not Available",
      map["lat"] ?? "Location Not Added",
      map["long"] ?? "Location Not Added",
      map["street"] ?? "Location Not Added",
      map["area"] ?? "Location Not Added",
      map["district"] ?? "Location Not Added",
      map["pin"] ?? "Location Not Added",
    );
  }
}

Future<Set<String>> getShops(String Locations) async {
  Set<String> Shops = {"--select--"};
  final list = await Firestore.instance
      .collection(Locations + "Shops")
      .orderBy("Time")
      .get();
  Shops.addAll(list
      .map((e) => e.map["Shop Name"].toString().toUpperCase())
      .toSet());
  return Shops;
}

Future<Set<Shop>> getShop(String location) async {
  Set<Shop> shop;
  final list = await Firestore.instance
      .collection(location + "Shops")
      .orderBy("Time")
      .get();
  shop = list
      .map((e) => Shop(
      e.map["Shop Name"],
      e.map["Total Balance"],
      e.map["Total Purchase"],
      e.map["Time"],
      e.map['Phone Number'],
      e.map["Lat"] ?? "location NOt added",
      e.map["Long"] ?? "location NOt added",
      e.map["Street"] ?? "location NOt added",
      e.map['Area'] ?? "location NOt added",
      e.map['District'] ?? "location NOt added",
      e.map['Pin'] ?? "location NOt added"))
      .toSet();
  shop.add(Shop("--select--", 0.0, 0.0, "", "", "", "", "", "", "", ""));
  return shop;
}
