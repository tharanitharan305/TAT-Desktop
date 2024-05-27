import 'package:firedart/auth/firebase_auth.dart';
import 'package:firedart/firestore/firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:tat_win/Screens/Navigation.dart';
import 'package:tat_win/Widgets/Jobs.dart';

import 'Screens/UserInterface.dart';
import 'Screens/splashScreen.dart';
import 'Widgets/getAttendaceSheet.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  final _formKey = GlobalKey<FormState>();
  var _username = '';
  var _email = '';
  var _password = '';
  var _isLogin = true;
  final _firebase = FirebaseAuth.instance;
  bool splash = false;
  void onSubmit() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) return;
    try {
      setState(() {
        splash = true;
      });
      if (!_isLogin) {
        final usercretial = await _firebase.signUp(_email, _password);
        // usercretial.user!.updateDisplayName(_username);
        await FirebaseAuth.instance.updateProfile(displayName: _username);
        print("1");
        await Firestore.instance
            .collection('Employees')
            .document(_username)
            .set({
          'UserName': _username,
          'email': _email,
          "Sales": 0.0,
          "Days of Present": 0,
          "Job": "OWNER"
        });
        print("2");
        await Firestore.instance
            .collection('Employees')
            .document(_username)
            .collection(DateTime.now().year.toString())
            .document(DateTime.now().month.toString())
            .set({
          'Attendance Days': AttendanceSheet()
              .getAttendanceSheet(DateTime.now().month, DateTime.now().year),
          "Mothly sales": 0.0,
          "Days of Present": 0,
          "Max sale": 0.0,
          "Max Sale Shop": "",
        });
      } else {
        final usercretial = await _firebase.signIn(_email, _password);
      }
      splash = false;
      //Get.off(() => NavigationPaneDemo());
      // Get.dialog(Center(
      //   child: Lottie.asset('animations/welcome.json'),
      // ));
    } catch (error) {
      //Get.snackbar("TryOnce...", "");
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(error.toString()),
      ));
      setState(() {
        splash = false;
      });
    }
    _formKey.currentState!.save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.grey[300],
        child: Center(
          child: Card(
            elevation: 20,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              height: MediaQuery.of(context).size.height * 0.85,
              width: MediaQuery.of(context).size.width * 0.85,
              child: Row(
                children: [
                  Container(
                    // padding: EdgeInsets.only(left: 10),
                    height: MediaQuery.of(context).size.height * 0.75,
                    width: MediaQuery.of(context).size.width * 0.40,
                    child: Stack(
                      children: [
                        Image.asset(
                          'images/tatSymbol.png',
                        ),
                        Lottie.asset("animations/back2.json")
                      ],
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.75,
                    width: MediaQuery.of(context).size.width * 0.35,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 80),
                      child: Align(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'WELCOME...',
                              style: GoogleFonts.lexend(fontSize: 30),
                            ),
                            Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  if (!_isLogin)
                                    TextFormField(
                                      decoration: const InputDecoration(
                                        label: Text('Username'),
                                      ),
                                      validator: (value) {
                                        if (value == null ||
                                            value.isEmpty ||
                                            value.trim().length < 4) {
                                          return 'Need Atleast 4 Characters';
                                        }
                                        return null;
                                      },
                                      onSaved: (values) {
                                        setState(() {
                                          _username = values!;
                                        });
                                      },
                                    ),
                                  TextFormField(
                                    decoration: const InputDecoration(
                                        label: Text('Email')),
                                    keyboardType: TextInputType.emailAddress,
                                    validator: (value) {
                                      if (value == null ||
                                          value.trim().isEmpty ||
                                          !value.contains('@')) {
                                        return 'Enter a valid email';
                                      }
                                      return null;
                                    },
                                    onSaved: (newValue) {
                                      _email = newValue!;
                                    },
                                  ),
                                  TextFormField(
                                    decoration: const InputDecoration(
                                        label: Text('Password')),
                                    autocorrect: false,
                                    textCapitalization: TextCapitalization.none,
                                    obscureText: true,
                                    validator: (value) {
                                      if (value == null || value.length < 4) {
                                        return 'Enter a atleast 4 characters';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      _password = value!;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  if (splash)
                                    SplashScreen(
                                      width: 50,
                                      height: 50,
                                    ),
                                  if (!splash)
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Theme.of(context)
                                            .colorScheme
                                            .primaryContainer,
                                      ),
                                      onPressed: onSubmit,
                                      child:
                                          Text(_isLogin ? 'Login' : 'Sign in'),
                                    ),
                                  if (!splash)
                                    TextButton(
                                        onPressed: () {
                                          _formKey.currentState!.reset();
                                          setState(() {
                                            _isLogin = !_isLogin;
                                          });
                                        },
                                        child: Text(_isLogin
                                            ? 'Create a account'
                                            : 'Already have a account'))
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
