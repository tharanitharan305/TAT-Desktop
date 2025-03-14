import 'dart:developer';

import 'package:firedart/auth/firebase_auth.dart';
import 'package:firedart/firestore/firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../models/OrderFormat.dart';
import '../models/User.dart';

part 'FirebaseEvent.dart';
part 'FirebaseState.dart';

class FirebaseBloc extends Bloc<FirebaseEvent, FirebaseState> {
  TatUser? user;
  final store = Firestore.instance;
  FirebaseBloc() : super(FirebaseLoading()) {
    on<AddOrderToFirebaseEvent>(_onAddOrderToFirebaseEvent);
    on<OnUserEntersEvent>(_onUserEnterEvent);
    on<GetOrderFromFireBase>(_onGetOrderOnFirebase);
  }

  _onAddOrderToFirebaseEvent(
      AddOrderToFirebaseEvent event, Emitter<FirebaseState> emit) async {
    emit(FirebaseLoading());
    log("beat:${event.order.beat}");
    try {
      await store
          .collection(event.order.beat)
          .document(event.order.uid)
          .set(event.order.toMap());
    } catch (e) {
      log("Error caused in AddOrderToFirebase method in firebase bloc${e.toString()}");
      emit(FirebaseOrderUploadError(message: e.toString()));
      return;
    }
    log("Success");
    emit(FirebaseSucess());
    log("hai");
  }

  _onUserEnterEvent(OnUserEntersEvent event, Emitter<FirebaseState> emit) {
    user = event.user;
    log("${event.user.userName} logged in");
  }

  _onGetOrderOnFirebase(
      GetOrderFromFireBase event, Emitter<FirebaseState> emit) async {
    log("in GetOrderFromFire");
    emit(FirebaseLoading());
    List<FirebaseOrder> orders = [];
    try {
      log("getting from store for beat:${event.beat}");
      final list = await store.collection(event.beat).where('Date', isEqualTo: event.date).get();
      final fireDoc = list;
      if (fireDoc.isEmpty) {
        throw Exception("No Orders in the Beat ${event.beat} at Date ${event.date} ");
      }
      log("Number of Orders: ${fireDoc.length}");

      for (int i = 0; i < fireDoc.length; i++) {
        final val = fireDoc[i].map;

        try {
          final overFire = FirebaseOrder.fromMap(val);
          orders.add(overFire);
        } catch (e, stackTrace) {
          log("⚠️ Error converting FirebaseOrder: $e");
          emit(FirebaseError(message: "INTERNAL ERROR:${e.toString()}"));
          return;
        }
      }

      log("Parsed order length: ${orders.length}");

      emit(FirebaseGotOrders(order: orders));
    } catch (e, stackTrace) {
      log("❌ Error fetching orders: $e");
      emit(FirebaseError(message: e.toString()));
      log("emitted the error $e");
    }
  }

  _OnCreateAccountEvent(CreateAccountEvent event, Emitter<FirebaseState> emit) async {
    emit(FirebaseLoading());
    try {
      final auth = FirebaseAuth.instance;
      final user = await auth.signUp(event.user.userEmail, event.password);
      await store.collection('Employees').document(event.user.userName).set({
        'UserName': event.user.userName,
        'email': event.user.userEmail,
        "Sales": event.user.overAllSales,
        "Days of Present": event.user.daysOfPresent,
        "Job": event.user.jobType,
        "Lat": 0,
        "Long": 0
      });
    } catch (e) {
      emit(FirebaseError(message: e.toString()));
    }
    emit(FirebaseUserSucess(user: event.user));
  }
}