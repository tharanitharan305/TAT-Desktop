import 'dart:io';

import 'package:firedart/firestore/firestore.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tat_windows/PDF/PDF.dart';

Future<String> GenerateSql(Pdf pdf) async {
  final data = pdf.toMap();
  String columns = data.keys.join(", ");
  String values = data.values.map((value) => "'$value'").join(", ");
  return "INSERT INTO users ($columns) VALUES ($values);";
}

Future<void> saveSQLToFile(String sqlStatement) async {
  final directory = await getApplicationDocumentsDirectory();
  print(directory);
  final file = File('${directory.path}/user_data.sql');
  await file.writeAsString(sqlStatement);
  print(file.path);
}
