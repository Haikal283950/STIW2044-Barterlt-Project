import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:http/http.dart' as http;

import '../model/user.dart';
import '../myConfig.dart';

class UserProfile extends StatefulWidget {
  final User user;
  const UserProfile({super.key, required this.user});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final TextEditingController _firstNameEditingController =
      TextEditingController();
  final TextEditingController _lastNameEditingController =
      TextEditingController();
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _passwordEditingController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();
  void initState() {
    super.initState();
  }

  void dispose() {
    _firstNameEditingController.dispose();
    _lastNameEditingController.dispose();
    _emailEditingController.dispose();
    _passwordEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Profile"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 150,
                    width: 150,
                    child: Image.network(
                        ("https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png")),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Text(
                        "First Name",
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Please enter your first name";
                      }
                    },
                    controller: _firstNameEditingController,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 20),
                        hintText: widget.user.first_name,
                        filled: true,
                        fillColor: Color.fromARGB(255, 214, 226, 240),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(35))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Text(
                        "Last Name",
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Please enter your last name";
                      }
                    },
                    controller: _lastNameEditingController,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 20),
                        hintText: widget.user.last_name,
                        filled: true,
                        fillColor: Color.fromARGB(255, 214, 226, 240),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(35))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Text(
                        "Email",
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Please enter your email";
                      }
                    },
                    controller: _emailEditingController,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 20),
                        hintText: widget.user.username,
                        filled: true,
                        fillColor: Color.fromARGB(255, 214, 226, 240),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(35))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Text(
                        "Password",
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    obscureText: true,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Please enter your password";
                      }
                    },
                    controller: _passwordEditingController,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 20),
                        filled: true,
                        fillColor: Color.fromARGB(255, 214, 226, 240),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(35))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 14, 54, 141),
                        onPrimary: Color.fromARGB(255, 244, 54, 181),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(35)),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          sendRequest();
                        } else {
                          print("invalid");
                        }
                      },
                      child: Center(
                        child: Text(
                          "Edit Profile",
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> sendRequest() async {
    String firstName = _firstNameEditingController.text;
    String lastName = _lastNameEditingController.text;
    String email = _emailEditingController.text;
    http.post(Uri.parse(server + "/barterlt/php/update_profile.php"), body: {
      "user_id": widget.user.user_id,
      "first_name": firstName,
      "last_name": lastName,
      "email": email,
      "password": _passwordEditingController.text
    }).then((response) {
      final jsonResponse = json.decode(response.body);
      print(jsonResponse.toString());
      if (jsonResponse['status'] == "success") {
        ScaffoldMessenger.of(context)
            .showSnackBar(buildSnackBar("Updated Profile"));
        setState(() {});
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(buildSnackBar("Profile Update Failed!"));
      }
    });
  }

  SnackBar buildSnackBar(String text) {
    return SnackBar(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        content: Text(text),
        duration: Duration(seconds: 1));
  }
}
