import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Listprintfiles extends StatefulWidget {
  List<File> list_Files;
  Listprintfiles({super.key, required this.list_Files});

  @override
  State<Listprintfiles> createState() => _ListprintfilesState();
}

class _ListprintfilesState extends State<Listprintfiles> {
  Widget pdfCard(File pdf, bool isFocus) {
    List<String> path_details = pdf.path.split(RegExp(r'[\\/]+'));
    List<String> details = path_details.last.split("_");

    return Card(
      color: isFocus ? Colors.blue : Colors.lightBlueAccent,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Text(
              "Location: ${details[0]}",
              style: TextStyle(fontSize: 15),
            ),
            Text("  Shop Name: ${details[1]}", style: TextStyle(fontSize: 15)),
            Spacer(),
            Text(" Total: ${details[2]}    ")
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int focus_index = 0;
    return RawKeyboardListener(
      focusNode: FocusNode()..requestFocus(),
      onKey: (RawKeyEvent event) {
        if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
          focus_index--;
        } else if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
          focus_index++;
        } else if (event.logicalKey == LogicalKeyboardKey.enter) {
          log("e+$focus_index");
        }
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            for (int i = 0; i < widget.list_Files.length; i++)
              pdfCard(widget.list_Files[i], i == focus_index)
          ],
        ),
      ),
    );
  }
}
