import 'dart:developer';
import 'dart:io';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firedart/firestore/firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tat_windows/Widgets/Areas.dart';
import 'package:tat_windows/Widgets/comapnies.dart';
import 'package:uuid/uuid.dart';
import '../Products/model/Product.dart';
import '../Widgets/DateTime.dart';
import '../companies/comapnies.dart';

class AddProductE extends StatefulWidget {
  const AddProductE({super.key});

  @override
  State<AddProductE> createState() => _AddProductEState();
}

class _AddProductEState extends State<AddProductE> {
  String company = "--select--";
  Set<String> companies = {};
  List<Map<String, dynamic>> excelData = []; // Store Excel rows
  bool uploadStatus = false;
  final uuid = Uuid();

  @override
  void initState() {
    super.initState();
    SetCompany();
  }

  // Fetch companies for dropdown
  SetCompany() async {
    final tempComp = await Companies().GetCompany();
    setState(() {
      companies = tempComp;
    });
  }

  // Upload products to Firebase
  void uploadProducts() async {
    if (company == "--select--" || excelData.isEmpty) {
      Get.snackbar("Error", "Please select a company and load Excel data.",
          duration: Duration(seconds: 3), icon: Icon(Icons.error));
      return;
    }

    try {
      setState(() {
        uploadStatus = true;
      });

      for (var data in excelData) {
        await Firestore.instance
            .collection(company) // Use proper string interpolation
            .document(data[
                'productName']) // Use doc instead of document (updated Firestore API)
            .set({
          "sno": data['sno'],
          "partNo": data['partNo'],
          "barcode": data['barcode'],
          "productName": data['productName'],
          "rack": data['rack'],
          "groupName": data['groupName'],
          "company": data['company'],
          "commodity": data['commodity'],
          "salesVat": data['salesVat'],
          "section": data['section'],
          "cPrice": data['cPrice'],
          "pPrice": data['pPrice'],
          "margin": data['margin'],
          "mrp": data['mrp'],
          "sPrice": data['sPrice'],
          "splPrice": data['splPrice'],
          "unit": data['unit'],
          "weight": data['weight'],
          "expiryDays": data['expiryDays'],
          "godownTax": data['godownTax'],
          "supplier": data['supplier'],
          "discound": data['discound'],
          "uploadTime": DateTimeTat()
              .GetDate(), // Assuming this gets a formatted DateTime
          "uid": uuid.v4(),
        });
      }

      setState(() {
        uploadStatus = false;
      });
      Get.snackbar("Success", "Products uploaded successfully.",
          duration: Duration(seconds: 3), icon: Icon(Icons.done));
    } catch (e) {
      setState(() {
        uploadStatus = false;
      });
      Get.snackbar("Error", e.toString(),
          duration: Duration(seconds: 3), icon: Icon(Icons.error));
    }
  }

  // Load Excel file and parse data
  Future<void> loadExcelFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx', 'xls'],
    );

    if (result != null) {
      var bytes = File(result.files.single.path!).readAsBytesSync();
      var excel = Excel.decodeBytes(bytes);

      List<Map<String, dynamic>> tempData = [];

      var sheet = excel.tables[excel.tables.keys.first];
      if (sheet != null) {
        for (var row in sheet.rows.skip(8)) {
          Product product = Product(
              sno: 1,
              partNo: "partNo",
              barcode: "barcode",
              productName: "productName",
              rack: "rack",
              groupName: "groupName",
              company: "company",
              commodity: "commodity",
              salesVat: "GST 0%",
              section: "section",
              cPrice: 0.0,
              margin: 0.0,
              mrp: 0.0,
              sPrice: 0.0,
              splPrice: 0.0,
              unit: "unit",
              weight: 0.0,
              expiryDays: 0,
              godownTax: "GST0%",
              supplier: "supplier",
              discound: 0.0,
              pPrice: 0.0);
          product = product.copyWith(
            partNo: row[1]?.value?.toString().trim(),
            productName: row[3]?.value?.toString().trim(),
            rack: row[4]?.value?.toString().trim(),
            groupName: row[5]?.value?.toString().trim(),
            company: row[6]?.value?.toString().trim(),
            commodity: row[7]?.value?.toString().trim(),
            salesVat: row[8]?.value?.toString().trim(),
            section: row[9]?.value?.toString().trim(),
            discound:
                double.tryParse(row[13]?.value?.toString().trim() ?? "") ?? 0.0,
            pPrice:
                double.tryParse(row[14]?.value?.toString().trim() ?? "") ?? 0.0,
            cPrice:
                double.tryParse(row[15]?.value?.toString().trim() ?? "") ?? 0.0,
            margin:
                double.tryParse(row[16]?.value?.toString().trim() ?? "") ?? 0.0,
            mrp:
                double.tryParse(row[17]?.value?.toString().trim() ?? "") ?? 0.0,
            sPrice:
                double.tryParse(row[18]?.value?.toString().trim() ?? "") ?? 0.0,
            splPrice:
                double.tryParse(row[19]?.value?.toString().trim() ?? "") ?? 0.0,
            unit: row[20]?.value?.toString().trim(),
            weight:
                double.tryParse(row[21]?.value?.toString().trim() ?? "") ?? 0.0,
            expiryDays:
                int.tryParse(row[22]?.value?.toString().trim() ?? "") ?? 0,
            godownTax: row[23]?.value?.toString().trim(),
            supplier: row[24]?.value?.toString().trim(),
          );
          // Skip first 6 rows
          // String? product = row[3]?.value?.toString().trim(); // Column D
          // String? sellingPrice = row[18]?.value?.toString().trim(); // Column S
          // String? mrp = row[17]?.value?.toString().trim(); // Column R

          // if (product != null && sellingPrice != null && mrp != null) {
          //   tempData.add({
          //     'Product': product,
          //     'SellingPrice': sellingPrice,
          //     'MRP': mrp,
          //   });
          // }
          log(product.toString());
          tempData.add(product.toMap());
        }
      }

      setState(() {
        excelData = tempData;
      });

      Get.snackbar("Success", "Excel file loaded successfully.",
          duration: Duration(seconds: 3), icon: Icon(Icons.check_circle));
    } else {
      log("erros");
      Get.snackbar("Error", "File selection cancelled.",
          duration: Duration(seconds: 3), icon: Icon(Icons.error_outline));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(40),
      child: Scaffold(
        appBar: AppBar(
          title: Text(excelData.length.toString()),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Company Dropdown
            DropdownButton(
              elevation: 10,
              dropdownColor: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(20),
              value: company,
              items: companies
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  company = value!;
                });
              },
            ),
            SizedBox(height: 20),

            // Load Excel Button
            ElevatedButton(
              onPressed: loadExcelFile,
              child: Text("Load Excel File"),
            ),
            SizedBox(height: 20),

            // Upload Button
            if (excelData.isNotEmpty)
              ElevatedButton(
                onPressed: uploadProducts,
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Theme.of(context).colorScheme.primaryContainer,
                ),
                child: uploadStatus
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text("Upload Products"),
              ),

            // Preview Loaded Data
            if (excelData.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: excelData.length,
                  itemBuilder: (context, index) {
                    final item = excelData[index];
                    return ListTile(
                      title: Text("Product: ${item['productName']}"),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Part No: ${item['partNo']}"),
                          Text("Barcode: ${item['barcode']}"),
                          Text("Rack: ${item['rack']}"),
                          Text("Group: ${item['groupName']}"),
                          Text("Company: ${item['company']}"),
                          Text("Commodity: ${item['commodity']}"),
                          Text("Sales VAT: ${item['salesVat']}"),
                          Text("Section: ${item['section']}"),
                          Text("Cost Price: ${item['cPrice']}"),
                          Text("Purchase Price: ${item['pPrice']}"),
                          Text("Margin: ${item['margin']}%"),
                          Text("MRP: ${item['mrp']}"),
                          Text("Selling Price: ${item['sPrice']}"),
                          Text("Special Price: ${item['splPrice']}"),
                          Text("Unit: ${item['unit']}"),
                          Text("Weight: ${item['weight']} kg"),
                          Text("Expiry Days: ${item['expiryDays']}"),
                          Text("Godown Tax: ${item['godownTax']}"),
                          Text("Supplier: ${item['supplier']}"),
                          Text("Discount: ${item['discound']}%"),
                        ],
                      ),
                      isThreeLine: true,
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
