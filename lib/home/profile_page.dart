import 'package:fapp/auth/sign_in_page.dart';
import 'package:fapp/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fapp/home/edit_profile_page.dart';
import 'package:fapp/home/upload_page.dart';
// ignore: depend_on_referenced_packages

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final databaseReference = FirebaseDatabase.instance.reference();

  final String userProfilePicture =
      'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png';

  late String name = "-";
  late int level = 0;

  @override
  void initState() {
    super.initState();
    fetchUserLevel();
    fetchUserName();
  }

  void fetchUserLevel() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user!.uid;

    final databaseReference = FirebaseDatabase.instance.reference();
    final snapshot =
        await databaseReference.child("users").child(uid).child("level").once();

    print("snapshot -------> ");
    print(snapshot.snapshot.value);
    print("id -------> ");

    print(uid);
    setState(() {
      level = snapshot.snapshot.value
          as int; // Use "default" if level is not set in the database
    });
  }

  Future fetchUserName() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user!.uid;

    final databaseReference = FirebaseDatabase.instance.reference();
    final snapshot =
        await databaseReference.child("users").child(uid).child("name").get();

    setState(() {
      // ignore: unused_label
      name = snapshot.value as String;

      // Use "default" if level is not set in the database
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor.fromHex('#EEEAE5'),
      body: Column(
        children: [
          Container(
            height: 200,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(userProfilePicture),
                ),
                const SizedBox(height: 10),
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 22,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 114, 152, 183),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => EditProfileScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          'Edit Profile',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 114, 152, 183),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextButton(
                        onPressed: () {
                          // ignore: await_only_futures
                          if (level >= 13) {
                            // ignore: use_build_context_synchronously
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => UploadPage(),
                              ),
                            );
                          } else {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("You can't upload files"),
                                  // ignore: prefer_const_constructors
                                  content: Text(
                                      "Your acadimique level is not acceptebale to upload projects yet you can only view projects, for more information you can contact the GPL app admin"),
                                  actions: [
                                    TextButton(
                                      child: const Text("Cancel"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        },
                        child: const Text(
                          'Upload',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 114, 152, 183),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text(
                                    "GPL: Graduation Projects Library"),
                                content: const Text(
                                    "This app provides an easy and convenient way for students, educators and professionals to access and explore a graduation projects library, ideas and innovative solutions from a diverse range of fields. Whether you're a student looking for inspiration or a researcher seeking the latest insights, our app is the perfect resource to help you achieve your goals. With its user-friendly interface, you can quickly search and filter projects based on topic, institution, and date. Join now and tap into the world of education, creativity and innovation."),
                                actions: [
                                  TextButton(
                                    child: const Text("Cancel"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: const Text(
                          'About',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 114, 152, 183),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextButton(
                        onPressed: () async {
                          await FirebaseAuth.instance.signOut();
                          // ignore: use_build_context_synchronously
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => SignIn(
                                  onLoginSuccesfully: () {},
                                  onSignUpSuccesfully: () {})));
                        },
                        child: const Text(
                          'Logout',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
