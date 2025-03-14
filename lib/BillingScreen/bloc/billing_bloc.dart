import 'dart:developer' as dev;
import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:tat_windows/Firebase/NewOrder.dart';
import 'package:tat_windows/Screens/Shops.dart';
import 'package:tat_windows/Widgets/Areas.dart';
import 'package:tat_windows/Widgets/Orders.dart';
import 'package:tat_windows/Widgets/comapnies.dart';
import 'package:tat_windows/billnumber.dart';

import '../../Beat/Areas.dart';
import '../../Products/model/Product.dart';
import '../../Widgets/Shops.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bill_model.dart';
part 'billing_event.dart';
part 'billing_state.dart';

class BillingBloc extends Bloc<BillingEvent, BillingState> {
  late int billNumber;
  late List<Product> products;
  late Shop current_shop;
  late List<Shop> list_of_shops = [];
  late List<String> companies;
  //final FetchShopsEvent fetchShopsEvent;
  BillingBloc() : super(BillingLoding()) {
    on<FetchProductEvent>(_onFetchProductEvent);
    on<FetchShopsEvent>(_onFetchShopsEvent);
    on<FetchBillNumberEvent>(_onFetchBillNumberEvent);
  }
  void _onFetchBillNumberEvent(
      FetchBillNumberEvent event, Emitter<BillingState> emit) async {
    emit(BillingLoding());
    try {
      billNumber = await getbillNumber();
    } catch (e) {
      emit(BillingError(message: e.toString()));
    }
    emit(BillingSucess());
  }

  void _onFetchShopsEvent(
      FetchShopsEvent event, Emitter<BillingState> emit) async {
    emit(BillingLoding());
    try {
      final locations = await Areas().GetLocations();
      for (var loc in locations) {
        final shops = await getShop(loc);
        for (var shop in shops) {
          list_of_shops.add(shop);
        }
      }
    } catch (e) {
      emit(BillingError(message: e.toString()));
    }
    emit(BillingSucess());
    dev.log("shopFetch Sucess");
  }

  Future<void> _onFetchProductEvent(
      FetchProductEvent event, Emitter<BillingState> emit) async {
    emit(BillingLoding());
    try {
      dev.log("productGetting");
      final tempProductList =
          await NewOrder().getProductByCompany("Amuruthajan");
      //dev.log(tempProductList!.length.toString());
      products = tempProductList!;
      print(products[0].productName);
      print(products[0].productName);
    } catch (e) {
      emit(BillingError(message: e.toString()));
    }
    emit(BillingSucess());
  }
}
