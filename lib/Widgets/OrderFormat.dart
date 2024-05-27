import 'Orders.dart';

class OrderFormat {
  List<Orders> ViewFormat(List<String> items) {
    List<Orders> fromBase = [];
    for (int i = 0; i < items.length - 1; i++) {
      if (items[i] != null) {
        Orders o = Orders(
            Products: items[i].split("-")[0],
            SellingPrice: items[i].split("-")[1],
            MRP: items[i].split("-")[4],
            Quantity: items[i].split("-")[2].toString(),
            Free: items[i].split("-")[3]);
        fromBase.add(o);
      }
    }
    return fromBase;
  }
}
