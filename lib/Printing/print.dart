import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:printing/printing.dart';
import 'package:flutter/services.dart';
import 'package:tat_windows/BillingScreen/bloc/billing_bloc.dart';
import 'package:tat_windows/Hive/Hive.dart';
import 'package:tat_windows/Printing/Bloc/print_bloc.dart';
import 'package:tat_windows/Products/Widgets/Product_Getter.dart';
import 'package:tat_windows/Screens/splashScreen.dart';
import 'package:tat_windows/Widgets/DateTime.dart';
import 'package:tat_windows/Widgets/DropDown.dart';

import 'Widgets/ListPrintFiles.dart';

Future<void> printAllPdfs(String directoryPath) async {
  final dir = Directory(directoryPath);

  if (!await dir.exists()) {
    print("Directory does not exist.");
    return;
  }

  // Get all PDF files from the directory
  List<FileSystemEntity> pdfFiles = dir.listSync().where((file) {
    return file.path.endsWith('.pdf');
  }).toList();

  if (pdfFiles.isEmpty) {
    print("No PDF files found.");
    return;
  }

  // Print each PDF one by one
  for (var file in pdfFiles) {
    print("Printing: ${file.path}");

    try {
      final pdfData = await File(file.path).readAsBytes();
      await Printing.layoutPdf(
        onLayout: (format) => pdfData,
      );
    } catch (e) {
      print("Error printing ${file.path}: $e");
    }
  }
}

class PrintingFiles extends StatefulWidget {
  PrintingFiles({super.key});

  @override
  State<PrintingFiles> createState() => _PrintingFilesState();
}

class _PrintingFilesState extends State<PrintingFiles> {
  late String path;
  String date = DateTimeTat().GetDate();
  Set<String> dateTime = {
    DateTimeTat().GetpreDate(0),
    DateTimeTat().GetpreDate(1),
    DateTimeTat().GetpreDate(2),
    DateTimeTat().GetpreDate(3),
    DateTimeTat().GetpreDate(4),
    DateTimeTat().GetpreDate(5),
    DateTimeTat().GetpreDate(6),
  };
  void onChageDate(String? selectedDate) async {
    context.read<PrintBloc>().add(ResetListEvent());
    setState(() {
      date = selectedDate!;
    });
    context
        .read<PrintBloc>()
        .add(FetchFilesEvent(path: await getDatePath(date)));
  }

  void pathSetup() async {
    final dupPath = await getDatePath(date);
    setState(() {
      path = dupPath;
    });
    log("message");
    context.read<PrintBloc>().add(FetchFilesEvent(path: path));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pathSetup();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        context.read<PrintBloc>().add(PrintFilesEvent());
      }),
      body: Column(
        children: [
          DropdownTat(
              dropdownValue: date, set: dateTime, onChanged: onChageDate),
          BlocBuilder(
            bloc: context.read<PrintBloc>(),
            builder: (context, state) {
              if (state is PrintLoading) {
                return Center(
                  child: SplashScreen(width: 100, height: 100),
                );
              } else if (state is PrintError) {
                return Center(
                  child: Text(state.message),
                );
              } else if (state is PrintingFile) {
                return Center(
                  child: Column(
                    children: [
                      Text("Current File ${state.cur_path}"),
                      SplashScreen(width: 100, height: 100)
                    ],
                  ),
                );
              } else if (state is PrintFinished && state is! ResetSucess) {
                context.read<PrintBloc>().add(ResetListEvent());
              } else if (state is FetchSucess) {
                log("fetchSucess");
                return Listprintfiles(
                  list_Files: state.file_list,
                );
              }
              return Text("Print Sucess");
            },
          ),
        ],
      ),
    );
  }
}
