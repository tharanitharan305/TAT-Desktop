part of 'print_bloc.dart';

@immutable
sealed class PrintEvent extends Equatable {
  PrintEvent();
  List<Object> get props => [];
}

class FetchFilesEvent extends PrintEvent {
  String path;

  FetchFilesEvent({required this.path});
  List<Object> get props => [path];
}

class PrintFilesEvent extends PrintEvent {
  PrintFilesEvent();
  List<Object> get props => [];
}

class ResetListEvent extends PrintEvent {
  ResetListEvent();
}

class FocusChangeEvent extends PrintEvent {
  int dif;
  FocusChangeEvent({required this.dif});
}
