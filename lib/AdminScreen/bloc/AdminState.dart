part of 'AdminBloc.dart';

sealed class AdminState extends Equatable {
  List<Object?> get props => [];
}

class OrderLoading extends AdminState {}

class OrderGotSucess extends AdminState {
  List<FirebaseOrder> orders;
  OrderGotSucess({required this.orders});
}

class OrderGotError extends AdminState {
  String message;
  OrderGotError({required this.message});
}
class SavingBills extends AdminState{
  String currentPath;
  int billNum;
  String det;
  SavingBills({required this.currentPath,required this.billNum,required this.det});
}
class SaveBillsSucess extends AdminState{
  int totalBills;
  String path;
  SaveBillsSucess({required this.path,required this.totalBills});
}
class AdminError extends AdminState{
  String message;
  AdminError({required this.message});
}