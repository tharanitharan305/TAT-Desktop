import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'AdminScreen.dart';
import 'OrderScreen.dart';
import 'getNew.dart';
import '../Widgets/UserDrawer.dart';

class UserInterface extends StatefulWidget {
  const UserInterface({super.key});

  @override
  State<UserInterface> createState() {
    return _UserInterface();
  }
}

class _UserInterface extends State<UserInterface> {
  bool Admin = false;
  @override
  Widget build(context) {
    return SafeArea(
      child: Scaffold(
        drawer: UserDrawer(),
        appBar: AppBar(
          backgroundColor: Colors.white,
        ),
        body: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage('images/tatlogo.png'),
                fit: BoxFit.contain,
                opacity: 0.1,
              ),
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AdminScreen()));
                  },
                  label: const Text('Get Order'),
                  style: TextButton.styleFrom(
                    alignment: Alignment.centerLeft,
                    fixedSize: Size(170, 10),
                    padding: const EdgeInsetsDirectional.fromSTEB(30, 0, 30, 0),
                    elevation: 10,
                    backgroundColor:
                        Theme.of(context).colorScheme.primaryContainer,
                  ),
                  icon: const Icon(Icons.get_app_rounded),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const OrderScreen(),
                      ),
                    );
                  },
                  label: const Text('Place Order'),
                  style: TextButton.styleFrom(
                    alignment: Alignment.center,
                    fixedSize: Size(170, 10),
                    padding: const EdgeInsetsDirectional.fromSTEB(30, 0, 30, 0),
                    elevation: 10,
                    backgroundColor:
                        Theme.of(context).colorScheme.primaryContainer,
                  ),
                  icon: const Icon(Icons.add_shopping_cart),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GetNew(),
                      ),
                    );
                  },
                  label: const Text('Add'),
                  style: TextButton.styleFrom(
                    alignment: Alignment.center,
                    fixedSize: Size(170, 10),
                    padding: const EdgeInsetsDirectional.fromSTEB(30, 0, 30, 0),
                    elevation: 10,
                    backgroundColor:
                        Theme.of(context).colorScheme.primaryContainer,
                  ),
                  icon: const Icon(Icons.add_business_rounded),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            )),
      ),
    );
  }
}
