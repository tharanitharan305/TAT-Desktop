import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tat_win/Screens/splashScreen.dart';
import '../Firebase/NewOrder.dart';
import '../Widgets/Areas.dart';
import '../Widgets/OrderPreview.dart';
import '../Widgets/Orders.dart';
import '../Widgets/Shops.dart';
import '../Widgets/comapnies.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() {
    return _OrderScreen();
  }
}

class _OrderScreen extends State<OrderScreen> {
  List<Orders>? dupeProducts;
  final key = GlobalKey<FormState>();
  final spkey = GlobalKey<FormState>();
  String StateString = "Select a company name to get Product";
  bool ViewScrool = true;
  bool Admin = false;
  int Quantity = 0;
  String company = "--select--";
  Shop shop = Shop(
      shopName: "shopName",
      phno: "phno",
      balance: " balance",
      purchase: "purchase");
  String ShopName = "Shop name";
  String phno = "";
  List<Orders>? Products;
  Set<Orders> overAllOrders = {
    Orders(
        Products: 'null', SellingPrice: '0', MRP: '0', Quantity: '0', Free: '0')
  };
  Set<String> locations = {};
  Set<String> companies = {};
  String Location = "--select--";
  bool SendState = false;
  bool shopStatus = false;
  bool productStatus = false;
  bool locationStatus = false;
  Color changesp = Colors.red;
  Set<Shop> ShopsList = {};
  bool shopLoadStatus = false;
  bool orderStatus = false;
  bool quanStatus = false;
  bool freeStatus = false;
  Future<void> GetitShops(String Location) async {
    final list = Shops().getShops(Location);
    final dupe = await list;
    setState(() {
      ShopsList = {shop, ...dupe};
    });
    print(ShopsList);
    shopLoadStatus = false;
  }

  void SetitShops(String Location) {
    GetitShops(Location);
  }

  sucess() {
    this.overAllOrders = {
      Orders(
          Products: 'null',
          SellingPrice: '0',
          MRP: '0',
          Quantity: '0',
          Free: '0')
    };
  }

  void Getit(String company) async {
    Future<List<Orders>> p = NewOrder().SetList(company);
    dupeProducts = await p;
    setState(() {
      Products = dupeProducts;
      orderStatus = false;
    });
  }

  void Setit(String company) async {
    setState(() {
      orderStatus = true;
      Getit(company);
    });
  }

  void onSubmit() {
    setState(() {
      StateString = 'Uploading Order please wait...';
    });
    if (ShopName != "Shop ") {
      showDialog(
          context: context,
          builder: (context) => OrderPreview(
                Order: overAllOrders,
                Shopname: ShopName,
                Location: Location,
                phno: phno,
              ));
      setState(() {
        StateString = 'Order sent succesfully...';
      });
    }
  }

  void onNextOrder() {
    for (int i = 0; i < Products!.length; i++) {
      if (Products?.elementAt(i) != null &&
          double.parse(Products!.elementAt(i).Quantity) > 0) {
        Orders check = Products!.elementAt(i);
        overAllOrders.add(check);
      }
    }
    setState(() {
      ViewScrool = false;
      StateString = "Order update Success Continue to next...";
      SendState = true;
    });
  }

  Color changeSpc() {
    return changesp;
  }

  SetLocations() async {
    final temloc = await Areas().GetLocationsF();
    //print(temloc);
    setState(() {
      locations = temloc;
    });
  }

  SetCompany() async {
    final temcomp = await Companies().GetCompany();
    setState(() {
      companies = temcomp;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SetLocations();
    SetCompany();
  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order'),
        backgroundColor: Color.fromRGBO(249, 245, 245, 1),
        actions: [
          DropdownButton(
              elevation: 50,
              autofocus: true,
              dropdownColor: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(20),
              value: Location,
              items: locations
                  .map((e) => DropdownMenuItem(
                        value: e,
                        key: UniqueKey(),
                        child: Text(e),
                      ))
                  .toList(),
              onChanged: (values) {
                setState(() {
                  shopLoadStatus = true;
                  Location = values.toString();
                  locationStatus = true;
                });
                SetitShops(Location);
              }),
          SizedBox(
            width: 40,
          )
        ],
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          //if (ShopsList.length > 0)
          DropdownButton(
              elevation: 50,
              autofocus: true,
              dropdownColor: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(20),
              value: shop,
              items: ShopsList.map((e) => DropdownMenuItem(
                    value: e,
                    key: UniqueKey(),
                    child: Text(e.shopName),
                  )).toList(),
              onChanged: (values) {
                setState(() {
                  ShopName = values!.shopName;
                  phno = values!.phno;
                  shop = values!;
                  shopStatus = true;
                });
              }),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              DropdownButton(
                  elevation: 50,
                  autofocus: true,
                  dropdownColor: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(20),
                  value: company,
                  items: companies
                      .map((e) => DropdownMenuItem(
                            value: e,
                            key: UniqueKey(),
                            child: Text(e),
                          ))
                      .toList(),
                  onChanged: (values) {
                    setState(() {
                      company = values!;
                      productStatus = true;
                    });
                  }),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor:
                          Theme.of(context).colorScheme.primaryContainer),
                  onPressed: productStatus && locationStatus && shopStatus
                      ? () {
                          setState(() {
                            Setit(company);
                            ViewScrool = true;
                          });
                        }
                      : null,
                  child: const Text('Get Product'),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor:
                          Theme.of(context).colorScheme.primaryContainer),
                  onPressed: shopStatus && locationStatus && productStatus
                      ? onNextOrder
                      : null,
                  child: const Text('Submit')),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
                child: Column(
              children: [
                if (orderStatus)
                  Center(
                      child: SplashScreen(
                    width: 10,
                    height: 10,
                  )),
                if (ViewScrool)
                  ...?Products?.map((e) {
                    return Card(
                      child: Column(
                        children: [
                          Text(
                            e.Products,
                            style: GoogleFonts.bitter(
                                textStyle: const TextStyle(
                                    letterSpacing: 1, fontSize: 20)),
                          ),
                          Row(children: [
                            Text('S.p:'),
                            Text(e.SellingPrice.toString()),
                            SizedBox(width: 10),
                            Text('MRP:'),
                            Text(e.MRP.toString()),
                            SizedBox(width: 10),
                            Text('Quantity:'),
                            Text(e.Quantity.toString()),
                            SizedBox(width: 10),
                            Text('FREE:'),
                            Text(e.Free),
                            IconButton(
                                color: Colors.red,
                                onPressed: e.Quantity == '0'
                                    ? null
                                    : () {
                                        showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                              actions: [
                                                IconButton(
                                                    onPressed: () {
                                                      if (spkey.currentState!
                                                          .validate()) {
                                                        spkey.currentState!
                                                            .save();
                                                        Navigator.pop(context);
                                                      }
                                                    },
                                                    icon: Icon(Icons
                                                        .currency_exchange_rounded))
                                              ],
                                              title: const Text('Changing...'),
                                              content: Form(
                                                key: spkey,
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    TextFormField(
                                                      decoration:
                                                          const InputDecoration(
                                                              labelText:
                                                                  "Selling Price"),
                                                      keyboardType:
                                                          TextInputType.number,
                                                      validator: (value) {
                                                        if (value == null ||
                                                            double.tryParse(
                                                                        value!) ==
                                                                    null &&
                                                                double.parse(
                                                                        value) <=
                                                                    0)
                                                          return "Enter a valid Selling Price";
                                                        return null;
                                                      },
                                                      onSaved: (values) {
                                                        if (double.parse(
                                                                values!) !=
                                                            0) {
                                                          setState(() {
                                                            e.SellingPrice =
                                                                values!;
                                                          });
                                                        }
                                                      },
                                                    ),
                                                    TextFormField(
                                                      decoration:
                                                          const InputDecoration(
                                                              labelText:
                                                                  "FREE"),
                                                      keyboardType:
                                                          TextInputType.number,
                                                      validator: (value) {
                                                        if (value == null ||
                                                            double.tryParse(
                                                                        value!) ==
                                                                    null &&
                                                                double.parse(
                                                                        value) <=
                                                                    0)
                                                          return "Enter a valid FREE";
                                                        return null;
                                                      },
                                                      onSaved: (values) {
                                                        if (values != null &&
                                                            !values.isEmpty)
                                                          setState(() {
                                                            e.Free = values!;
                                                          });
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              )),
                                        );
                                      },
                                icon: Icon(
                                  Icons.change_circle_rounded,
                                ))
                          ]),
                          Form(
                              child: TextFormField(
                            decoration:
                                const InputDecoration(labelText: 'quantity'),
                            onChanged: (value) {
                              setState(() {
                                if (value != null && !value.isEmpty)
                                  e.Quantity = value;
                                else
                                  e.Quantity = '0';
                              });
                            },
                            keyboardType: TextInputType.number,
                          )),
                          const SizedBox(
                            height: 10,
                          )
                        ],
                      ),
                    );
                  }),
              ],
            )),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
          elevation: 10,
          disabledElevation: 0,
          enableFeedback: true,
          onPressed: !ViewScrool ? onSubmit : null,
          child: const Icon(Icons.check)),
    );
  }
}
