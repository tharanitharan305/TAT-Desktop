import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:tat_windows/BillingScreen/bloc/billing_bloc.dart';
import '../Beat/bloc/BeatBloc.dart';
import '../Firebase/models/OrderFormat.dart';
import '../PDF/PDF.dart';
import '../Beat/Areas.dart';

import '../Widgets/DateTime.dart';
import '../Widgets/DropDown.dart';

import '../Widgets/OrderviewCard.dart';
import 'bloc/AdminBloc.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() {
    return _AdminScreen();
  }
}

class _AdminScreen extends State<AdminScreen> {
  // String DropDownView = "Karur_Local";
  // String Location = "Karur_Local";
  // List<Order> fromBase = [];
  // List<String> send = [];
  // String Today = DateTimeTat().GetDate();
  // String dayTotal = "0";

  // Set<String> locations = {};
  // SetLocation() async {
  //   final tempLoc = await Areas().GetLocations();
  //   setState(() {
  //     locations = tempLoc;
  //   });
  // }
  //
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   SetLocation();
  // }
  //
  // @override
  // Widget build(context) {
  //   return SafeArea(
  //     child: Scaffold(
  //       appBar: AppBar(
  //         backgroundColor: Theme.of(context).colorScheme.surface,
  //         shape: const RoundedRectangleBorder(),
  //         actions: [
  //           DropdownButton(
  //               elevation: 50,
  //               autofocus: true,
  //               dropdownColor: Theme.of(context).colorScheme.surface,
  //               borderRadius: BorderRadius.circular(20),
  //               value: DropDownView,
  //               items: locations
  //                   .map((e) => DropdownMenuItem(
  //                         value: e,
  //                         key: UniqueKey(),
  //                         child: Text(e),
  //                       ))
  //                   .toList(),
  //               onChanged: (values) {
  //                 setState(() {
  //                   DropDownView = values!;
  //                   Location = values.toString();
  //                 });
  //               }),
  //           SizedBox(
  //             width: 20,
  //           ),
  //           DropdownButton(
  //               elevation: 50,
  //               autofocus: true,
  //               dropdownColor: Theme.of(context).colorScheme.surface,
  //               borderRadius: BorderRadius.circular(20),
  //               value: Today,
  //               items: Time.map((e) => DropdownMenuItem(
  //                     value: e,
  //                     key: UniqueKey(),
  //                     child: Text(e),
  //                   )).toList(),
  //               onChanged: (values) {
  //                 setState(() {
  //                   Today = values!;
  //                 });
  //               })
  //         ],
  //       ),
  //       body: StreamBuilder(
  //         stream: cloud.FirebaseFirestore.instance
  //             .collection(Location)
  //             .where('Date', isEqualTo: Today)
  //             .orderBy('Ordered time')
  //             .snapshots(),
  //         builder: (context, OrderSnapCuts) {
  //           if (OrderSnapCuts.connectionState == ConnectionState.waiting) {
  //             return Center(child: SplashScreen());
  //           }
  //           if (!OrderSnapCuts.hasData || OrderSnapCuts.data!.docs.isEmpty) {
  //             return Center(
  //               child: Text('No Orders Found at $Location'),
  //             );
  //           }
  //           if (OrderSnapCuts.hasError) {
  //             return const Center(
  //                 child: Text(
  //                     'An Error Occured Try To Restart or Contact +91 9787874607'));
  //           }
  //           final RecivedOrders = OrderSnapCuts.data!.docs;
  //
  //           return ListView.builder(
  //             itemCount: RecivedOrders.length,
  //             itemBuilder: (context, index) {
  //               var filteredOrder = "";
  //               var order =
  //                   RecivedOrders[index].data()['Orders'].toString().split(",");
  //               // OrderFormat().ViewFormat(order);
  //               for (int i = 0; i < order.length; i++) {
  //                 if (!order[i].endsWith('null')) {
  //                   filteredOrder += order[i];
  //                 }
  //               }
  //               send = filteredOrder.split(";");
  //               fromBase = OrderFormat().ViewFormat(send);
  //               return Column(
  //                 children: [
  //                   GestureDetector(
  //                     onLongPress: () {
  //                       PDF pdf = PDF(
  //                         Date: RecivedOrders[index].data()['Date'],
  //                         items: fromBase,
  //                         Shopname: RecivedOrders[index].data()['Shopname'],
  //                         useremail: RecivedOrders[index].data()['Ordered by'],
  //                         timestamp:
  //                             RecivedOrders[index].data()['Ordered time'],
  //                         total: RecivedOrders[index].data()['Total'],
  //                       );
  //                       showDialog(
  //                         context: context,
  //                         builder: (context) => AlertDialog(
  //                           title: Text("Conformation.."),
  //                           content: Text("Confirm to get bill"),
  //                           actions: [
  //                             TextButton(
  //                                 onPressed: () {
  //                                   Navigator.pop(context);
  //                                 },
  //                                 child: Text('Cancel')),
  //                             TextButton(
  //                                 onPressed: () async {
  //                                   PdfGenerator(
  //                                     pdf: pdf,
  //                                   ).generatePdf();
  //                                   Navigator.pop(context);
  //                                 },
  //                                 child: Text("Get Bill"))
  //                           ],
  //                         ),
  //                       );
  //                     },
  //                     child: OrderViewCard(
  //                       items: fromBase,
  //                       Shopname: RecivedOrders[index].data()['Shopname'],
  //                       useremail: RecivedOrders[index].data()['Ordered by'],
  //                       timestamp: RecivedOrders[index].data()['Ordered time'],
  //                       total: RecivedOrders[index].data()['Total'],
  //                       uid: RecivedOrders[index].data()['uid'],
  //                       location: Location,
  //                       phno: RecivedOrders[index].data()['Shop PhoneNumer'] ??
  //                           "NO PHONE NUMBERs",
  //                     ),
  //                   )
  //                 ],
  //               );
  //             },
  //           );
  //         },
  //       ),
  //       floatingActionButton: FloatingActionButton(
  //         onPressed: () {
  //           showModalBottomSheet(
  //             context: context,
  //             builder: (context) {
  //               return Info();
  //             },
  //           );
  //         },
  //         child: Icon(Icons.currency_rupee),
  //       ),
  //     ),
  //   );
  // }
  List<String> Time = [
    DateTimeTat().GetpreDate(0),
    DateTimeTat().GetpreDate(1),
    DateTimeTat().GetpreDate(2),
    DateTimeTat().GetpreDate(3),
    DateTimeTat().GetpreDate(4),
    DateTimeTat().GetpreDate(5),
    DateTimeTat().GetpreDate(6),
    DateTimeTat().GetpreDate(7),
    DateTimeTat().GetpreDate(8),
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<BeatBloc>().add(FetchBeatEvent());
  }

  initiateFetch(value) {
    context.read<AdminBloc>().add(FetchListOfOrdersEvent(beat: value));
  }

  beatShow() {
    return BlocBuilder<BeatBloc, BeatState>(
      builder: (context, state) {
        final bloc = context.read<BeatBloc>();
        if (state is BeatLoading) {
          return const Center(
            child: Text("Loading..."),
          ); //const CircularProgressIndicator();
        } else if (state is BeatLoadComplete) {
          return DropdownTat(
              dropdownValue: bloc.beat,
              set: bloc.beat_List,
              onChanged: (value) {
                log(bloc.beat);
                bloc.add(UpdateBeatEvent(beat: value!));
                setState(() {});
                Future.delayed(Duration.zero, initiateFetch(value));
              });
        } else if (state is BeatFetchError) {
          return Center(
            child: Text(state.message),
          );
        }
        return Text("$state");
      },
    );
  }

  showOrders(List<FirebaseOrder> orders) {
    log("in showOrders");
    return SingleChildScrollView(
      child: Column(
        children: [
          ...orders.map(
            (e) => OrderViewCard(order: e,
                ),
          )
        ],
      ),
    );
  }

  buildUi(List<FirebaseOrder>? orders, Widget? error) {
    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(onPressed: orders==null?null:(){
context.read<AdminBloc>().add(SaveBillsAsPdfEvent(orders: orders));
                    }, icon: Icon(Icons.download_rounded)),
          beatShow(),
          Flexible(
            child: DropdownTat(
                dropdownValue: context.read<AdminBloc>().date,
                set: Time.toSet(),
                onChanged: (value) {
                  context.read<AdminBloc>().add(UpdateDateEvent(date: value!));
                  context.read<AdminBloc>().add(FetchListOfOrdersEvent(beat: context.read<BeatBloc>().beat,));
                  setState(() {});
                }),
          )
        ],
      ),
      body: error ??
          (orders == null
              ? const Center(
                  child: Text("SELECT A BEAT AND DATE"),
                )
              : showOrders(orders)),
    );
  }

  Widget build(BuildContext contex) {
    return BlocBuilder<AdminBloc, AdminState>(builder: (context, state) {
      if (state is OrderGotError) {
        log(state.message);
        return buildUi(
            null,
            Center(
              child: Text(state.message),
            ));
      }
      if (state is OrderLoading) {
        return buildUi(
            null,
             const Center(
              child: SpinKitThreeBounce(color: Colors.amber,
              size: 20,
            ),
            ));
      }
      if (state is OrderGotSucess) {
        return buildUi(state.orders, null);
      }
      log("can't catch the state : ${state}");
      return buildUi(null,
          const Center(child: Text("Select Other Beat or Restart the app")));
    });
  }
}
