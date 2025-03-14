part of 'BeatBloc.dart';

@immutable
sealed class BeatEvent extends Equatable {
  List<Object> get props => [];
}

class FetchBeatEvent extends BeatEvent {}

class UpdateBeatEvent extends BeatEvent {
  String beat;
  UpdateBeatEvent({required this.beat});
}
