import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Areas.dart';

part 'BeatEvent.dart';
part 'BeatState.dart';

class BeatBloc extends Bloc<BeatEvent, BeatState> {
  String beat = "--select--";
  Set<String> beat_List = {};
  BeatBloc() : super(BeatLoading()) {
    on<FetchBeatEvent>(_onFetchBeatEvent);
    on<UpdateBeatEvent>(_onUpdateBeatEvent);
  }
  _onFetchBeatEvent(FetchBeatEvent event, Emitter<BeatState> emit) async {
    log("hai");
    emit(BeatLoading());
    try {
      final temp = await Areas().GetLocations();
      beat_List = temp;
    } catch (e) {
      emit(BeatFetchError(message: e.toString()));
    }
    emit(BeatLoadComplete());
    log("complete");
  }

  _onUpdateBeatEvent(UpdateBeatEvent event, Emitter<BeatState> emit) {
    beat = event.beat;
  }
}
