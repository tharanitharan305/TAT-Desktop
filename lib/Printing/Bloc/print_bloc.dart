import 'dart:developer';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

part 'print_event.dart';
part 'print_state.dart';

class PrintBloc extends Bloc<PrintEvent, PrintState> {
  String cur_path = "";
  List<File> files = [];
  late String focus_path;
  late int focus_index;
  PrintBloc() : super(PrintLoading()) {
    on<FetchFilesEvent>(_onFetchFilesEvent);
    on<PrintFilesEvent>(_onPrintFilesEvent);
    on<ResetListEvent>(_onResetListEvent);
    on<FocusChangeEvent>(_onFocusChangeEvent);
  }
  void _onFetchFilesEvent(
      FetchFilesEvent event, Emitter<PrintState> emit) async {
    emit(PrintLoading());
    try {
      final folder = Directory(event.path);
      final list = folder.listSync();
      for (int i = 0; i < list.length; i++) {
        final file = File(list[i].path);
        if (files.contains(file)) {
          log("found");
        }
        files.addIf(!files.contains(file), file);
      }
      focus_index = 0;
      focus_path = list[focus_index].path;
    } catch (e) {
      emit(PrintError(message: e.toString()));
    }
    emit(FetchSucess(file_list: files, focus_path: focus_path));
  }

  void _onPrintFilesEvent(
      PrintFilesEvent event, Emitter<PrintState> emit) async {
    emit(PrintLoading()); // Indicate the process has started

    try {
      for (int i = 0; i < files.length; i++) {
        String curPath = files[i].path;
        log(files.length.toString());
        emit(PrintingFile(cur_path: curPath));
        await Future.delayed(Duration(seconds: 2));
        ProcessResult result = await Process.run("print", [curPath]);
        if (result.exitCode != 0) {
          throw Exception("Printing failed for $curPath: ${result.stderr}");
        }
      }

      emit(PrintFinished()); // Notify that all files have been printed
    } catch (e) {
      emit(PrintError(message: e.toString())); // Catch and emit error state
    }
  }

  void _onResetListEvent(ResetListEvent event, Emitter<PrintState> emit) {
    emit(PrintLoading());
    try {
      files = [];
    } catch (e) {
      emit(PrintError(message: e.toString()));
    }
    emit(ResetSucess());
  }

  void _onFocusChangeEvent(FocusChangeEvent event, Emitter<PrintState> emit) {
    try {
      if (event.dif > 0) {
      } else if (event.dif < 0) {
        focus_index--;
      }

      focus_path = files[focus_index].path;

      emit(FetchSucess(file_list: files, focus_path: focus_path));
    } catch (e) {
      emit(PrintError(message: e.toString()));
    }
  }
}
