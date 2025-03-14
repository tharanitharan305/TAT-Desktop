import 'package:firedart/firestore/firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Beat/Areas.dart';
import 'Areas.dart';
import 'DateTime.dart';

class Info extends StatefulWidget {
  State<Info> createState() => _InfoState();
  Info({required this.location, required this.date});
  String location;
  String date;
}

class _InfoState extends State<Info> {
  String dayTotal = "0";
  String Location = "Karur_Local";
  Set<String> locations = {};
  List<String> Time = [
    DateTimeTat().GetpreDate(0),
    DateTimeTat().GetpreDate(1),
    DateTimeTat().GetpreDate(2),
    DateTimeTat().GetpreDate(3),
    DateTimeTat().GetpreDate(4),
    DateTimeTat().GetpreDate(5),
    DateTimeTat().GetpreDate(6),
    DateTimeTat().GetpreDate(7),
    DateTimeTat().GetpreDate(8),
  ];
  String date = DateTimeTat().GetDate();
  void Total() async {
    final dum = await Areas().GetLocations();
    setState(() {
      Location = widget.location;
      locations = dum;
    });
    final list = await Firestore.instance
        .collection(Location)
        .where('Date', isEqualTo: date)
        .get();
    final Orderlist = list.map((e) => e['Total'].toString()).toList();
    var dummytotal = 0.0;
    for (var x in Orderlist) {
      dummytotal += double.parse(x.toString());
      print(x);
    }
    print(Orderlist);
    setState(() {
      dayTotal = dummytotal.toString();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Total();
  }

  Widget build(context) {
    return Container(
      width: double.infinity,
      child: Column(
        children: [
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
                  Location = values!;
                });
              }),
          SizedBox(
            height: 20,
          ),
          DropdownButton(
              elevation: 50,
              autofocus: true,
              dropdownColor: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(20),
              value: date,
              items: Time.map((e) => DropdownMenuItem(
                    value: e,
                    key: UniqueKey(),
                    child: Text(e),
                  )).toList(),
              onChanged: (values) {
                setState(() {
                  date = values!;
                });
                Total();
              }),
          SizedBox(
            height: 40,
          ),
          Text(
            "TOTAL",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          SizedBox(
            height: 40,
          ),
          Text("₹" + dayTotal,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20))
        ],
      ),
    );
  }
}
