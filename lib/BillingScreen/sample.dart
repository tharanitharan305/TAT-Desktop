import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tat_windows/BillingScreen/bloc/billing_bloc.dart';

class Smaple extends StatefulWidget {
  const Smaple({super.key});

  @override
  State<Smaple> createState() => _SmapleState();
}

class _SmapleState extends State<Smaple> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => BillingBloc(),
        child: BlocBuilder<BillingBloc, BillingState>(
          builder: (context, state) {
            if (state is BillingLoding) {
              return CircularProgressIndicator();
            }
            return Center(child: Text("ff"));
          },
        ),
      ),
    );
  }
}
