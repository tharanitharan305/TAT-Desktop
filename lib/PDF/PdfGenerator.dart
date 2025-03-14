// import 'dart:ffi';
// import 'dart:io';
// //import 'dart:nativewrappers/_internal/vm/lib/core_patch.dart';
// //import 'dart:nativewrappers/_internal/vm/lib/core_patch.dart';
//
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
//
// import 'package:hive/hive.dart';
// import 'package:number_to_words/number_to_words.dart';
// import 'package:open_file/open_file.dart';
//
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:flutter/services.dart' show ByteData, Uint8List, rootBundle;
//
// import '../billnumber.dart';
// import 'PDF.dart';
//
// class PdfGenerator extends StatelessWidget {
//   PdfGenerator({super.key, required this.pdf, required this.isFullPage});
//   PDF pdf;
//   bool isFullPage;
//   Future<pw.Image> getImageFromAsset(String assetName) async {
//     final ByteData data = await rootBundle.load(assetName);
//     final Uint8List bytes = data.buffer.asUint8List();
//     return pw.Image(pw.MemoryImage(bytes), width: 70, height: 70);
//   }
//
//   double dis = 0;
//
//   Future<String> generatePdf() async {
//     final image = await getImageFromAsset(
//         'images/tatSymbolpdf.png'); // Change the asset path
//     final pdf1 = pw.Document();
//     final width = PdfPageFormat.a4.width;
//     final height =
//         isFullPage ? PdfPageFormat.a4.height : PdfPageFormat.a4.height / 2;
//     var i = 0;
//     pw.TextStyle textStyle = pw.TextStyle(fontSize: 10);
//     pdf1.addPage(
//       pw.Page(
//         margin: pw.EdgeInsets.all(1),
//         pageFormat: PdfPageFormat.a4,
//         build: (context) {
//           return pw.Container(
//             decoration: pw.BoxDecoration(
//                 border: pw.Border.all(color: PdfColors.black, width: 2)),
//             width: width,
//             height: height,
//             child: pw.Column(
//               children: [
//                 pw.Table(
//                   children: [
//                     pw.TableRow(
//                       decoration: pw.BoxDecoration(
//                           border: pw.Border.symmetric(
//                               vertical: pw.BorderSide(
//                                   width: 2, color: PdfColors.black),
//                               horizontal: pw.BorderSide(
//                                   width: 2, color: PdfColors.black))),
//                       children: [
//                         pw.Container(
//                           //color: PdfColors.black,
//
//                           width: width * 0.5,
//                           child: pw.Row(
//                             children: [
//                               image,
//                               pw.Column(
//                                   crossAxisAlignment:
//                                       pw.CrossAxisAlignment.start,
//                                   children: [
//                                     pw.Text("THARANI A TRADERS"),
//                                     pw.Text(
//                                         "69,Thiruvalluvar Nager 4th Cross,LNS post,"),
//                                     pw.Text("Karur-639002 , ph:7598241254"),
//                                     pw.Text("G-Pay:9626809103"),
//                                   ])
//                             ],
//                           ),
//                         ),
//                         pw.Container(
//                           padding: pw.EdgeInsets.all(10),
//                           decoration: pw.BoxDecoration(
//                               border: pw.Border.symmetric(
//                                   vertical: pw.BorderSide(width: 2))),
//                           width: width * 0.48,
//                           child: pw.Column(
//                             crossAxisAlignment: pw.CrossAxisAlignment.start,
//                             children: [
//                               pw.Text("TO:${pdf.Shopname}"),
//                               pw.Text("${pdf.location}"),
//                               pw.Text("Ph:${pdf.phno}"),
//                             ],
//                           ),
//                         )
//                       ],
//                     )
//                   ],
//                 ),
//                 pw.Container(
//                     decoration: pw.BoxDecoration(
//                         border: pw.Border.symmetric(
//                             horizontal: pw.BorderSide(width: 2))),
//                     padding: pw.EdgeInsets.all(8),
//                     width: width,
//                     child: pw.Row(children: [
//                       pw.Text("Bill No: ${pdf.billNumber}"),
//                       pw.Spacer(),
//                       pw.Text("Date:${pdf.Date}"),
//                       pw.Spacer(),
//                       pw.Column(children: [
//                         pw.Text("Acc.No.270002000000235, IFSC: IOBA0002700"),
//                         pw.Text("Bank : IOB, Branch: KARUR")
//                       ])
//                     ])),
//                 pw.Table(
//                     border: pw.TableBorder.all(color: PdfColors.grey),
//                     children: [
//                       pw.TableRow(children: [
//                         pw.Center(
//                           child: pw.Text("No", style: textStyle),
//                         ),
//                         pw.Center(
//                           child: pw.Text("Product", style: textStyle),
//                         ),
//                         pw.Center(
//                           child: pw.Text("FREE", style: textStyle),
//                         ),
//                         pw.Center(
//                           child: pw.Text("MRP", style: textStyle),
//                         ),
//                         pw.Center(
//                           child: pw.Text("QTY", style: textStyle),
//                         ),
//                         pw.Center(
//                           child: pw.Text("RATE", style: textStyle),
//                         ),
//                         pw.Center(
//                           child: pw.Text("DIS", style: textStyle),
//                         ),
//                         pw.Center(
//                           child: pw.Text("VAL", style: textStyle),
//                         ),
//                         pw.Center(
//                           child: pw.Text("AMOUNT", style: textStyle),
//                         ),
//                       ]),
//                       ...pdf.items.map(
//                         (e) {
//                           i++;
//                           return pw.TableRow(
//                             children: [
//                               pw.Center(
//                                 child: pw.Text(i.toString()),
//                               ),
//                               pw.Text(e.product_name, style: textStyle),
//                               pw.Center(
//                                 child: pw.Text(e.free, style: textStyle),
//                               ),
//                               pw.Center(
//                                 child: pw.Text(e.mrp, style: textStyle),
//                               ),
//                               pw.Center(
//                                 child: pw.Text(e.quantity, style: textStyle),
//                               ),
//                               pw.Center(
//                                 child:
//                                     pw.Text(e.selling_price, style: textStyle),
//                               ),
//                               pw.Center(
//                                 child: pw.Text("0"),
//                               ),
//                               pw.Center(
//                                 child: pw.Text("0"),
//                               ),
//                               pw.Center(
//                                 child: pw.Text((double.parse(e.quantity) *
//                                         double.parse(e.selling_price))
//                                     .toString()),
//                               ),
//                             ],
//                           );
//                         },
//                       ),
//                     ]),
//                 pw.Spacer(),
//                 pw.Table(border: pw.TableBorder.all(), children: [
//                   pw.TableRow(children: [
//                     pw.Container(
//                         width: width * 0.50,
//                         height: 50,
//                         child: pw.Center(
//                             child: pw.Text(
//                                 "${NumberToWord().convert("en-in", double.parse(pdf.total).toInt())}only"))),
//                     pw.Container(
//                         width: width * 0.50,
//                         height: 50,
//                         child: pw.Align(
//                             alignment: pw.Alignment.topCenter,
//                             child: pw.Text("Total Amount:${pdf.total}"))),
//                   ]),
//                 ])
//               ],
//             ),
//           );
//           //return pw.Table(children: [pw.TableRow(children: [])]);
//         },
//       ),
//     );
//
//     final returnPath = await Hive.openBox('appSettings').then((box) async {
//       String tatPath;
//       tatPath = box.getAt(0)['tat path'];
//       String finalPath = "";
//       final billFolder = Directory('$tatPath/Bills');
//
//       if (await billFolder.exists()) {
//         final areaFolder = Directory('${billFolder.path}/${pdf.location}');
//         if (await areaFolder.exists()) {
//           final shopFolder =
//               Directory('${areaFolder.path}/${pdf.Shopname.trim()}');
//           if (await shopFolder.exists()) {
//             final file = File('${shopFolder.path}/${pdf.Date}.pdf');
//             if (!await file.exists()) {
//               await file.create();
//             }
//             await file.writeAsBytes(await pdf1.save());
//             await OpenFile.open(file.path);
//             finalPath = file.path;
//           } else {
//             await shopFolder.create();
//             final file = File('${shopFolder.path}/${pdf.Date}.pdf');
//             await file.writeAsBytes(await pdf1.save());
//             await OpenFile.open(file.path);
//             finalPath = file.path;
//           }
//         } else {
//           await areaFolder.create();
//           final shopFolder = Directory('${areaFolder.path}/${pdf.Shopname}');
//           if (await shopFolder.exists()) {
//             final file = File('${shopFolder.path}/${pdf.Date}.pdf');
//             await file.writeAsBytes(await pdf1.save());
//             await OpenFile.open(file.path);
//             finalPath = file.path;
//           } else {
//             await shopFolder.create();
//             final file = File('${shopFolder.path}/${pdf.Date}.pdf');
//             await file.writeAsBytes(await pdf1.save());
//             await OpenFile.open(file.path);
//             finalPath = file.path;
//           }
//         }
//       } else {
//         await billFolder.create();
//         final areaFolder = Directory('${billFolder.path}/${pdf.location}');
//         if (await areaFolder.exists()) {
//           final shopFolder =
//               Directory('${areaFolder.path}/${pdf.Shopname.trim()}');
//           if (await shopFolder.exists()) {
//             final file = File('${shopFolder.path}/${pdf.Date}.pdf');
//             await file.writeAsBytes(await pdf1.save());
//             await OpenFile.open(file.path);
//             finalPath = file.path;
//           } else {
//             await shopFolder.create();
//             final file = File('${shopFolder.path}/${pdf.Date}.pdf');
//             await file.writeAsBytes(await pdf1.save());
//             await OpenFile.open(file.path);
//             finalPath = file.path;
//           }
//         } else {
//           await areaFolder.create();
//           final shopFolder = Directory('${areaFolder.path}/${pdf.Shopname}');
//           if (await shopFolder.exists()) {
//             final file = File('${shopFolder.path}/${pdf.Date}.pdf');
//             await file.writeAsBytes(await pdf1.save());
//             await OpenFile.open(file.path);
//             finalPath = file.path;
//           } else {
//             await shopFolder.create();
//             final file = File('${shopFolder.path}/${pdf.Date}.pdf');
//             await file.writeAsBytes(await pdf1.save());
//             await OpenFile.open(file.path);
//             finalPath = file.path;
//           }
//         }
//       }
//
//       return finalPath;
//     });
//     return returnPath;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }
import 'dart:math' as math;
import 'dart:developer';
import 'dart:ffi';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:number_to_words/number_to_words.dart';
import 'package:open_file/open_file.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/services.dart' show ByteData, Uint8List, rootBundle;
import 'package:tat_windows/Widgets/DateTime.dart';
import '../billnumber.dart';
import 'PDF.dart';


  Future<pw.Image> getImageFromAsset(String assetName) async {
    final ByteData data = await rootBundle.load(assetName);
    final Uint8List bytes = data.buffer.asUint8List();
    return pw.Image(pw.MemoryImage(bytes), width: 70, height: 70);
  }

  Future<String> generatePdf(Pdf pdf) async {
    final image = await getImageFromAsset('images/tatSymbolpdf.png');
    final pdf1 = pw.Document();
    final width = PdfPageFormat.a4.width;
    double contentHeight = pdf.order.orders.length * 20.0 + 200;
    double height = contentHeight < PdfPageFormat.a4.height / 2
        ? PdfPageFormat.a4.height / 2
        : contentHeight;
    height =
    height > PdfPageFormat.a4.height ? PdfPageFormat.a4.height : height;
    pw.TextStyle textStyle = pw.TextStyle(fontSize: 10);
    int i = 0;
    pdf1.addPage(
      pw.Page(
        margin: pw.EdgeInsets.all(1),
        pageFormat: PdfPageFormat(width, height),
        build: (context) {
          return pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Container(
                decoration: pw.BoxDecoration(
                    border: pw.Border.all(color: PdfColors.black, width: 2)),
                width: width,
                child: pw.Column(
                  children: [
                    pw.Table(
                      border: pw.TableBorder.all(),
                      children: [
                        pw.TableRow(
                          decoration: pw.BoxDecoration(
                              border: pw.Border.symmetric(
                                  vertical: pw.BorderSide(
                                      width: 2, color: PdfColors.black),
                                  horizontal: pw.BorderSide(
                                      width: 2, color: PdfColors.black))),
                          children: [
                            pw.Container(
                              width: width * 0.5,
                              child: pw.Row(
                                children: [
                                  image,
                                  pw.Column(
                                      crossAxisAlignment:
                                      pw.CrossAxisAlignment.start,
                                      children: [
                                        pw.Text("THARANI A TRADERS"),
                                        pw.Text(
                                            "69,Thiruvalluvar Nager 4th Cross,LNS post,"),
                                        pw.Text("Karur-639002 , ph:7598241254"),
                                        pw.Text("G-Pay:9626809103"),
                                      ])
                                ],
                              ),
                            ),
                            pw.Container(
                              padding: pw.EdgeInsets.all(10),
                              width: width * 0.48,
                              child: pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Text("TO:${pdf.order.shop.name}"),
                                  pw.Text("${pdf.order.beat}"),
                                  pw.Text("Ph:${pdf.order.shop.phno}"),
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    pw.Container(
                        decoration: pw.BoxDecoration(
                            border: pw.Border.symmetric(
                                horizontal: pw.BorderSide(width: 2))),
                        padding: pw.EdgeInsets.all(8),
                        width: width,
                        child: pw.Row(children: [
                          pw.Text("Bill No: ${pdf.billNumber}"),
                          pw.Spacer(),
                          pw.Text("Date:${pdf.order.date}"),
                          pw.Spacer(),
                          pw.Column(children: [
                            pw.Text(
                                "Acc.No.270002000000235, IFSC: IOBA0002700"),
                            pw.Text("Bank : IOB, Branch: KARUR")
                          ])
                        ])),
                    pw.Table(
                      border: pw.TableBorder.all(color: PdfColors.grey),
                      children: [
                        pw.TableRow(children: [
                          pw.Center(child: pw.Text("No", style: textStyle)),
                          pw.Center(
                              child: pw.Text("Product", style: textStyle)),
                          pw.Center(child: pw.Text("FREE", style: textStyle)),
                          pw.Center(child: pw.Text("MRP", style: textStyle)),
                          pw.Center(child: pw.Text("QTY", style: textStyle)),
                          pw.Center(child: pw.Text("RATE", style: textStyle)),
                          pw.Center(child: pw.Text("DIS", style: textStyle)),
                          pw.Center(child: pw.Text("VAL", style: textStyle)),
                          pw.Center(child: pw.Text("AMOUNT", style: textStyle)),
                        ]),
                        ...pdf.order.orders.map((e) {
                          i++;
                          double total = e.qty * e.product.sPrice;
                          double disVal =
                          (total * (e.product.discound ?? 0) / 100);
                          total = total - disVal;
                          return pw.TableRow(children: [
                            pw.Center(child: pw.Text(i.toString())),
                            pw.Text(e.product.productName, style: textStyle),
                            pw.Center(
                                child: pw.Text(e.free.toString(),
                                    style: textStyle)),
                            pw.Center(
                                child: pw.Text(e.product.mrp.toString(),
                                    style: textStyle)),
                            pw.Center(
                                child: pw.Text(e.qty.toString(),
                                    style: textStyle)),
                            pw.Center(
                                child: pw.Text(e.product.sPrice.toString(),
                                    style: textStyle)),
                            pw.Center(
                                child: pw.Text(
                                    (e.product.discound ?? "0").toString())),
                            pw.Center(child: pw.Text(disVal.toString())),
                            pw.Center(
                                child:
                                pw.Text(total.roundToDouble().toString())),
                          ]);
                        }).toList(),
                      ],
                    ),
                  ],
                ),
              ),
              pw.Table(border: pw.TableBorder.all(), children: [
                pw.TableRow(children: [
                  pw.Container(
                      width: width * 0.50,
                      height: 50,
                      child: pw.Center(
                          child: pw.Text(
                              "${NumberToWord().convert("en-in",pdf.order.total.toInt())} only"))),
                  pw.Container(
                      width: width * 0.50,
                      height: 50,
                      child: pw.Align(
                          alignment: pw.Alignment.topRight,
                          child: pw.Text(
                              "Total Amount:${pdf.order.total.roundToDouble()}     "))),
                ]),
              ])
            ],
          );
        },
      ),
    );

    final returnPath = await Hive.openBox('appSettings').then((box) async {
      String tatPath = box.getAt(0)['tat path'];
      final billFolder =
      Directory('$tatPath/Bills/${pdf.order.beat}/${pdf.order.shop.name.trim()}');
      final todayFolder =
      Directory('$tatPath/Bills/ByDate/${DateTimeTat().GetDate()}');
      await billFolder.create(recursive: true);
      await todayFolder.create(recursive: true);
      final file = File('${billFolder.path}/${pdf.order.date+"-"+pdf.billNumber.toString()+"-"+pdf.order.total.toString()}.pdf');
      final file2 = File(
          '${todayFolder.path}/${"${pdf.order.beat}-${pdf.order.shop.name.trim()}-${pdf.order.date+"-"+pdf.billNumber.toString()+"-"+pdf.order.total.toString()}.pdf"}');
      log("message");
      await file2.writeAsBytes(await pdf1.save());
      await file.writeAsBytes(await pdf1.save());

      await OpenFile.open(file.path);
      // await OpenFile.open(file2.path);
      return file.path;
    });
    return returnPath;
  }

