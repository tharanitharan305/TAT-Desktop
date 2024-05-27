import 'package:flutter/material.dart';

import '../Widgets/Add.dart';
import '../Widgets/ShopGetter.dart';

class GetNew extends StatefulWidget {
  State<GetNew> createState() => _GetNew();
}

class _GetNew extends State<GetNew> {
  void ADD() {
    showModalBottomSheet(
        context: context,
        builder: (context) => Add(),
        isScrollControlled: true);
  }

  void ShopAdd() {
    showModalBottomSheet(
        context: context,
        builder: (context) => ShopGetter(),
        isScrollControlled: true);
  }

  Widget build(context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            image: DecorationImage(
                image: AssetImage('images/tatlogo.png'), opacity: 0.6),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: ADD,
                  label: const Text('Add Product'),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsetsDirectional.fromSTEB(30, 0, 30, 0),
                    elevation: 10,
                    backgroundColor:
                        Theme.of(context).colorScheme.primaryContainer,
                  ),
                  icon: const Icon(Icons.shopping_cart_checkout_rounded),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton.icon(
                  onPressed: ShopAdd,
                  label: const Text('Add Shop'),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsetsDirectional.fromSTEB(30, 0, 30, 0),
                    elevation: 10,
                    backgroundColor:
                        Theme.of(context).colorScheme.primaryContainer,
                  ),
                  icon: const Icon(Icons.add_location),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  label: const Text('Add Company'),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsetsDirectional.fromSTEB(30, 0, 30, 0),
                    elevation: 10,
                    backgroundColor:
                        Theme.of(context).colorScheme.primaryContainer,
                  ),
                  icon: const Icon(Icons.factory_rounded),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
