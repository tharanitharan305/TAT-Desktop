part of 'print_bloc.dart';

@immutable
sealed class PrintState extends Equatable {
  const PrintState();
  List<Object> get props => [];
}

class PrintingFile extends PrintState {
  String cur_path;
  PrintingFile({required this.cur_path});

  @override
  List<Object> get props => [cur_path];
}

class PrintFinished extends PrintState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class PrintError extends PrintState {
  String message;
  PrintError({required this.message});
  List<Object> get props => [message];
}

class PrintLoading extends PrintState {
  const PrintLoading();
}

class FetchSucess extends PrintState {
  List<File> file_list;
  String focus_path;
  FetchSucess({required this.file_list, required this.focus_path});
  //const FetchSucess();
}

class ResetSucess extends PrintState {
  const ResetSucess();
}

class FosucChanged extends PrintState {
  List<File> file_list;
  String focus_path;
  FosucChanged({required this.file_list, required this.focus_path});
}
