import 'package:firedart/generated/google/protobuf/timestamp.pb.dart';
import 'package:tat_windows/Firebase/models/OrderFormat.dart';

import '../Products/model/Product.dart';
import '../Widgets/Orders.dart';

class Pdf {
  Pdf(
      {required this.order,
      required this.billNumber});
FirebaseOrder order;
  int billNumber;
  Map<String, dynamic> toMap() {
    return {
      'order':order.toMap(),
      "Bill Number":billNumber
    };
  }
}
