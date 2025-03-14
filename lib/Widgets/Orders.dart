// import 'dart:ffi';
//
// class NewProduct {
//   NewProduct(
//       {required this.product_name,
//       required this.selling_price,
//       required this.mrp,
//       required this.quantity,
//       required this.free,
//       this.uid,
//       this.discound_in_per,
//       this.tax_in_per});
//
//   String product_name;
//   String selling_price;
//   String mrp;
//   String quantity;
//   String free;
//   String? uid;
//   double? discound_in_per = 0.0;
//   double? tax_in_per = 0.0;
//   Map<String, dynamic> toMap() {
//     return {
//       'Product_name': product_name,
//       'SellingPrice': selling_price,
//       "MRP": mrp,
//       "Quantity": quantity,
//       "Free": free,
//       "uid": uid,
//       "DiscoundInPer": discound_in_per,
//       "TaxInPPer": tax_in_per
//     };
//   }
// }
import 'dart:developer';

import 'package:tat_windows/Products/model/Product.dart';

class Order{
  Product product;
  double qty;
  double free;
  Order({
    required this.product,
    required this.qty,
    required this.free
});
  Map<String, dynamic> toMap() {
    return {...product.toMap(), 'qty': qty, 'free': free};
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    log("from Order from Map");
    print(map.values);
    log(map.length.toString());
    return Order(
      product: Product.fromMap(map), // Convert nested product data
      qty: (map['qty'] ?? 0.0).toDouble(),
      free: (map['free'] ?? 0.0).toDouble(),
    );
  }
}