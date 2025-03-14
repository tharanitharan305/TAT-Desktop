

import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:tat_windows/Beat/bloc/BeatBloc.dart';
import 'package:tat_windows/billnumber.dart';

part 'HiveEvent.dart';
part 'HiveState.dart';
class HiveBloc extends Bloc<HiveEvent,HiveState>{
  String tatPath="";
  String downloadPath="";
  int billNumber=0;

  HiveBloc():super(HiveLoading()){
on<FetchBillNumber>(_onFetchBillNumber);
    on<FetchDatePath>(_onFetchDatePath);
    on<FetchTatPath>(_onFetchTatPath);
    on<FetchPath>(_onFetchDownloadPath);
  }
  _onFetchTatPath(FetchTatPath event,Emitter<HiveState> emit)async{
    emit(HiveLoading());
    try{
      await Hive.openBox('appSettings').then((box) {
        tatPath=box.getAt(0)['tat path'];
      });
    }catch(e){
      emit(HiveError(message: e.toString()));
    }
    emit(HiveComplete(path: tatPath));
  }
  _onFetchBeatPath(FetchBeatPath event,Emitter<HiveState> emit) async {
    String returnPath="";
    try{
       returnPath = await Hive.openBox('appSettings').then((box) async {
        String tatPath = box.getAt(0)['tat path'];
        return '$tatPath/Bills/Beat/${event.beat}';
      });
    }catch(e){
      emit(HiveError(message: e.toString()));
    }
    log("In HiveBloc Emitting the beat path for ${event.beat} as $returnPath");
    emit(HiveComplete(path: returnPath));
  }
  _onFetchShopPath(FetchShopPath event,Emitter<HiveState> emit) async {
    String returnPath="";
    try{
      returnPath = await Hive.openBox('appSettings').then((box) async {
        String tatPath = box.getAt(0)['tat path'];
        return '$tatPath/Bills/Beat/${event.beat}/${event.shop}';
      });
    }catch(e){
      emit(HiveError(message: e.toString()));
    }
    log("In HiveBloc Emitting the shop path for ${event.shop} as $returnPath");
    emit(HiveComplete(path: returnPath));
  }
  _onFetchDownloadPath(FetchPath event,Emitter<HiveState> emit)async{
    emit(HiveLoading());
    try{
     final box= await Hive.openBox('appSettings');
     downloadPath=box.getAt(0)['path'];
    }catch(e){
      emit(HiveError(message: e.toString()));
    }
    emit(HiveComplete(path: downloadPath));
  }
  _onFetchDatePath(FetchDatePath event,Emitter<HiveState> emit)async{
    var returnPath;
    try{
       returnPath = await Hive.openBox('appSettings').then((box) async {
        String tatPath = box.getAt(0)['tat path'];
        return '$tatPath/Bills/ByDate/${event.date}';
      });
    }catch(e){
      emit(HiveError(message: e.toString()));
    }
    emit(HiveComplete(path: returnPath));
  }
  checkBillNumberUpdate(int billnumber) async {
    log("In HiveBloc checking billNumber updation current billnumber ${billnumber}");
    await Hive.openBox('billNumber').then((box) async {
      log("In HiveBloc box opened sucessfully in box bill number is ${await box.get('billNumber')}");
    },);

  }
  _onFetchBillNumber(FetchBillNumber event, Emitter<HiveState> emit) async {
    emit(HiveLoading());
    try {
      int currentBillNumber = await getbillNumber();
      int updatedBillNumber = await upDateBillNumber(currentBillNumber);  // Now returns new number
      emit(HiveComplete(billnumber: updatedBillNumber));  // Emit updated value
    } catch (e) {
      emit(HiveError(message: e.toString()));
    }
  }

}