import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fms_ditu/API/event_records.dart';
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
  late String _gender = "Male";
  late String _password;
  late String _year = "";
  late String _branch;
  late String _college = "DIT";
  late Timer timer;
  late String _phone;
  late bool _showValidation = false;
  late bool _progress = false;

  onSubmit() {
    final validate = _formKey.currentState!.validate();

    if (validate == true && _year != "") {
      setState(() {
        _showValidation = true;
      });
      _formKey.currentState!.save();
      startAuthentication();
    }
    else {
      setState(() {
        Fluttertoast.showToast(msg: "please select year", gravity: ToastGravity.TOP);
        _progress = false;
      });
    }
  }

  startAuthentication() async {
    final auth = FirebaseAuth.instance;

    try {
      await auth
          .createUserWithEmailAndPassword(email: _email, password: _password)
          .then((value) async {
        User? user = auth.currentUser;
        await user!.sendEmailVerification();

        timer = Timer.periodic(const Duration(seconds: 2), (timer) async {
          user = auth.currentUser;
          await user!.reload();

          if (user!.emailVerified) {
            String uid = user!.uid;

            await FirebaseFirestore.instance.collection("users").doc(uid).set({
              "username": _username,
              "email": _email,
              "year": _year,
              "branch": _branch,
              "gender": _gender,
              "phone number": _phone,
              "college": _college
            });
            //set uid in DatabaseService
            // DatabaseService(uid: uid);

            EventRecord.name = _username;
            EventRecord.email = _email;
            EventRecord.gender = _gender;
            Navigator.pushReplacement((context),
                MaterialPageRoute(builder: (context) => const dashboard()));
          }
        });
      });
    } catch (err) {
      setState(() {
        _showValidation = false;
        _progress = false;
      });
      print(err);
      if(err.toString() == "[firebase_auth/email-already-in-use] The email address is already in use by another account.") {
        Fluttertoast.showToast(msg: "Email address already registered");
      }
    }
  }

  var items = ['Male', 'Female', 'Others'];
  var colleges = ['DIT', 'Other'];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 30, top: 50),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: RichText(
                      text: const TextSpan(
                    text: "Welcome to",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.black,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text: '\nYouthopia!',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 50)),
                    ],
                  )),
                ),
              ),
              Container(
                width: double.infinity,
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
                    _email = value.toString().trim();
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
                  keyboardType: TextInputType.phone,
                  key: const ValueKey('phone'),
                  style: const TextStyle(color: Colors.grey),
                  maxLength: 10,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 17),
                    hintText: "Phone number",
                    prefixIcon: Icon(Icons.whatsapp),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                  ),
                  onSaved: (value) {
                    _phone = value!;
                  },
                  validator: (value) {
                    if (value?.isEmpty == true || value!.length < 10) {
                      return "Enter a valid phone number";
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
                child: Row(
                  children: [
                    const Text(
                      "Gender:  ",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    DropdownButton(
                      value: _gender,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: items.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _gender = newValue!;
                        });
                      },
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.3,
                child: Row(
                  children: [
                    const Text(
                      "College:  ",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    DropdownButton(
                      value: _college,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: colleges.map((String colleges) {
                        return DropdownMenuItem(
                          value: colleges,
                          child: Text(colleges),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _college = newValue!;
                        });
                      },
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                width: MediaQuery.of(context).size.width / 1.3,
                child: GroupButton(
                  buttons: const [
                    "1st year",
                    "2nd year",
                    "3rd year",
                    "4th year",
                    "5th year"
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
                    setState(() {
                      _progress = true;
                    });
                    onSubmit();
                  },
                  child: !_progress
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              "Submit",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
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
                        )
                      : SizedBox(
                          width: MediaQuery.of(context).size.width * 0.06,
                          height: MediaQuery.of(context).size.width * 0.06,
                          child: const CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
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
                          "verification mail ",
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
