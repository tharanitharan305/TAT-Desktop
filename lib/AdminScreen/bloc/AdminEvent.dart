part of 'AdminBloc.dart';

sealed class AdminEvent extends Equatable {
  List<Object?> get props => [];
}

class FetchListOfOrdersEvent extends AdminEvent {
  String beat;
  FetchListOfOrdersEvent({required this.beat});
}

class DeleteOrderEvent extends AdminEvent {
  String uid;
  String beat;
  DeleteOrderEvent({required this.beat, required this.uid});
}

class FirebaseEventLoading extends AdminEvent {}

class FirebaseEventError extends AdminEvent {
  String message;
  FirebaseEventError({required this.message});
}

class UpdateDateEvent extends AdminEvent {
  String date;
  UpdateDateEvent({required this.date});
}

class ConvertOrderFromFireEvent extends AdminEvent {
  List<FirebaseOrder> order;
  ConvertOrderFromFireEvent({required this.order});
}
class SaveBillsAsPdfEvent extends AdminEvent{
  List<FirebaseOrder> orders;
  SaveBillsAsPdfEvent({required this.orders});
}
