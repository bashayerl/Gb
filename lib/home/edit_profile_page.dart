import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String _email;
  late String _bio;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
        backgroundColor: const Color.fromRGBO(58, 66, 86, 1.0),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: "Name"),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your name";
                    }
                    return null;
                  },
                  onSaved: (value) => _name = value!,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "Email"),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your email";
                    }
                    return null;
                  },
                  onSaved: (value) => _email = value!,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "Bio"),
                  maxLines: 3,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your bio";
                    }
                    return null;
                  },
                  onSaved: (value) => _bio = value!,
                ),
                Container(
                  margin: EdgeInsets.only(top: 16.0),
                  child: TextButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        // Update profile information
                        Navigator.pop(context);
                      }
                    },
                    child: Text("Save"),
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
