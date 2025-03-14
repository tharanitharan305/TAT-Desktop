part of 'Hivebloc.dart';
sealed class HiveState extends Equatable{
  List<Object?> get props=>[];
}
class HiveLoading extends HiveState{}
class HiveComplete extends HiveState{
  int? billnumber;
  String? path;
  HiveComplete({this.path,this.billnumber});
}
class HiveError extends HiveState{
  String message;
  HiveError({required this.message});
}