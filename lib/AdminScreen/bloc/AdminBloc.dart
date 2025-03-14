import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tat_windows/Hive/bloc/Hivebloc.dart';
import 'package:tat_windows/PDF/PdfGenerator.dart';

import '../../Firebase/bloc/FirebaseBloc.dart';
import '../../Firebase/models/OrderFormat.dart';
import '../../PDF/PDF.dart';
import '../../Widgets/DateTime.dart';

part 'AdminEvent.dart';
part 'AdminState.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  FirebaseBloc firebaseBloc;
  HiveBloc hiveBloc;
  String date = DateTimeTat().GetDate();
  late StreamSubscription firebaseSubscription;
  AdminBloc({required this.firebaseBloc,required this.hiveBloc}) : super(OrderLoading()) {
    firebaseSubscription = firebaseBloc.stream.listen(
      (state) {
        if (state is FirebaseLoading) {
          add(FirebaseEventLoading());
        }
        if (state is FirebaseError) {
          log("Error passed to AdminBloc");
          add(FirebaseEventError(message: state.message));
        }
        if (state is FirebaseGotOrders) {
          log("list of orders emitted from admin bloc with length : ${state.order.length}");
          add(ConvertOrderFromFireEvent(order: state.order));
        }
      },
    );
    on<FirebaseEventLoading>(
      (event, emit) => emit(OrderLoading()),
    );
    on<FirebaseEventError>(
      (event, emit) => emit(OrderGotError(message: event.message)),
    );
    on<ConvertOrderFromFireEvent>(
      (event, emit) => emit(OrderGotSucess(orders: event.order)),
    );
    on<UpdateDateEvent>(_onUpdateDateEvent);
    on<FetchListOfOrdersEvent>(_onFetchOrderFromFirebaseEvent);
    on<SaveBillsAsPdfEvent>(_onSaveBillsAsPdfEvent);
  }
  _onUpdateDateEvent(UpdateDateEvent event, Emitter<AdminState> emit) {
    date = event.date;
    //AdminBloc(firebaseBloc: firebaseBloc).add(FetchListOfOrdersEvent(beat: ))
  }

  _onFetchOrderFromFirebaseEvent(
      FetchListOfOrdersEvent event, Emitter<AdminState> emit) {
    emit(OrderLoading());
    firebaseBloc.add(GetOrderFromFireBase(beat: event.beat, date: date));
  }
  _onSaveBillsAsPdfEvent(SaveBillsAsPdfEvent event, Emitter<AdminState> emit) async {
    List<Pdf> pdfList = [];

    try{
      for (int i = 0; i < event.orders.length; i++) {
        final completer = Completer<void>();
        hiveBloc.add(FetchBillNumber());
        final subscription = hiveBloc.stream.listen((state) {
          if (state is HiveComplete) {
            Pdf pdf =
                Pdf(order: event.orders[i], billNumber: state.billnumber!);
            pdfList.add(pdf);
            log("In AdminBloc in Hive stream with bill number ${state.billnumber!}");
            completer.complete(); // Mark as completed
          }
        });
        await completer.future; // Ensure sequential execution
        await subscription.cancel(); // Cleanup
        for (int i = 0; i < pdfList.length; i++) {
         final path= await generatePdf(pdfList[i]);
         log("In AdminBloc Pdf saved in $path");
        }
      }
    }catch(e){
      emit(AdminError(message: e.toString()));
    }

    log("IN AdminBloc Successfully created pdf list with length of ${pdfList.length}");
  }

}
