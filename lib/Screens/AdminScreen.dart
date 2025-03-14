// import 'dart:io';
//
// import 'package:firedart/firedart.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:hive/hive.dart';
// import 'package:tat_windows/Screens/splashScreen.dart';
// import 'package:tat_windows/Widgets/SilentPrinting.dart';
//
// import '../Beat/Areas.dart';
// import '../Firebase/NewOrder.dart';
// import '../PDF/PDF.dart';
// import '../PDF/PdfGenerator.dart';
// import '../Products/model/Product.dart';
// import '../SQL/SQL.dart';
// import '../Widgets/Areas.dart';
// import '../Widgets/DateTime.dart';
// import '../Widgets/Info.dart';
// import '../Widgets/OrderFormat.dart';
// import '../Widgets/Orders.dart';
// import '../Widgets/OrderviewCard.dart';
// import '../billnumber.dart';
//
// class AdminScreen extends StatefulWidget {
//   const AdminScreen({super.key});
//
//   @override
//   State<AdminScreen> createState() {
//     return _AdminScreen();
//   }
// }
//
// class _AdminScreen extends State<AdminScreen> {
//   bool isPrinting = false;
//   String DropDownView = "--select--";
//   String Location = "--select--";
//   List<Order> fromBase = [];
//   List<String> send = [];
//   String Today = DateTimeTat().GetDate();
//   String dayTotal = "0";
//   bool isFullpage = false;
//   List<String> Time = [
//     DateTimeTat().GetpreDate(0),
//     DateTimeTat().GetpreDate(1),
//     DateTimeTat().GetpreDate(2),
//     DateTimeTat().GetpreDate(3),
//     DateTimeTat().GetpreDate(4),
//     DateTimeTat().GetpreDate(5),
//     DateTimeTat().GetpreDate(6),
//     DateTimeTat().GetpreDate(7),
//     DateTimeTat().GetpreDate(8),
//   ];
//   Set<String> locations = {};
//   SetLocations() async {
//     final temloc = await Areas().GetLocations();
//     //print(temloc);
//     setState(() {
//       locations = temloc;
//     });
//   }
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     SetLocations();
//   }
//
//   Future<bool> checkDupeBill(PDF pdf) async {
//     final isDupeBill = await Hive.openBox('appSettings').then((box) async {
//       String tatPath;
//       tatPath = box.getAt(0)['tat path'];
//       final billFolder = Directory(
//           '$tatPath/Bills/${pdf.location}/${pdf.Shopname.trim()}/${pdf.Date}.pdf');
//       //print(billFolder);
//       final file = File(billFolder.path);
//       return file.existsSync();
//     });
//     return isDupeBill;
//   }
//
//   void printPdf(String pdfPath) async {
//     if (await File(pdfPath).exists()) {
//       try {
//         // Execute the command to print the PDF
//         final result = await Process.run(
//           'cmd',
//           ['/c', 'start', '/min', 'AcroRd32.exe', '/t', pdfPath, 'PrinterName'],
//         );
//
//         if (result.exitCode == 0) {
//           print("PDF sent to printer successfully!");
//         } else {
//           print("Failed to print PDF: ${result.stderr}");
//         }
//       } catch (e) {
//         print("Error occurred while trying to print PDF: $e");
//       }
//     } else {
//       print("The PDF file does not exist at $pdfPath.");
//     }
//   }
//
//   generatingFullBills() async {
//     Get.dialog(Center(child: CircularProgressIndicator()));
//     var list = await Firestore.instance
//         .collection(Location)
//         .where('Date', isEqualTo: Today)
//         .get();
//     if (list.isEmpty || list == null || list.length <= 0) {
//       Get.snackbar("No bills", "There are no Bills $Location in $Today date",
//           duration: Duration(seconds: 5));
//       return;
//     } else {
//       for (int i = 0; i < list.length; i++) {
//         var e = list[i];
//         int billNumber = await getbillNumber();
//         var filteredOrder = "";
//         var order = e['Orders'].toString().split(",");
//         // OrderFormat().ViewFormat(order);
//         for (int j = 0; j < order.length; j++) {
//           if (!order[j].endsWith('null')) {
//             filteredOrder += order[j];
//           }
//         }
//         send = filteredOrder.split(";");
//         fromBase = OrderFormat().ViewFormat(send);
//
//         PDF pdf = PDF(
//           phno: e["phno"] != null ? e["phno"] : "NO PHONE NUM",
//           Date: e['Date'],
//           items: fromBase,
//           Shopname: e['Shopname'],
//           useremail: e['Ordered by'],
//           timestamp: e['Ordered time'],
//           total: e['Total'],
//           location: Location,
//           billNumber: billNumber,
//         );
//         if (await checkDupeBill(pdf)) {
//           Get.back();
//           bool decission = await Get.dialog(
//               barrierDismissible: false,
//               AlertDialog(
//                 title: Text("DUPLICATE BILL FOUND"),
//                 content: Text(
//                     "The bill for ${pdf.Shopname} with bill number and date of  ${pdf.billNumber} and ${pdf.Date} was billed already do you want to make a new bill with new bill number ?"),
//                 actions: [
//                   TextButton(
//                       onPressed: () {
//                         Navigator.of(context).pop(true);
//                       },
//                       child: Text("YES")),
//                   TextButton(
//                       onPressed: () {
//                         Navigator.of(context).pop(false);
//                       },
//                       child: Text("NO, Skip"))
//                 ],
//               ));
//           if (decission) {
//             String path = await PdfGenerator(
//               pdf: pdf,
//               isFullPage: false,
//             ).generatePdf();
//             upDateBillNumber(billNumber);
//             Get.back();
//             // printPdf(path);
//           } else {
//             continue;
//           }
//         } else {
//           PdfGenerator(
//             pdf: pdf,
//             isFullPage: false,
//           ).generatePdf();
//           upDateBillNumber(billNumber);
//           Get.back();
//         }
//         Get.dialog(Center(
//             child: AlertDialog(
//           content: Text("printing ${pdf.Shopname} bill"),
//         )));
//         //SQL TEST Off
//         // String query = await GenerateSql(pdf);
//         // await saveSQLToFile(query);
//         // saveSQLToFile(query);
//
//         //print(await DataBaseHelper().getDataBasePath());
//         //DatabaseHelper().insertLocation(sql.toMap());
//         //await DatabaseHelper().insertLocationWithOrders(sql);
//         //DatabaseHelper().printDatabasePath();
//         //await DatabaseHelper().printLocationTable();
//         //await DatabaseHelper().printOrdersTable();
//       }
//     }
//     Get.back();
//   }
//
//   // Widget build(context) {
//   //   return TextButton(onPressed: generate, child: Text("press"));
//   // }
//   @override
//   Widget build(context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: Color.fromRGBO(222, 217, 217, 1),
//           shape: const RoundedRectangleBorder(),
//           actions: [
//             IconButton(
//                 onPressed: generatingFullBills,
//                 icon: Icon(Icons.print_rounded)),
//             DropdownButton(
//                 elevation: 50,
//                 autofocus: true,
//                 dropdownColor: Color.fromRGBO(222, 217, 217, 1),
//                 borderRadius: BorderRadius.circular(20),
//                 value: DropDownView,
//                 items: locations
//                     .map((e) => DropdownMenuItem(
//                           value: e,
//                           key: UniqueKey(),
//                           child: Text(e),
//                         ))
//                     .toList(),
//                 onChanged: (values) {
//                   setState(() {
//                     DropDownView = values!;
//                     Location = values.toString();
//                   });
//                 }),
//             SizedBox(
//               width: 20,
//             ),
//             DropdownButton(
//                 elevation: 50,
//                 autofocus: true,
//                 dropdownColor: Color.fromRGBO(222, 217, 217, 1),
//                 borderRadius: BorderRadius.circular(20),
//                 value: Today,
//                 items: Time.map((e) => DropdownMenuItem(
//                       value: e,
//                       key: UniqueKey(),
//                       child: Text(e),
//                     )).toList(),
//                 onChanged: (values) {
//                   setState(() {
//                     Today = values!;
//                   });
//                 })
//           ],
//         ),
//         body: StreamBuilder(
//           stream: Firestore.instance
//               .collection(Location)
//               .where('Date', isEqualTo: Today)
//               .get()
//               .asStream(),
//           builder: (context, OrderSnapCuts) {
//             NewOrder().getOrder(Location, Today);
//             if (OrderSnapCuts.connectionState == ConnectionState.waiting) {
//               return Center(
//                   child: SplashScreen(
//                 height: 50,
//                 width: 50,
//               ));
//             }
//             if (!OrderSnapCuts.hasData || OrderSnapCuts.data!.isEmpty) {
//               return Center(
//                 child: Text('No Orders Found at $Location'),
//               );
//             }
//             if (OrderSnapCuts.hasError) {
//               return const Center(
//                   child: Text(
//                       'An Error Occured Try To Restart or Contact +91 9787874607'));
//             }
//             final RecivedOrders = OrderSnapCuts.data!;
//             //print(RecivedOrders);
//             return ListView.builder(
//               itemCount: RecivedOrders.length,
//               itemBuilder: (context, index) {
//                 var filteredOrder = "";
//                 var order =
//                     RecivedOrders[index]['Orders'].toString().split(",");
//                 // OrderFormat().ViewFormat(order);
//                 for (int i = 0; i < order.length; i++) {
//                   if (!order[i].endsWith('null')) {
//                     filteredOrder += order[i];
//                   }
//                 }
//                 send = filteredOrder.split(";");
//                 fromBase = OrderFormat().ViewFormat(send);
//
//                 return Column(
//                   children: [
//                     GestureDetector(
//                       onLongPress: () async {
//                         PDF pdf = PDF(
//                           Date: RecivedOrders[index]['Date'],
//                           items: fromBase,
//                           Shopname: RecivedOrders[index]['Shopname'],
//                           useremail: RecivedOrders[index]['Ordered by'],
//                           timestamp: RecivedOrders[index]['Ordered time'],
//                           total: RecivedOrders[index]['Total'],
//                           location: Location,
//                           phno: RecivedOrders[index]["phno"] != null
//                               ? RecivedOrders[index]["phno"]
//                               : "",
//                           billNumber: await getbillNumber(),
//                         );
//                         showDialog(
//                           context: context,
//                           builder: (context) => AlertDialog(
//                             title: Text("Conformation.."),
//                             content: Text("Confirm to get bill on full A4"),
//                             actions: [
//                               TextButton(
//                                   onPressed: () {
//                                     Navigator.pop(context);
//                                   },
//                                   child: Text('Cancel')),
//                               TextButton(
//                                   onPressed: () async {
//                                     PdfGenerator(
//                                       isFullPage: true,
//                                       pdf: pdf,
//                                     ).generatePdf();
//                                     upDateBillNumber(await getbillNumber());
//                                     Navigator.pop(context);
//                                   },
//                                   child: Text("Get Bill"))
//                             ],
//                           ),
//                         );
//                       },
//                       child: OrderViewCard(
//                         items: fromBase,
//                         Shopname: RecivedOrders[index]['Shopname'],
//                         useremail: RecivedOrders[index]['Ordered by'],
//                         timestamp: RecivedOrders[index]['Ordered time'],
//                         total: RecivedOrders[index]['Total'],
//                         location: Location,
//                         uid: RecivedOrders[index]['uid'],
//                         phno: RecivedOrders[index]["phno"] != null
//                             ? RecivedOrders[index]["phno"]
//                             : "NO PHONE NUM",
//                         date: RecivedOrders[index]['Date'],
//                       ),
//                     )
//                   ],
//                 );
//               },
//             );
//           },
//         ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: () {
//             showModalBottomSheet(
//               context: context,
//               builder: (context) {
//                 return Info(
//                   location: Location,
//                   date: Today,
//                 );
//               },
//             );
//           },
//           child: Icon(Icons.currency_rupee),
//         ),
//       ),
//     );
//   }
// }
