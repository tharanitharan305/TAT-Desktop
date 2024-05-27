import 'package:flutter/material.dart';

import '../Widgets/Areas.dart';
import '../Widgets/Shops.dart';

class ShopDet extends StatefulWidget {
  const ShopDet({super.key});

  @override
  State<ShopDet> createState() => _ShopDetState();
}

class _ShopDetState extends State<ShopDet> {
  String shopname = "Shop name";
  String Location = "--select--";
  bool isLoading = false;
  Set<Shop> ShopsList = {};
  bool dirExtits = true;
  bool isShopLoding = false;
  Shop shop = Shop(
      shopName: "shopName",
      phno: "phno",
      balance: "balance",
      purchase: "purchase");
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SetLocations();
  }

  GetitShops(String Location) async {
    final list = Shops().getShops(Location);
    final dupe = await list;

    setState(() {
      ShopsList = {shop, ...dupe};
    });
  }
//print(ShopsList);
//shopLoadStatus = false;

  Set<String> locations = {};
  SetLocations() async {
    final temloc = await Areas().GetLocationsF();
    //print(temloc);
    setState(() {
      locations = temloc;
    });
  }

  Widget DropDownLocation() {
    return DropdownButton(
        elevation: 50,
        autofocus: true,
        dropdownColor: Color.fromRGBO(222, 217, 217, 1),
        borderRadius: BorderRadius.circular(20),
        value: Location,
        items: locations
            .map((e) => DropdownMenuItem(
                  value: e,
                  key: UniqueKey(),
                  child: Text(e),
                ))
            .toList(),
        onChanged: (values) async {
          setState(() {
            isShopLoding = true;
          });
          setState(() {
            // DropDownView = values!;
            Location = values.toString();
            shopname = "Shop name";
          });
          await GetitShops(Location);
          setState(() {
            isShopLoding = false;
          });
        });
  }

  Widget DropDownShops() {
    //GetitShops(Location);
    if (!isShopLoding)
      return DropdownButton(
          elevation: 50,
          autofocus: true,
          dropdownColor: Color.fromRGBO(222, 217, 217, 1),
          borderRadius: BorderRadius.circular(20),
          value: shop,
          items: ShopsList.map((e) => DropdownMenuItem(
                value: e,
                key: UniqueKey(),
                child: Text(e.shopName),
              )).toList(),
          onChanged: (values) {
            setState(() {
              shopname = values!.shopName;
              shop = values!;
              // print(shopname);
            });
          });
    return CircularProgressIndicator();
  }

  Widget ShopDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("ShopName:        ${shop.shopName}"),
        Text("Total purchase:  ${shop.purchase}"),
        Text("Total Balance:   ${shop.balance}"),
        Text("Phone Number:    ${shop.phno}"),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [DropDownLocation(), DropDownShops(), ShopDetails()],
        ),
      ),
    );
  }
}
