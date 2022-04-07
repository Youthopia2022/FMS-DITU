import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fms_ditu/screens/dashboard/dashboard.dart';
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
  late String _college = "Other";
  late Timer timer;

  onSubmit() {
    final validate = _formKey.currentState!.validate();

    if (validate == true) {
      _formKey.currentState!.save();
      startAuthentication();
    }
  }

  startAuthentication() async{
    final auth = FirebaseAuth.instance;

    await auth.createUserWithEmailAndPassword(email: _email, password: _password).then((value) {
      User? user = auth.currentUser;
      user!.sendEmailVerification();

      timer = Timer.periodic(const Duration(seconds: 5), (timer){
        user = auth.currentUser;
        user!.reload();

        if(user!.emailVerified) {
          Navigator.pushReplacement((context), MaterialPageRoute(builder: (context) => dashboard()));
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                child: TextFormField(
                  keyboardType: TextInputType.name,
                  key: const ValueKey('username'),
                  style: const TextStyle(color: Colors.grey),
                  decoration: const InputDecoration(
                    labelText: "username",
                  ),
                  validator: (value) {
                    if (value?.isEmpty == true) {
                      return "Incorrect name";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _username = value!;
                  },
                ),
              ),
              GroupButton(
                  buttons: const ["Male", "Female", "Other"],
                  onSelected: (i, selected) {
                    if (i == 0) {
                      _gender = "Male";
                    } else if (i == 1) {
                      _gender = "Female";
                    } else {
                      _gender = "Other";
                    }
                  }),
              GroupButton(
                  buttons: const ["DIT", "Other"],
                  onSelected: (i, selected) {
                    setState(() {
                      if (i == 0) {
                        _college = "DIT";
                      } else {
                        _college = "Other";
                      }
                    });
                  }),
              _college == "DIT"
                  ? SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      child: TextFormField(
                        keyboardType: TextInputType.name,
                        key: const ValueKey('email'),
                        style: const TextStyle(color: Colors.grey),
                        decoration: const InputDecoration(
                          labelText: "1000020104@dit.edu.in",
                        ),
                        onSaved: (value) {
                          _email = value!;
                        },
                        validator: (value) {
                          if (value?.isEmpty == true ||
                              value?.contains('@') == false) {
                            return "Incorrect email";
                          }
                          return null;
                        },
                      ),
                    )
                  : SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      child: TextFormField(
                        keyboardType: TextInputType.name,
                        key: const ValueKey('email'),
                        style: const TextStyle(color: Colors.grey),
                        decoration: const InputDecoration(
                          labelText: "john@gmail.com",
                        ),
                        onSaved: (value) {
                          _email = value!;
                        },
                        validator: (value) {
                          if (value?.isEmpty == true ||
                              value?.contains('@') == false) {
                            return "Incorrect email";
                          }
                          return null;
                        },
                      ),
                    ),
              GroupButton(
                buttons: const ["1st year", "2nd year", "3rd year", "4th year"],
                onSelected: (i, selected) => (){
                  _year = "${i+1}th year";
                },
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                child: TextFormField(
                  keyboardType: TextInputType.name,
                  key: const ValueKey('password'),
                  style: const TextStyle(color: Colors.grey),
                  decoration: const InputDecoration(
                    labelText: "password",
                  ),
                  validator: (value) {
                    if (value?.isEmpty == true) {
                      return "generate strong password";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _password = value!;
                  },
                ),
              ),
              TextButton(
                  onPressed: () {
                    onSubmit();
                  },
                  child: const Text("Submit")),
            ],
          )),
    );
  }
}
