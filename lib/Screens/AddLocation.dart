import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tat_win/Widgets/Areas.dart';

class AddLocation extends StatefulWidget {
  const AddLocation({super.key});

  @override
  State<AddLocation> createState() => _AddLocationState();
}

class _AddLocationState extends State<AddLocation> {
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
                      //C().AddCompany(location);
                      Areas().AddLocation(location);
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
