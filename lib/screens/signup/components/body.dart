import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fms_ditu/constants.dart';
import 'package:fms_ditu/screens/dashboard/dashboard.dart';
import 'package:fms_ditu/screens/signin/signin.dart';
import 'package:group_button/group_button.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _formKey = GlobalKey<FormState>();
  late String _username;
  late String _email;
  late String _gender;
  late String _password;
  late String _year;
  late String _branch;
  late String _college;
  late Timer timer;
  late bool _showValidation = false;

  onSubmit() {
    final validate = _formKey.currentState!.validate();

    if (validate == true) {
      _showValidation = true;
      _formKey.currentState!.save();
      startAuthentication();
    }
  }

  startAuthentication() async {
    final auth = FirebaseAuth.instance;

    await auth
        .createUserWithEmailAndPassword(email: _email, password: _password)
        .then((value) async {
      User? user = auth.currentUser;
      await user!.sendEmailVerification();

      timer = Timer.periodic(const Duration(seconds: 2), (timer) async {
        user = auth.currentUser;
        user!.reload();

        if (user!.emailVerified) {
          String uid = user!.uid;

          await FirebaseFirestore.instance.collection("users").doc(uid).set({
            "username": _username,
            "email": _email,
            "year": _year,
            "branch": _branch,
            "gender": _gender,
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 40),
                child: const Text(
                  "Welcome to Youthopia!",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                      color: Colors.black),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.5,
                margin: const EdgeInsets.only(top: 20, bottom: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account?"),
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(
                              (context), SignIn.routeName, (route) => false);
                        },
                        child: const Text("Log In"))
                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.3,
                child: TextFormField(
                  keyboardType: TextInputType.name,
                  key: const ValueKey('username'),
                  style: const TextStyle(color: Colors.grey),
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 17),
                    hintText: "username",
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                  ),
                  validator: (value) {
                    if (value?.isEmpty == true) {
                      return kNamelNullError;
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _username = value!;
                  },
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.3,
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  key: const ValueKey('email'),
                  style: const TextStyle(color: Colors.grey),
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 17),
                    hintText: "Email address",
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                  ),
                  onSaved: (value) {
                    _email = value!;
                  },
                  validator: (value) {
                    if (value?.isEmpty == true) {
                      return kEmailNullError;
                    } else if (value?.contains('@') == false) {
                      return kInvalidEmailError;
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.3,
                child: TextFormField(
                  keyboardType: TextInputType.name,
                  key: const ValueKey('gender'),
                  style: const TextStyle(color: Colors.grey),
                  decoration: const InputDecoration(
                      hintText: "Male",
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 17, horizontal: 20),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25)))),
                  onSaved: (value) {
                    _gender = value!;
                  },
                  validator: (value) {
                    if (value?.isEmpty == true) {
                      return "Incorrect gender";
                    }
                    return null;
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                width: MediaQuery.of(context).size.width / 1.4,
                child: GroupButton(
                  buttons: const [
                    "1st year",
                    "2nd year",
                    "3rd year",
                    "4th year"
                  ],
                  onSelected: (i, selected) {
                    _year = "${i + 1} year";
                  },
                  borderRadius: BorderRadius.circular(20),
                  selectedColor: kButtonColorPrimary,
                  isRadio: true,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.3,
                child: TextFormField(
                  keyboardType: TextInputType.name,
                  key: const ValueKey('branch'),
                  style: const TextStyle(color: Colors.grey),
                  decoration: const InputDecoration(
                      hintText: "Branch Name",
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 17, horizontal: 20),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25)))),
                  onSaved: (value) {
                    _branch = value!;
                  },
                  validator: (value) {
                    if (value?.isEmpty == true) {
                      return "Incorrect branch";
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.3,
                child: TextFormField(
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  key: const ValueKey('password'),
                  style: const TextStyle(color: Colors.grey),
                  decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 17, horizontal: 20),
                    hintText: "Password",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25))),
                  ),
                  validator: (value) {
                    if (value?.isEmpty == true || value!.length < 6) {
                      return "generate strong password";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _password = value!;
                  },
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 2,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: kButtonColorPrimary,
                ),
                child: TextButton(
                  onPressed: () {
                    onSubmit();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "Submit",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Icon(
                        Icons.arrow_forward_outlined,
                        color: Colors.white,
                        size: 29,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              if (_showValidation)
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "An ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "OTP ",
                          style: TextStyle(
                              color: kButtonColorPrimary,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "has been sent to your ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "email id.",
                          style: TextStyle(
                              color: kButtonColorPrimary,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    const Text(
                      "Please verify your account",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
