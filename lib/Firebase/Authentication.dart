import 'package:firedart/auth/exceptions.dart';
import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Screens/splashScreen.dart';
import '../Widgets/IconGEnerae.dart';
import '../Widgets/Jobs.dart';
import '../Widgets/getAttendaceSheet.dart';

class Authentication extends StatefulWidget {
  const Authentication({super.key});

  @override
  State<Authentication> createState() {
    return _AuthenticationState();
  }
}

class _AuthenticationState extends State<Authentication> {
  final _formKey = GlobalKey<FormState>();
  var _username = '';
  var _email = '';
  var _password = '';
  var _isLogin = true;
  bool splash = false;
  Jobs jobs = Jobs.select;
  final auth = FirebaseAuth.instance;
  final store = Firestore.instance;

  void onSubmit() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) return;
    try {
      setState(() {
        splash = true;
      });
      if (!_isLogin) {
        final user = await auth.signUp(_email, _password);
        await store.collection('Employees').document(_username).set({
          'UserName': _username,
          'email': _email,
          "Sales": 0.0,
          "Days of Present": 0,
          "Job": jobs.name,
          "Lat": 0,
          "Long": 0
        });
        await store
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
        await auth.signIn(_email, _password);
      }
      splash = false;
    } on AuthException catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.message)),
      );
      setState(() {
        splash = false;
      });
    }
    _formKey.currentState!.save();
  }

  selectJob() {
    Get.dialog(
      const AlertDialog(title: Text("Job!"), content: Text("Select a Job Please")),
    );
  }

  @override
  Widget build(context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset('images/tatlogo.png', width: 200),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          if (!_isLogin)
                            TextFormField(
                              decoration: const InputDecoration(label: Text('Username')),
                              validator: (value) =>
                              (value == null || value.isEmpty || value.length < 4)
                                  ? 'Need at least 4 characters'
                                  : null,
                              onSaved: (value) => _username = value!,
                            ),
                          if (!_isLogin)
                            Align(
                              alignment: Alignment.centerLeft,
                              child: DropdownButton(
                                value: jobs,
                                items: Jobs.values.map((e) => DropdownMenuItem(
                                  value: e,
                                  child: Row(children: [
                                    IconGenerate().GenerateJobIcon(e.name),
                                    Text(e.name),
                                  ]),
                                )).toList(),
                                onChanged: (value) => setState(() => jobs = value!),
                              ),
                            ),
                          TextFormField(
                            decoration: const InputDecoration(label: Text('Email')),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) =>
                            (value == null || value.isEmpty || !value.contains('@'))
                                ? 'Enter a valid email'
                                : null,
                            onSaved: (value) => _email = value!,
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            decoration: const InputDecoration(label: Text('Password')),
                            obscureText: true,
                            validator: (value) => (value == null || value.length < 4)
                                ? 'Enter at least 4 characters'
                                : null,
                            onSaved: (value) => _password = value!,
                          ),
                          const SizedBox(height: 10),
                          if (splash) SplashScreen(width: 40,height: 40,),
                          if (!splash)
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                Theme.of(context).colorScheme.primaryContainer,
                              ),
                              onPressed: jobs == Jobs.select && !_isLogin ? selectJob : onSubmit,
                              child: Text(_isLogin ? 'Login' : 'Sign in'),
                            ),
                          if (!splash)
                            TextButton(
                              onPressed: () {
                                _formKey.currentState!.reset();
                                setState(() => _isLogin = !_isLogin);
                              },
                              child: Text(_isLogin ? 'Create an account' : 'Already have an account?'),
                            )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}