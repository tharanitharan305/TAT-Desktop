part of 'FirebaseBloc.dart';

sealed class FirebaseEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddOrderToFirebaseEvent extends FirebaseEvent {
  FirebaseOrder order;
  AddOrderToFirebaseEvent({required this.order});
}

class OnUserEntersEvent extends FirebaseEvent {
  TatUser user;
  OnUserEntersEvent({required this.user});
}

class GetOrderFromFireBase extends FirebaseEvent {
  String beat;
  String date;
  GetOrderFromFireBase({required this.beat, required this.date});
}
class CreateAccountEvent extends FirebaseEvent{
  TatUser user;
  String password;
  CreateAccountEvent({required this.user,required this.password});
}