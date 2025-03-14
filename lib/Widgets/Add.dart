// import 'package:firedart/firestore/firestore.dart';
// import 'package:firedart/generated/google/protobuf/timestamp.pb.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:tat_windows/Widgets/DateTime.dart';
// import '../Screens/splashScreen.dart';
// import 'Orders.dart';
// import 'comapnies.dart';
//
// class AddProduct extends StatefulWidget {
//   const AddProduct({super.key});
//
//   State<AddProduct> createState() => _AddProductstate();
// }
//
// class _AddProductstate extends State<AddProduct> {
//   String company = "--select--";
//   String product = "";
//   String SellingPrice = "";
//   String MRP = "";
//   late NewProduct o;
//   final key = GlobalKey<FormState>();
//   bool status = false;
//   bool uploadStatus = false;
//   Set<String> companies = {};
//   void upload() async {
//     try {
//       setState(() {
//         uploadStatus = true;
//       });
//       await Firestore.instance.collection(company).document(product).set(
//         {
//           "ProductName": product,
//           "Selling Price": SellingPrice,
//           "MRP": MRP,
//           "Upload Time": DateTimeTat().GetDate()
//         },
//       );
//       setState(() {
//         uploadStatus = false;
//       });
//       Get.snackbar("Sucess", "$product added Sucessfully",
//           icon: Icon(Icons.done_outline), duration: Duration(seconds: 3));
//     } catch (e) {
//       ScaffoldMessenger.of(context).clearSnackBars();
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text(e.toString())));
//     }
//   }
//
//   SetCompany() async {
//     final temcomp = await Companies().GetCompany();
//     setState(() {
//       companies = temcomp;
//     });
//   }
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//
//     SetCompany();
//   }
//
//   Widget build(context) {
//     return Padding(
//       padding: EdgeInsets.all(40),
//       child: Container(
//         width: double.infinity,
//         child: Form(
//           key: key,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // if (widget.Status == "p")
//               DropdownButton(
//                   elevation: 50,
//                   autofocus: true,
//                   dropdownColor: Theme.of(context).colorScheme.primaryContainer,
//                   borderRadius: BorderRadius.circular(20),
//                   value: company,
//                   items: companies
//                       .map((e) => DropdownMenuItem(
//                             value: e,
//                             key: UniqueKey(),
//                             child: Text(e),
//                           ))
//                       .toList(),
//                   onChanged: (values) {
//                     setState(() {
//                       company = values!;
//                     });
//                   }),
//               if (company != "--select--")
//                 TextFormField(
//                   decoration: InputDecoration(labelText: "product"),
//                   validator: (value) {
//                     if (value!.isEmpty || value.length < 3)
//                       return "Enter a valid shopname";
//                   },
//                   onChanged: (values) {
//                     setState(() {
//                       product = values!;
//                     });
//                   },
//                   onSaved: (values) {
//                     setState(() {
//                       product = values!;
//                     });
//                   },
//                 ),
//               if (product != null && product.length > 3 && !product.isEmpty)
//                 TextFormField(
//                   keyboardType: TextInputType.number,
//                   decoration: InputDecoration(labelText: "Selling Price"),
//                   validator: (values) {
//                     if (values!.isEmpty) return "Enter Selling price";
//                     double? sp = double.tryParse(values!);
//                     if (sp == null) return "enter a valid Price";
//                   },
//                   onChanged: (values) {
//                     setState(() {
//                       SellingPrice = values!;
//                     });
//                   },
//                   onSaved: (values) {
//                     setState(() {
//                       SellingPrice = values!;
//                     });
//                   },
//                 ),
//
//               if (SellingPrice != null && double.tryParse(SellingPrice) != null)
//                 TextFormField(
//                   keyboardType: TextInputType.number,
//                   decoration: InputDecoration(labelText: "MRP"),
//                   validator: (values) {
//                     if (values!.isEmpty) return "Enter Selling price";
//                     double? sp = double.tryParse(values!);
//                     if (sp == null) return "enter a valid Price";
//                   },
//                   onChanged: (values) {
//                     setState(() {
//                       MRP = values!;
//                     });
//                   },
//                   onSaved: (values) {
//                     setState(() {
//                       MRP = values!;
//                     });
//                   },
//                 ),
//               SizedBox(
//                 height: 20,
//               ),
//               if (double.tryParse(MRP) != null)
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     if (uploadStatus) CircularProgressIndicator(),
//                     if (!uploadStatus)
//                       ElevatedButton(
//                         onPressed: upload,
//                         child: Text('Upload'),
//                         style: ElevatedButton.styleFrom(
//                             elevation: 10,
//                             backgroundColor:
//                                 Theme.of(context).colorScheme.primaryContainer),
//                       )
//                   ],
//                 )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
