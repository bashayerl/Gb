// ignore_for_file: unused_import, implementation_imports

import 'package:flutter/material.dart';
import 'package:fapp/home/home_route.dart';
// ignore: unused_import
import 'package:fapp/home/home_page.dart';
import 'package:fapp/auth/sign_in_page.dart';
import 'package:fapp/auth/sign_up_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late bool _isLoggedIn;

  bool isLoggedIn = false;

  final auth = FirebaseAuth.instance;
  late String email;
  late String password;

  @override
  Widget build(BuildContext context) {
    _isLoggedIn = true;

    return MaterialApp(
      title: 'Kodeversitas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        fontFamily: 'Nunito',
      ),
      // home: SignInUp(
      //   onSignUpSuccesfully: () {},
      // ),
      home: Conditional(
        condition: isLoggedIn,
        ifTrue: const HomeRoute(),
        ifFalse: SignIn(
          onLoginSuccesfully: () {
            setState(() {
              isLoggedIn = true;
            });
          },
          onSignUpSuccesfully: () {
            // Navigator.pop(context);
            setState(() {
              auth.createUserWithEmailAndPassword(
                  email: email, password: password);
            });
          },
        ),
      ),
    );
  }
}

class Conditional extends StatelessWidget {
  final bool condition;
  final Widget ifTrue;
  final Widget ifFalse;

  const Conditional({
    super.key,
    required this.condition,
    required this.ifTrue,
    required this.ifFalse,
  });

  @override
  Widget build(BuildContext context) {
    return condition ? ifTrue : ifFalse;
  }
}
