import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tat_windows/Products/model/Product.dart';
import 'package:tat_windows/Widgets/DropDown.dart';
import 'package:tat_windows/Widgets/comapnies.dart';

import '../../Widgets/Areas.dart';
import '../../companies/comapnies.dart';
import '../bloc/Product_bloc.dart';

class ProductGetter extends StatefulWidget {
  final Product? product;

  ProductGetter({super.key, this.product});

  @override
  State<ProductGetter> createState() => _ProductGetterState();
}

class _ProductGetterState extends State<ProductGetter> {
  late Product currentProduct;
  late bool isUpdateMode;
  final List<String> scale = ["pcs", "kg", "dozen", "sar", "box", "bag"];
  Set<String> companies = {};
  final key = GlobalKey<FormState>();
  void setCompanies() async {
    final temp = await Companies().GetCompany();
    setState(() {
      companies = temp;
    });
  }

  @override
  void initState() {
    super.initState();
    setCompanies();
    isUpdateMode = widget.product != null;
    currentProduct = widget.product ??
        Product(
          sno: 0,
          partNo: "PartNo",
          barcode: "barcode",
          productName: "productName",
          rack: "rack",
          groupName: "groupName",
          company: "--select--",
          commodity: "commodity",
          salesVat: "sales Tax",
          section: "section",
          cPrice: 0.0,
          margin: 0.0,
          mrp: 0.0,
          sPrice: 0.0,
          splPrice: 0.0,
          unit: "pcs",
          weight: 0.0,
          expiryDays: 0,
          godownTax: "Product Tax",
          supplier: "supplier",
          discound: 0.0,
          pPrice: 0.0,
        );
  }

  void updateField(String field, dynamic value) {
    context
        .read<ProductBloc>()
        .add(UpdateProductField(fieldName: field, value: value));
  }

  String validateFields(String field, String? value) {
    if (value == null ||
        value.length <= 0 ||
        value == "productName" ||
        value == "groupName" ||
        value == "company" ||
        value == "section" ||
        value == "rack" ||
        value == "sales Tax" ||
        value == "Product Tax") {
      return "அதில் ஏதாவது எழுதுங்கள்";
    }
    switch (field) {
      case 'sno':
        break;
      case 'partNo':
        if (int.tryParse(value) == null) {
          return "Enter a Number";
        }
        break;
      case 'barcode':
        break;
      case 'productName':
        if (value.length <= 5) {
          return "மிகவும் குறுகிய பெயர்";
        }
        if (value.length >= 100) {
          return "மிகப் பெரிய பெயர்";
        }

        break;
      case 'rack':
        if (value.length <= 5) {
          return "மிகவும் குறுகிய பெயர்";
        }
        if (value.length >= 100) {
          return "மிகப் பெரிய பெயர்";
        }
        break;
      case 'groupName':
        if (value.length <= 5) {
          return "மிகவும் குறுகிய பெயர்";
        }
        if (value.length >= 100) {
          return "மிகப் பெரிய பெயர்";
        }
        break;
      case 'company':
        if (value.length <= 5) {
          return "மிகவும் குறுகிய பெயர்";
        }
        if (value.length >= 30) {
          return "மிகப் பெரிய பெயர்";
        }
        break;
      case 'commodity':
        break;
      case 'salesVat':
        if (double.tryParse(value) == null) {
          return "Enter a Number";
        } else if (double.parse(value) <= 0) {
          return "சிறிய எண்";
        } else if (double.parse(value) > 100) {
          return "சதவீதம் 100க்கு குறைவாக இருக்க வேண்டும்";
        }
        break;
      case 'section':
        if (value.length <= 5) {
          return "மிகவும் குறுகிய பெயர்";
        }
        if (value.length >= 30) {
          return "மிகப் பெரிய பெயர்";
        }
        break;
      case 'cPrice':
        if (double.tryParse(value) == null) {
          return "Enter a Number";
        } else if (double.parse(value) <= 0) {
          return "மிக குறைந்த விலை";
        }
        break;
      case 'margin':
        if (double.tryParse(value) == null) {
          return "Enter a Number";
        } else if (double.parse(value) <= 0) {
          return "சிறிய எண்";
        } else if (double.parse(value) > 100) {
          return "சதவீதம் 100க்கு குறைவாக இருக்க வேண்டும்";
        }
        break;
      case 'mrp':
        if (double.tryParse(value) == null) {
          return "Enter a Number";
        } else if (double.parse(value) <= 0) {
          return "மிக குறைந்த விலை";
        }
        break;
      case 'sPrice':
        if (double.tryParse(value) == null) {
          return "Enter a Number";
        } else if (double.parse(value) <= 0) {
          return "மிக குறைந்த விலை";
        }
        break;
      case 'splPrice':
        if (double.tryParse(value) == null) {
          return "Enter a Number";
        } else if (double.parse(value) <= 0) {
          return "மிக குறைந்த விலை";
        }
        break;
      case 'unit':
        break;
      case 'weight':
        if (double.tryParse(value) == null) {
          return "Enter a Number";
        } else if (double.parse(value) <= 0) {
          return "மிக குறைந்த விலை";
        }
        break;
      case 'expiryDays':
        if (int.tryParse(value) == null) {
          return "Enter a Number";
        }
        break;
      case 'godownTax':
        if (double.tryParse(value) == null) {
          return "Enter a Number";
        } else if (double.parse(value) <= 0) {
          return "சிறிய எண்";
        } else if (double.parse(value) > 100) {
          return "சதவீதம் 100க்கு குறைவாக இருக்க வேண்டும்";
        }
        break;
      case 'supplier':
        break;
      case 'pPrice':
        if (double.tryParse(value) == null) {
          return "Enter a Number";
        } else if (double.parse(value) <= 0) {
          return "மிக குறைந்த விலை";
        }
        break;
      default:
        break;
    }
    return "";
  }

  Widget buildTextField(String label, String field, String initialValue) {
    return Row(
      children: [
        Text("$label : "),
        Expanded(
            child: TextFormField(
          initialValue: initialValue,
          validator: (value) {
            String err = validateFields(field, value);
            return err == "" ? null : err;
          },
          onChanged: (value) {
            updateField(field, value);
          },
          onSaved: (value) {
            updateField(field, value);
          },
        )),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is ProductLoaded) {
          currentProduct = state.product;
        }
        return Scaffold(
          body: SingleChildScrollView(
            child: Form(
              key: key,
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.20,
                          child: buildTextField("Product Code", "partNo",
                              currentProduct.partNo!)),
                      Expanded(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.60,
                          child: buildTextField("Product Name", "productName",
                              currentProduct.productName),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.40,
                          child: buildTextField("Group Name", "groupName",
                              currentProduct.groupName!)),
                      Text("Company: "),
                      Expanded(
                          child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.40,
                              child: DropdownTat(
                                  dropdownValue: currentProduct.company,
                                  set: companies,
                                  onChanged: (value) {
                                    updateField("company", value);
                                  }))),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.40,
                          child: buildTextField(
                              "Rack", "rack", currentProduct.rack!)),
                      Expanded(
                        child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.40,
                            child: buildTextField(
                                "Section", "section", currentProduct.section)),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.40,
                          child: buildTextField("Sales Tax", "salesVat",
                              currentProduct.salesVat)),
                      Expanded(
                        child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.40,
                            child: buildTextField("Product Tax", "godownTax",
                                currentProduct.godownTax)),
                      ),
                    ],
                  ),
                  // Stock Dropdown
                  Row(
                    children: [
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.60,
                          child: buildTextField("Stock", "weight",
                              currentProduct.weight.toString())),
                      Expanded(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.10,
                          child: DropdownButton<String>(
                            value: currentProduct.unit,
                            items: scale
                                .map((e) =>
                                    DropdownMenuItem(value: e, child: Text(e)))
                                .toList(),
                            onChanged: (value) {
                              if (value != null) {
                                updateField("unit", value);
                              }
                              log(context
                                  .read<ProductBloc>()
                                  .currentProduct
                                  .unit);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.17,
                          child: buildTextField("Purchase Price", "pPrice",
                              currentProduct.pPrice.toString())),
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.17,
                          child: buildTextField("Cost Price", "cPrice",
                              currentProduct.cPrice.toString())),
                      Expanded(
                        child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.17,
                            child: buildTextField(
                                "MRP", "mrp", currentProduct.mrp.toString())),
                      ),
                      Expanded(
                        child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.17,
                            child: buildTextField("Margin %", "margin",
                                currentProduct.margin.toString())),
                      ),
                      Expanded(
                        child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.17,
                            child: buildTextField("Spl Price", "splPrice",
                                currentProduct.splPrice.toString())),
                      ),
                    ],
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.40,
                      child: buildTextField("Discound", "discound",
                          currentProduct.discound.toString())),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.40,
                      child: buildTextField("Selling Price", "sPrice",
                          currentProduct.sPrice.toString())),
                  buildTextField("Expiry Days", "expiryDays",
                      currentProduct.expiryDays.toString()),
                  const SizedBox(height: 20),

                  // Save Button
                  ElevatedButton(
                    onPressed: () {
                      if (key.currentState!.validate()) {
                        key.currentState!.save();
                      }
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text(isUpdateMode
                                ? "Product Updated"
                                : "New Product Added")),
                      );
                    },
                    child:
                        Text(isUpdateMode ? "Update Product" : "Add Product"),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
