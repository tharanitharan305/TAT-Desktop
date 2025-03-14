part of 'Hivebloc.dart';
sealed class HiveEvent extends Equatable{
  List<Object?> get props=>[];
}
class FetchBillNumber extends HiveEvent{}
class FetchTatPath extends HiveEvent{}
class FetchPath extends HiveEvent{}
class FetchDatePath extends HiveEvent{
  String date;
  FetchDatePath({required this.date});
}
class UpdatePath extends HiveEvent{
  String path;
  String feild;
  UpdatePath({required this.feild,required this.path});
}
class SetUpApp extends HiveEvent{

}
class FetchBeatPath extends HiveEvent{
  String beat;
  FetchBeatPath({required this.beat});
}
class FetchShopPath extends HiveEvent{
  String beat;
  String shop;
  FetchShopPath({required this.beat,required this.shop});
}