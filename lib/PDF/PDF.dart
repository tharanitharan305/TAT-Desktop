import 'package:firedart/generated/google/protobuf/timestamp.pb.dart';

import '../Widgets/Orders.dart';

class PDF {
  PDF(
      {required this.items,
      required this.Shopname,
      required this.useremail,
      required this.timestamp,
      required this.total,
      required this.Date,
      required this.location,
      required this.phno});
  List<Orders> items;
  String Date;
  String Shopname;
  String useremail;
  DateTime timestamp;
  String total;
  String location;
  String phno;
}
