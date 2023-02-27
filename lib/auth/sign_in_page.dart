import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:fapp/home/home_route.dart';
import 'package:fapp/auth/sign_up_page.dart';
import 'package:fapp/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';

// ignore: must_be_immutable
class SignIn extends StatelessWidget {
  final VoidCallback onLoginSuccesfully;
  final VoidCallback onSignUpSuccesfully;
  final auth = FirebaseAuth.instance;
  late String email;
  late String password;

  SignIn({
    key,
    required this.onLoginSuccesfully,
    required this.onSignUpSuccesfully,
  }) : super(key: key);

  static Future<User?> loginUsingEmailPassword(
      {required String email,
      required String password,
      required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      String message = "";
      if (e.code == "user-not-found") {
        message = "No user found with this email";
      } else if (e.code == "wrong-password") {
        message = "Incorrect password";
      } else {
        message = e.message ?? "An error occurred";
      }
      print(message);
      AlertDialog alert = AlertDialog(
        title: const Text("Login failed"),
        content: Text(message),
      );

      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: HexColor.fromHex('#EEEAE5'),
        body: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.transparent,
          ),
          child: Padding(
            padding: const EdgeInsets.all(23),
            child: ListView(
              children: <Widget>[
                const SizedBox(
                  height: 50,
                ),
                Form(
                  child: Column(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20), // Image border
                        child: SizedBox.fromSize(
                          size: const Size.fromRadius(48), // Image radius
                          child: Image.asset(
                            "images/gpl_logo.png",
                            width: 150,
                            height: 150,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                        child: TextFormField(
                          onChanged: (value) {
                            email = value;
                          },
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                          decoration: const InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                              labelText: 'Email',
                              labelStyle:
                                  TextStyle(fontSize: 15, color: Colors.black)),
                        ),
                      ),
                      TextFormField(
                        onChanged: (value) {
                          password = value;
                        },
                        obscureText: true,
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                        decoration: const InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            labelText: 'Password',
                            labelStyle:
                                TextStyle(fontSize: 15, color: Colors.black)),
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // set up the button
                    Widget okButton = TextButton(
                      child: const Text("Close"),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    );

                    // set up the AlertDialog
                    AlertDialog alert = AlertDialog(
                      title: const Text("Rest Password"),
                      content: const Text(
                          "A password rest instructions has been sent to your email!"),
                      actions: [
                        okButton,
                      ],
                    );

                    // show the dialog
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return alert;
                      },
                    );
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(top: 20, bottom: 5),
                    child: Text(
                      'Forgot your password?',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          fontFamily: 'SFUIDisplay',
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: MaterialButton(
                    onPressed: (() async {
                      User? user = await loginUsingEmailPassword(
                          email: email, password: password, context: context);
                      print(user);
                      if (user != null) {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => HomeRoute()));
                      }
                    }),
                    color: Color.fromARGB(255, 114, 152, 183),
                    elevation: 0,
                    minWidth: 350,
                    height: 60,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    child: const Text(
                      'SIGN IN',
                      style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'SFUIDisplay',
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Center(
                    child: RichText(
                      text: TextSpan(children: [
                        const TextSpan(
                            text: "Don't have an account?",
                            style: TextStyle(
                              fontFamily: 'SFUIDisplay',
                              color: Colors.black,
                              fontSize: 15,
                            )),
                        TextSpan(
                          text: " sign up",
                          style: TextStyle(
                              fontFamily: 'SFUIDisplay',
                              color: primaryColor,
                              fontSize: 15),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => SignInUp(
                                          onSignUpSuccesfully:
                                              onSignUpSuccesfully),
                                    ),
                                  )
                                },
                        )
                      ]),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
