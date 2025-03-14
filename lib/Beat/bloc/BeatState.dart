part of 'BeatBloc.dart';

@immutable
sealed class BeatState extends Equatable {
  @override
  List<Object> get props => [];
}

class BeatLoading extends BeatState {}

class BeatFetchSucess extends BeatState {
  Set<String> beat_set;
  BeatFetchSucess({required this.beat_set});
}

class BeatLoadComplete extends BeatState {}

class BeatFetchError extends BeatState {
  String message;
  BeatFetchError({required this.message});
}
