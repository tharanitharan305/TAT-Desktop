import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart';
import 'package:tat_windows/Hive/Hive.dart';

import '../Beat/Areas.dart';
import 'Areas.dart';
import 'DateTime.dart';
import 'DropDown.dart';

class SilentPdfPrinter extends StatefulWidget {
  @override
  _SilentPdfPrinterState createState() => _SilentPdfPrinterState();
  SilentPdfPrinter({super.key});
}

class _SilentPdfPrinterState extends State<SilentPdfPrinter> {
  String _statusMessage = "Idle"; // Status message
  bool _isScanning = false;
  Set<String> locations = {};
  String selectedLocation = "--select--";
  String? path;
  String date = DateTimeTat().GetDate();
  List<String> timeList = [
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
  // Function to scan and print PDFs
  void _startScanAndPrint(String locationName) async {
    setState(() {
      _isScanning = true;
      _statusMessage = "Scanning started...";
    });

    String todayDate = date;
    // Root directory
    String rootPath = '$path/Bills';
    Directory locationDir = Directory('$rootPath/$selectedLocation');
    print(locationDir.path);
    if (!await locationDir.exists()) {
      _showMessage("Error", "Location folder not found!");
      setState(() {
        _isScanning = false;
      });
      return;
    }

    bool pdfFound = false;

    // Loop through shop folders
    for (var shop in locationDir.listSync()) {
      if (shop is Directory) {
        setState(() {
          _statusMessage = "Scanning: ${shop.path}";
        });

        for (var file in shop.listSync()) {
          if (file is File && file.path.endsWith('.pdf')) {
            String fileName = file.uri.pathSegments.last +
                "-" +
                file.uri.pathSegments
                    .elementAt(file.uri.pathSegments.length - 2);
            if (fileName.contains(todayDate)) {
              pdfFound = true;

              setState(() {
                _statusMessage = "Printing: $fileName";
              });

              // Print silently using the Windows 'print' command
              await _printPDFSilently(file.path);

              _showMessage("Printed", "Successfully printed: $fileName");
            }
          }
        }
      }
    }

    if (!pdfFound) {
      _showMessage("Completed", "No PDF with today's date found.");
    }

    setState(() {
      _isScanning = false;
      _statusMessage = "Scanning completed.";
    });
  }

  // Silent print using Windows 'print' command
  Future<void> _printPDFSilently(String filePath) async {
    try {
      await Process.run('cmd', ['/c', 'print', '/d:LPT1', filePath],
          runInShell: true);
    } catch (e) {
      _showMessage("Error", "Failed to print: $e");
    }
  }

  // Function to show pop-up messages
  void _showMessage(String title, String content) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("OK"),
          )
        ],
      ),
    );
  }

  setup() async {
    final dup = await Areas().GetLocations();
    final pathDupe = await getTatPath();
    setState(() {
      locations = dup;
      path = pathDupe;
    });
  }

  onChangedDateTime(value) {
    setState(() {
      date = value;
    });
  }

  onChangedLocation(value) {
    setState(() {
      selectedLocation = value;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setup();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController locationController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text("Silent PDF Printer"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: DropdownTat(
                dropdownValue: selectedLocation,
                set: locations,
                onChanged: onChangedLocation),
          ),
          DropdownTat(
              dropdownValue: date,
              set: timeList.toSet(),
              onChanged: onChangedDateTime),
          ElevatedButton(
            onPressed: () {
              if (selectedLocation.isNotEmpty) {
                _startScanAndPrint(locationController.text);
              } else {
                _showMessage("Input Error", "Please enter a location name.");
              }
            },
            child: Text("Start Scan & Print"),
          ),
          SizedBox(height: 20),
          Text(_statusMessage),
        ],
      ),
    );
  }
}
