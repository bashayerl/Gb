import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fapp/utils/colors.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignInUp extends StatefulWidget {
  final VoidCallback onSignUpSuccesfully;

  SignInUp({
    key,
    required this.onSignUpSuccesfully,
  }) : super(key: key);

  @override
  State<SignInUp> createState() => _SignInUpState();
}

class _SignInUpState extends State<SignInUp> {
  List<String> options = <String>[
    'Computer Science',
    'Business Administration',
    'Mathematics'
  ];
  String dropdownValue = 'Computer Science';

  final auth = FirebaseAuth.instance;

  late String email;
  late String password;
  late String name = "test";
  late String last = "test";
  late String level;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final DatabaseReference _usersRef =
      FirebaseDatabase.instance.reference().child('users');

  Future<void> signUp() async {
    try {
      // Create a new user account with email and password
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Get the current user and their UID
      final FirebaseAuth auth = FirebaseAuth.instance;
      final User? user = auth.currentUser;
      final uid = user!.uid;

      // Save the user data to the database
      final databaseReference = FirebaseDatabase.instance.reference();
      await databaseReference.child("users").child(uid).set({
        'name': name,
        'last': last,
        'level': level,
        'email': email,
        'dropdownValue': dropdownValue,
      });

      widget.onSignUpSuccesfully;
      Navigator.pop(context);
    } catch (e) {
      // Handle errors here
      print("Error: $e");
    }
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
                      TextFormField(
                        onChanged: (value) {
                          name = value;
                        },
                        style: const TextStyle(color: Colors.black),
                        decoration: const InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            labelText: 'First Name',
                            labelStyle:
                                TextStyle(fontSize: 15, color: Colors.black)),
                      ),
                      TextFormField(
                        onChanged: (value) {
                          last = value;
                        },
                        style: const TextStyle(color: Colors.black),
                        decoration: const InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            labelText: 'last Name',
                            labelStyle:
                                TextStyle(fontSize: 15, color: Colors.black)),
                      ),
                      TextFormField(
                        onChanged: (value) {
                          password = value;
                        },
                        obscureText: true,
                        style: const TextStyle(color: Colors.black),
                        decoration: const InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            labelText: 'password',
                            labelStyle:
                                TextStyle(fontSize: 15, color: Colors.black)),
                      ),
                      TextFormField(
                        onChanged: (value) {
                          level = value;
                        },
                        style: const TextStyle(color: Colors.black),
                        decoration: const InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            labelText: 'Level Year',
                            labelStyle:
                                TextStyle(fontSize: 15, color: Colors.black)),
                      ),
                      TextFormField(
                        onChanged: (value) {
                          email = value;
                        },
                        style: const TextStyle(color: Colors.black),
                        decoration: const InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            labelText: 'Student Email',
                            labelStyle:
                                TextStyle(fontSize: 15, color: Colors.black)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: DropdownButton<String>(
                          value: dropdownValue,
                          onChanged: (String? value) {
                            // This is called when the user selects an item.
                            setState(() {
                              dropdownValue = value!;
                            });
                          },
                          style: const TextStyle(
                              color: Color.fromARGB(255, 114, 152, 183)),
                          selectedItemBuilder: (BuildContext context) {
                            // This is the widget that will be shown when you select an item.
                            // Here custom text style, alignment and layout size can be applied
                            // to selected item string.
                            return options.map((String value) {
                              return Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  dropdownValue,
                                  style: const TextStyle(color: Colors.black),
                                ),
                              );
                            }).toList();
                          },
                          items: options
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          icon:
                              Icon(Icons.arrow_drop_down, color: Colors.black),
                          isExpanded: true,
                          underline: Container(
                            height: 3,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: MaterialButton(
                    onPressed: () async {
                      await signUp();
                    },
                    color: Color.fromARGB(255, 114, 152, 183),
                    elevation: 0,
                    minWidth: 350,
                    height: 60,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    child: const Text(
                      'SIGN UP',
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
                            text: "Already have an account?  ",
                            style: TextStyle(
                              fontFamily: 'SFUIDisplay',
                              color: Colors.black,
                              fontSize: 15,
                            )),
                        TextSpan(
                          text: "sign in",
                          style: const TextStyle(
                              fontFamily: 'SFUIDisplay',
                              color: Colors.lightBlue,
                              fontSize: 15,
                              fontWeight: FontWeight.normal),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => {Navigator.of(context).pop()},
                        )
                      ]),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
