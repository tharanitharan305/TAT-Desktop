import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tat_win/Widgets/comapnies.dart';

class AddCompany extends StatefulWidget {
  const AddCompany({super.key});

  @override
  State<AddCompany> createState() => _AddCompanyState();
}

class _AddCompanyState extends State<AddCompany> {
  String location = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Location"),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: "Enter Location"),
              onChanged: (value) {
                setState(() {
                  location = value;
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
                      Companies().AddCompany(location);
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
