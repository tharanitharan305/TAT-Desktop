import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:tat_win/Hive/Hive.dart';
import 'package:tat_win/Widgets/filePathPicker.dart';

import '../main.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  late String path;
  late String tatPath;
  bool isWorking = false;
  @override
  void initState() {
    super.initState();
    // Call setup() method in initState() and await its completion
    _setup();
  }

  Future<void> _setup() async {
    setState(() {
      isWorking = true;
    });
    final tempPath = await getPath();
    final temptatPath = await getTatPath();
    setState(() {
      path = tempPath;
      tatPath = temptatPath;
    });
    setState(() {
      isWorking = false;
    });
  }

  Future<void> _openFilePicker() async {
    final result = await FilePicker.platform.getDirectoryPath();

    if (result != null) {
      String filePath = result;
      updateTatPath(filePath);
      print('Selected file path: $filePath');
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            if (isWorking) Center(child: CircularProgressIndicator()),
            if (!isWorking)
              TextFormField(
                maxLines: 1,
                initialValue: path,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
            if (!isWorking)
              TextButton(onPressed: _openFilePicker, child: Text('Browse')),
            if (!isWorking)
              TextFormField(
                maxLines: 1,
                initialValue: tatPath,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
            if (!isWorking)
              TextButton(onPressed: _openFilePicker, child: Text('Browse'))
          ],
        ),
      ),
    );
  }
}
