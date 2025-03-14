import 'package:firedart/auth/firebase_auth.dart';
import 'package:firedart/firestore/firestore.dart';
import 'package:firedart/generated/google/protobuf/timestamp.pb.dart';
import 'package:get/get.dart';

import 'package:uuid/uuid.dart';

import '../Products/model/Product.dart';
import '../Screens/Employees.dart';
import '../Widgets/DateTime.dart';
import '../Widgets/Orders.dart';
import '../Widgets/getAttendaceSheet.dart';

class NewOrder {
  void putOrder(
      Set<Order> order, String ShopName, String Locations, String phno) async {
    // final user = await FirebaseAuth.instance.getUser();
    // double total = 0;
    // Uuid uuid = Uuid();
    // for (NewProduct o in order) {
    //   total += double.parse(o.selling_price) * double.parse(o.quantity);
    // }
    //
    // // Convert order items to a List<String>
    // List<String> orderList = order
    //     .map((e) {
    //       String quantity = e.quantity.toString();
    //       if (quantity.endsWith("0")) return "";
    //       return "${e.product_name}-${e.selling_price}-${e.quantity}-${e.free}-${e.mrp};";
    //     })
    //     .where((element) => element != null)
    //     .toList();
    // var uid = uuid.v4();
    // await Firestore.instance.collection(Locations).document(uid).set({
    //   'Date': DateTimeTat().GetDate(),
    //   'Ordered time': DateTime.now(),
    //   'Shopname': ShopName,
    //   'Ordered by': user.displayName == null ? user.email : user.displayName,
    //   'Orders': orderList, // Use the converted List<String>
    //   'Total': total.roundToDouble().toString(),
    //   'uid': uid,
    //   "phno": phno
    // });
    // print("start");
    // final useDet = await Firestore.instance
    //     .collection('Employees')
    //     .document(user.displayName!)
    //     .get();
    // print("2");
    // await Firestore.instance
    //     .collection('Employees')
    //     .document(user.displayName!)
    //     .update({'Sales': useDet['Sales'] + total});
    // print("3");
    // final userMondet1 = await Firestore.instance
    //     .collection('Employees')
    //     .document(user.displayName!)
    //     .collection(DateTime.now().year.toString())
    //     .document(DateTime.now().month.toString());
    // print("4");
    // if (await userMondet1.exists) {
    //   // final userMondet = await userMondet1.get();
    //   // print(userMondet['Mothly sales'] + 1);
    //   // await Firestore.instance
    //   //     .collection('Employees')
    //   //     .document(user.displayName!)
    //   //     .collection(DateTime.now().year.toString())
    //   //     .document(DateTime.now().month.toString())
    //   //     .update({'Mothly sales': userMondet['Mothly sales'] + total});
    //   // print("5");
    //   // final max = userMondet['Max Sale'];
    //   //if (max < total) {
    //   // await Firestore.instance
    //   //     .collection('Employees')
    //   //     .document(user.displayName!)
    //   //     .collection(DateTime.now().year.toString())
    //   //     .document(DateTime.now().month.toString())
    //   //     .update({'Max Sale Shop': ShopName, 'Max Sale': total});
    //   // print("6");
    //   // }
    // }
    // final shopDet = await Firestore.instance
    //     .collection(Locations + "Shops")
    //     .document(ShopName);
    // final shoptotdet = await shopDet.get();
    // final shoptot = shoptotdet["Total Balance"];
    // shopDet.update({"Total Balance": shoptot + total});
    // print("7");
    // Get.back();
  }

  List<Product> products1 = [];
  Future<List<Product>?> getProductByCompany(String Company) async {
    final v = await Firestore.instance.collection(Company).get();
    if (v.isNotEmpty) {
      var products = v
          .map((e) => Product(
                sno: e["sno"] ?? 0,
                partNo: e["partNo"] ?? "",
                barcode: e["barcode"] ?? "",
                productName: e["productName"] ?? "",
                rack: e["rack"] ?? "",
                groupName: e["groupName"] ?? "",
                company: e["company"] ?? "",
                commodity: e["commodity"] ?? "",
                salesVat: e["salesVat"] ?? "",
                section: e["section"] ?? "",
                cPrice: (e["cPrice"] ?? 0.0).toDouble(),
                pPrice: (e["pPrice"] ?? 0.0).toDouble(),
                margin: (e["margin"] ?? 0.0).toDouble(),
                mrp: (e["MRP"] ?? 0.0).toDouble(),
                sPrice: (e["sPrice"] ?? 0.0).toDouble(),
                splPrice: (e["splPrice"] ?? 0.0).toDouble(),
                unit: e["unit"] ?? "",
                weight: (e["weight"] ?? 0.0).toDouble(),
                expiryDays: e["expiryDays"] ?? 0,
                godownTax: e["godownTax"] ?? "",
                supplier: e["supplier"] ?? "",
                discound: (e["discound"] ?? 0.0).toDouble(),
              ))
          .toList();

      print(products[0].mrp);
      return products;
    }
    return null;
  }

  Future<List<Product>> GetList(String Company) async {
    await getProductByCompany(Company);
    print(products1);
    return products1;
  }

  Future<void> updateAttendance(
      String userName, bool status, String email) async {
    await Firestore.instance
        .collection('Attendance')
        .document(email)
        .update({'status': status});
    if (status) {
      final list = await Firestore.instance
          .collection("Employees")
          .document(userName)
          .collection(DateTime.now().year.toString())
          .document(DateTime.now().month.toString())
          .get();
      Map map = list['Attendance Days'];
      map.update(DateTime.now().day.toString(), (value) => status);
      // print(map);
      if (list != null) {
        print(map);
        print("Hai");
        await Firestore.instance
            .collection("Employees")
            .document(userName)
            .collection(DateTime.now().year.toString())
            .document(DateTime.now().month.toString())
            .update({
          '`Attendance Days`': map,
        });
        print(map);
      } else {
        await Firestore.instance
            .collection("Employees")
            .document(userName)
            .collection(DateTime.now().year.toString())
            .document(DateTime.now().month.toString())
            .set({
          'Attendance Days': AttendanceSheet()
              .getAttendanceSheet(DateTime.now().month, DateTime.now().year),
          "Mothly sales": 0.0,
          "Days of Present": 0,
          "Max sale": 0.0,
          "Max Sale Shop": "",
        });
      }
    }
  }

  SetEmployee(String userName) async {
    await Firestore.instance
        .collection("Employees")
        .document(userName)
        .collection(DateTime.now().year.toString())
        .document(DateTime.now().month.toString())
        .set({
      'Attendance Days': AttendanceSheet()
          .getAttendanceSheet(DateTime.now().month, DateTime.now().year),
      "Mothly sales": 0.0,
      "Days of Present": 0,
      "Max sale": 0.0,
      "Max Sale Shop": "",
    });
  }

  Future<Employe> getEmployee(
      String UserName, String month, String year) async {
    Employe employe;
    final overAllEmployeBase = await Firestore.instance
        .collection('Employees')
        .document(UserName)
        .get();
    final monthlyEmployeBase = await Firestore.instance
        .collection('Employees')
        .document(UserName)
        .collection(year)
        .document(month)
        .get();
    employe = Employe(
        email: overAllEmployeBase['email'],
        name: overAllEmployeBase['UserName'],
        daysOfPresent: monthlyEmployeBase['Attendance Days'],
        monthlyMaxSale: monthlyEmployeBase['Max Sale'],
        monthlyMaxSaleShop: monthlyEmployeBase['Max Sale Shop'],
        monthlySales: monthlyEmployeBase['Mothly sales'],
        noOfDaysPresent: monthlyEmployeBase['Days of Present'],
        overAllSales: overAllEmployeBase['Sales'],
        job: overAllEmployeBase['Job']);
    return employe;
  }

  Future<void> deleteOrder(String uid, String location) async {
    print("g");
    await Firestore.instance.collection(location).document(uid).delete();
  }

  void getOrder(String location, String date) async {
    final doc = await Firestore.instance
        .collection(location)
        .document("1ba77a66-8fab-477a-bb5f-fb25f9ec338e")
        .update({"Total": 70});
  }
}

Future<List<Product>> getAllProducts(List<String> companies) async {
  List<Product> products = [];
  for (String Company in companies) {
    if (Company != "--select--") {
      final v = await Firestore.instance.collection(Company).get();

      products.addAll([
        ...v.map((e) => Product(
              sno: e["sno"] ?? 0,
              partNo: e["partNo"] ?? "",
              barcode: e["barcode"] ?? "",
              productName: e["ProductName"] ?? "",
              rack: e["rack"] ?? "",
              groupName: e["groupName"] ?? "",
              company: e["company"] ?? "",
              commodity: e["commodity"] ?? "",
              salesVat: e["salesVat"] ?? "",
              section: e["section"] ?? "",
              cPrice: e["cPrice"] ?? 0.0,
              pPrice: e["pPrice"] ?? 0.0,
              margin: e["margin"] ?? 0.0,
              mrp: e["mrp"] ?? 0.0,
              sPrice: e["sPrice"] ?? 0.0,
              splPrice: e["splPrice"] ?? 0.0,
              unit: e["unit"] ?? "",
              weight: e["weight"] ?? 0.0,
              expiryDays: e["expiryDays"] ?? 0,
              godownTax: e["godownTax"] ?? "",
              supplier: e["supplier"] ?? "",
              discound: e["discound"] ?? 0.0,
            ))
      ]);
    }
  }
  return products;
}
