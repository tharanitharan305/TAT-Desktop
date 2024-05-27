import 'dart:ffi';
import 'dart:io';
//import 'dart:nativewrappers/_internal/vm/lib/core_patch.dart';
//import 'dart:nativewrappers/_internal/vm/lib/core_patch.dart';

import 'package:flutter/material.dart';

import 'package:hive/hive.dart';
import 'package:number_to_words/number_to_words.dart';
import 'package:open_file/open_file.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/services.dart' show ByteData, Uint8List, rootBundle;

import 'PDF.dart';

class PdfGenerator extends StatelessWidget {
  PdfGenerator({super.key, required this.pdf, required this.isFullPage});
  PDF pdf;
  bool isFullPage;
  Future<pw.Image> getImageFromAsset(String assetName) async {
    final ByteData data = await rootBundle.load(assetName);
    final Uint8List bytes = data.buffer.asUint8List();
    return pw.Image(pw.MemoryImage(bytes), width: 70, height: 70);
  }

  double dis = 0;

  Future<void> generatePdf() async {
    final image = await getImageFromAsset(
        'images/tatSymbolpdf.png'); // Change the asset path
    final pdf1 = pw.Document();
    final width = PdfPageFormat.a4.width;
    final height =
        isFullPage ? PdfPageFormat.a4.height : PdfPageFormat.a4.height / 2;
    var i = 0;
    pdf1.addPage(
      pw.Page(
        margin: pw.EdgeInsets.all(20),
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return pw.Container(
            decoration: pw.BoxDecoration(
                border: pw.Border.all(color: PdfColors.black, width: 2)),
            width: width,
            height: height,
            child: pw.Column(
              children: [
                pw.Table(
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
                          //color: PdfColors.black,

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
                          decoration: pw.BoxDecoration(
                              border: pw.Border.symmetric(
                                  vertical: pw.BorderSide(width: 2))),
                          width: width * 0.48,
                          child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Text("TO:${pdf.Shopname}"),
                              pw.Text("${pdf.location}"),
                              pw.Text("Ph:${pdf.phno}"),
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
                      pw.Text("Bill No:"),
                      pw.Spacer(),
                      pw.Text("Date:${pdf.Date}"),
                      pw.Spacer(),
                      pw.Column(children: [
                        pw.Text("Acc.No.270002000000235, IFSC: IOBA0002700"),
                        pw.Text("Bank : IOB, Branch: KARUR")
                      ])
                    ])),
                pw.Table(
                    border: pw.TableBorder.all(color: PdfColors.grey),
                    children: [
                      pw.TableRow(children: [
                        pw.Center(
                          child: pw.Text("No"),
                        ),
                        pw.Center(
                          child: pw.Text("Product"),
                        ),
                        pw.Center(
                          child: pw.Text("FREE"),
                        ),
                        pw.Center(
                          child: pw.Text("MRP"),
                        ),
                        pw.Center(
                          child: pw.Text("QTY"),
                        ),
                        pw.Center(
                          child: pw.Text("RATE"),
                        ),
                        pw.Center(
                          child: pw.Text("DIS"),
                        ),
                        pw.Center(
                          child: pw.Text("VAL"),
                        ),
                        pw.Center(
                          child: pw.Text("AMOUNT"),
                        ),
                      ]),
                      ...pdf.items.map(
                        (e) {
                          i++;
                          return pw.TableRow(
                            children: [
                              pw.Center(
                                child: pw.Text(i.toString()),
                              ),
                              pw.Center(
                                child: pw.Text(e.Products),
                              ),
                              pw.Center(
                                child: pw.Text(e.Free),
                              ),
                              pw.Center(
                                child: pw.Text(e.MRP),
                              ),
                              pw.Center(
                                child: pw.Text(e.Quantity),
                              ),
                              pw.Center(
                                child: pw.Text(e.SellingPrice),
                              ),
                              pw.Center(
                                child: pw.Text("0"),
                              ),
                              pw.Center(
                                child: pw.Text("0"),
                              ),
                              pw.Center(
                                child: pw.Text((double.parse(e.Quantity) *
                                        double.parse(e.SellingPrice))
                                    .toString()),
                              ),
                            ],
                          );
                        },
                      ),
                    ]),
                pw.Spacer(),
                pw.Table(border: pw.TableBorder.all(), children: [
                  pw.TableRow(children: [
                    pw.Container(
                        width: width * 0.50,
                        height: 40,
                        child: pw.Center(
                            child: pw.Text(NumberToWord().convert(
                                "en-in", double.parse(pdf.total).toInt())))),
                    pw.Container(
                        width: width * 0.50,
                        height: 40,
                        child: pw.Align(
                            alignment: pw.Alignment.topCenter,
                            child: pw.Text("Total Amount:${pdf.total}"))),
                  ]),
                ])
              ],
            ),
          );
          //return pw.Table(children: [pw.TableRow(children: [])]);
        },
      ),
    );

    await Hive.openBox('appSettings').then((box) async {
      String tatPath;
      tatPath = box.getAt(0)['tat path'];
      final billFolder = await Directory('$tatPath/Bills');
      if (await billFolder.exists()) {
        final areaFolder = Directory('${billFolder.path}/${pdf.location}');
        if (await areaFolder.exists()) {
          final shopFolder = Directory('${areaFolder.path}/${pdf.Shopname}');
          if (await shopFolder.exists()) {
            final file = File('${shopFolder.path}/${pdf.Date}.pdf');
            await file.writeAsBytes(await pdf1.save());
            await OpenFile.open(file.path);
          } else {
            await shopFolder.create();
            final file = File('${shopFolder.path}/${pdf.Date}.pdf');
            await file.writeAsBytes(await pdf1.save());
            await OpenFile.open(file.path);
          }
        } else {
          await areaFolder.create();
          final shopFolder = Directory('${areaFolder.path}/${pdf.Shopname}');
          if (await shopFolder.exists()) {
            final file = File('${shopFolder.path}/${pdf.Date}.pdf');
            await file.writeAsBytes(await pdf1.save());
            await OpenFile.open(file.path);
          } else {
            await shopFolder.create();
            final file = File('${shopFolder.path}/${pdf.Date}.pdf');
            await file.writeAsBytes(await pdf1.save());
            await OpenFile.open(file.path);
          }
        }
      } else {
        await billFolder.create();
        final areaFolder = Directory('${billFolder.path}/${pdf.location}');
        if (await areaFolder.exists()) {
          final shopFolder = Directory('${areaFolder.path}/${pdf.Shopname}');
          if (await shopFolder.exists()) {
            final file = File('${shopFolder.path}/${pdf.Date}.pdf');
            await file.writeAsBytes(await pdf1.save());
            await OpenFile.open(file.path);
          } else {
            await shopFolder.create();
            final file = File('${shopFolder.path}/${pdf.Date}.pdf');
            await file.writeAsBytes(await pdf1.save());
            await OpenFile.open(file.path);
          }
        } else {
          await areaFolder.create();
          final shopFolder = Directory('${areaFolder.path}/${pdf.Shopname}');
          if (await shopFolder.exists()) {
            final file = File('${shopFolder.path}/${pdf.Date}.pdf');
            await file.writeAsBytes(await pdf1.save());
            await OpenFile.open(file.path);
          } else {
            await shopFolder.create();
            final file = File('${shopFolder.path}/${pdf.Date}.pdf');
            await file.writeAsBytes(await pdf1.save());
            await OpenFile.open(file.path);
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
