import 'package:intl/intl.dart';

class DateTimeTat {
  String GetDate() {
    var now = new DateTime.now();

    String formattedDate = now.day.toString() +
        "." +
        now.month.toString() +
        "." +
        now.year.toString();
    return formattedDate;
  }

  String GetpreDate(int i) {
    var now = new DateTime.now().subtract(Duration(days: i));

    String formattedDate = (now.day).toString() +
        "." +
        now.month.toString() +
        "." +
        now.year.toString();
    return formattedDate;
  }
}
