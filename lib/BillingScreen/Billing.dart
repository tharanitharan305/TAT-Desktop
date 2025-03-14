import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tat_windows/BillingScreen/bloc/billing_bloc.dart';
import 'package:tat_windows/Screens/splashScreen.dart';

class Billing extends StatefulWidget {
  const Billing({super.key});

  @override
  State<Billing> createState() => _BillingState();
}

class _BillingState extends State<Billing> {
  final billDetailsFocus = FocusNode();
  final suggestionFocus = FocusNode();
  final billTableFocus = FocusNode();
  final contextFocus = FocusNode();
  final shopNameController = TextEditingController();
  shopName() => Row(
        children: [
          Text("Shop Name :"),
          Expanded(
            child: TextField(
              controller: shopNameController,
            ),
          )
        ],
      );
  billDetails() {
    return Column(
      children: [
        Text("Bill No: ${context.read<BillingBloc>().billNumber}"),
        shopName()
      ],
    );
  }

  suggextShop() {
    return SingleChildScrollView(
      child: Table(
        children: [
          ...context.read<BillingBloc>().list_of_shops.map((e) {
            return TableRow(children: [Text(e.name)]);
          }).toList()
        ],
      ),
    );
  }

  buildUi(Size size) {
    return Container(
      height: size.height,
      width: size.width,
      child: Column(
        children: [
          Row(
            children: [
              KeyboardListener(
                focusNode: billDetailsFocus,
                onKeyEvent: (event) {
                  if (event is KeyDownEvent) {
                    if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
                      log("up Key Pressed billdetails");
                      FocusScope.of(context).requestFocus(billTableFocus);
                    }
                    if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
                      log("Down Key Pressed billdetails");
                      FocusScope.of(context).requestFocus(billTableFocus);
                    }
                    if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
                      log("Right Key Pressed billdetails");
                      FocusScope.of(context).requestFocus(suggestionFocus);
                    }
                    if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
                      log("Left Key Pressed billdetails");
                      FocusScope.of(context).requestFocus(suggestionFocus);
                    }
                  }
                },
                child: Container(
                  height: size.height * 0.20,
                  width: size.width * 0.50,
                  color: billDetailsFocus.hasFocus
                      ? Colors.pinkAccent
                      : Colors.amberAccent,
                  child: billDetails(),
                ),
              ),
              Focus(
                focusNode: suggestionFocus,
                child: Container(
                  height: size.height * 0.20,
                  width: size.width * 0.50,
                  color: suggestionFocus.hasFocus
                      ? Colors.pinkAccent
                      : Colors.amberAccent,
                  child: suggextShop(),
                ),
              )
            ],
          ),
          Focus(
            focusNode: billTableFocus,
            child: Container(
              height: size.height * 0.80,
              width: size.width,
              color: billTableFocus.hasFocus
                  ? Colors.pinkAccent
                  : Colors.amberAccent,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    billDetailsFocus.dispose();
    suggestionFocus.dispose();
    billTableFocus.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    contextFocus.requestFocus();
    context.read<BillingBloc>().add(FetchShopsEvent());
    context.read<BillingBloc>().add(FetchBillNumberEvent());
    log(context.read<BillingBloc>().list_of_shops.length.toString());
  }

  @override
  Widget build(BuildContext context) {
    return FocusScope(
      child: KeyboardListener(
        focusNode: contextFocus,
        //autofocus: true,
        //includeSemantics: true,
        onKeyEvent: (event) {
          if (event is KeyDownEvent) {
            if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
              log("up");

              FocusScope.of(context).requestFocus(billDetailsFocus);
              setState(() {});
            }
            if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
              log("Down Key Pressed");
              FocusScope.of(context).requestFocus(billTableFocus);
              setState(() {});
            }
            if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
              log("Right Key Pressed");
              FocusScope.of(context).requestFocus(suggestionFocus);
              setState(() {});
            }
            if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
              log("Left Key Pressed");
              FocusScope.of(context).requestFocus(billDetailsFocus);
              setState(() {});
            }
            if (event.logicalKey == LogicalKeyboardKey.enter) {
              if (FocusScope.of(context).focusedChild == billDetailsFocus) {
                contextFocus.unfocus();
                billDetailsFocus.requestFocus();
              } else if (FocusScope.of(context).focusedChild ==
                  billTableFocus) {
                contextFocus.unfocus();
                billTableFocus.requestFocus();
                log(contextFocus.hasFocus.toString() +
                    billDetailsFocus.hasFocus.toString() +
                    billTableFocus.hasFocus.toString());
              } else if (FocusScope.of(context).focusedChild ==
                  suggestionFocus) {
                contextFocus.unfocus();
                suggestionFocus.requestFocus();
              }
              print(FocusScope.of(context).focusedChild == contextFocus);
            }
          }
        },
        child: Scaffold(
          body: BlocBuilder<BillingBloc, BillingState>(
            builder: (context, state) {
              if (state is BillingLoding) {
                return Center(
                  child: SplashScreen(width: 10, height: 10),
                );
              }
              if (state is BillingSucess) {
                return buildUi(MediaQuery.of(context).size);
              }
              return Center(
                child: Text(state.toString()),
              );
            },
          ),
        ),
      ),
    );
  }
}
