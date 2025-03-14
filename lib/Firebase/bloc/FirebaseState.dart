part of 'FirebaseBloc.dart';

sealed class FirebaseState extends Equatable {
  FirebaseState();
  @override
  List<Object?> get props => [];
}

class FirebaseLoading extends FirebaseState {}

class FirebaseError extends FirebaseState {
  String message;
  FirebaseError({required this.message});
}

class FirebaseSucess extends FirebaseState {}

class FirebaseGotOrders extends FirebaseState {
  List<FirebaseOrder> order;
  FirebaseGotOrders({required this.order});
}
class FirebaseUserSucess extends FirebaseState{
  TatUser user;
  FirebaseUserSucess({required this.user});
}
class FirebaseOrderUploadError extends FirebaseState{
  String message;
  FirebaseOrderUploadError({required this.message});
}