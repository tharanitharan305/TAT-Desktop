import 'package:firedart/auth/firebase_auth.dart';
import 'package:firedart/firestore/firestore.dart';
import 'package:firedart/generated/google/protobuf/timestamp.pb.dart';
import 'package:get/get.dart';
import 'package:tat_win/Screens/Employees.dart';
import 'package:uuid/uuid.dart';

import '../Widgets/DateTime.dart';
import '../Widgets/Orders.dart';
import '../Widgets/getAttendaceSheet.dart';

class NewOrder {
  void putOrder(Set<Orders> order, String ShopName, String Locations,String phno) async {
    final user = await FirebaseAuth.instance.getUser();
    double total = 0;
    Uuid uuid = Uuid();
    for (Orders o in order) {
      total += double.parse(o.SellingPrice) * double.parse(o.Quantity);
    }

    // Convert order items to a List<String>
    List<String> orderList = order
        .map((e) {
          String quantity = e.Quantity.toString();
          if (quantity.endsWith("0")) return "";
          return "${e.Products}-${e.SellingPrice}-${e.Quantity}-${e.Free}-${e.MRP};";
        })
        .where((element) => element != null)
        .toList();
    var uid = uuid.v4();
   await  Firestore.instance.collection(Locations).document(uid).set({
      'Date': DateTimeTat().GetDate(),
      'Ordered time': DateTime.now(),
      'Shopname': ShopName,
      'Ordered by': user.displayName == null ? user.email : user.displayName,
      'Orders': orderList, // Use the converted List<String>
      'Total': total.toString(),
      'uid': uid,
     "phno":phno
    });
    print("start");
    final useDet = await Firestore.instance
        .collection('Employees')
        .document(user.displayName!)
        .get();
    print("2");
    await Firestore.instance
        .collection('Employees')
        .document(user.displayName!)
        .update({'Sales': useDet['Sales'] + total});
    print("3");
    final userMondet1 = await Firestore.instance
        .collection('Employees')
        .document(user.displayName!)
        .collection(DateTime.now().year.toString())
        .document(DateTime.now().month.toString());
    print("4");
    if (await userMondet1.exists) {
      // final userMondet = await userMondet1.get();
      // print(userMondet['Mothly sales'] + 1);
      // await Firestore.instance
      //     .collection('Employees')
      //     .document(user.displayName!)
      //     .collection(DateTime.now().year.toString())
      //     .document(DateTime.now().month.toString())
      //     .update({'Mothly sales': userMondet['Mothly sales'] + total});
      // print("5");
      // final max = userMondet['Max Sale'];
      //if (max < total) {
      // await Firestore.instance
      //     .collection('Employees')
      //     .document(user.displayName!)
      //     .collection(DateTime.now().year.toString())
      //     .document(DateTime.now().month.toString())
      //     .update({'Max Sale Shop': ShopName, 'Max Sale': total});
      // print("6");
      // }
    }
    final shopDet = await Firestore.instance
        .collection(Locations + "Shops")
        .document(ShopName);
    final shoptotdet = await shopDet.get();
    final shoptot = shoptotdet["Total Balance"];
    shopDet.update({"Total Balance": shoptot + total});
    print("7");
    Get.back();
  }

  List<Orders> products1 = [];
  Future<List<Orders>> SetList(String Company) async {
    final v = await Firestore.instance.collection(Company).get();

    var products = v
        .map((e) => new Orders(
            Products: e["ProductName"],
            SellingPrice: e["Selling Price"],
            MRP: e["MRP"],
            Quantity: "0",
            Free: '0'))
        .toList();
    print(products[0].MRP);
    return products;
  }

  Future<List<Orders>> GetList(String Company) async {
    await SetList(Company);
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
