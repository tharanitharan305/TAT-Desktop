import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Widgets/comapnies.dart';
import '../companies/comapnies.dart';

class AddCompany extends StatefulWidget {
  const AddCompany({super.key});

  @override
  State<AddCompany> createState() => _AddCompanyState();
}

class _AddCompanyState extends State<AddCompany> {
  String CompanyName = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Company"),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: "Enter Company name"),
              onChanged: (value) {
                setState(() {
                  CompanyName = value;
                });
              },
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                    onPressed: () {
                      Companies().AddCompany(CompanyName);
                    },
                    child: Text('Add')),
              ],
            )
          ],
        ),
      ),
    );
  }
}
