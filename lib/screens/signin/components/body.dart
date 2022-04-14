import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fms_ditu/screens/resetpassword/resetpassword.dart';
import 'package:fms_ditu/screens/signup/signup.dart';

import '../../../constants.dart';
import '../../dashboard/dashboard.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late String _email;
  late String _password;

  final _formKey = GlobalKey<FormState>();

  validateForm() {
    final validity = _formKey.currentState!.validate();

    if (validity == true) {
      _formKey.currentState!.save();
      startAuthentication();
    }
  }

  startAuthentication() async {
    final user = FirebaseAuth.instance;
    await user.signInWithEmailAndPassword(email: _email, password: _password);
    Navigator.pushReplacement((context), MaterialPageRoute(builder: (context) => const dashboard()));

  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 30, top: 50, bottom: 100),
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
            const SizedBox(height: 25),
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
            Container(
              margin: const EdgeInsets.only(top: 80),
              width: MediaQuery.of(context).size.width / 2,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: kButtonColorPrimary,
              ),
              child: TextButton(
                onPressed: () {
                  validateForm();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "Login",
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
            TextButton(
              onPressed: () {
                Navigator.push(
                    (context),
                    MaterialPageRoute(
                        builder: (context) => const ResetPassword()));
              },
              child: const Text(
                "Forgot password?",
                style:
                    TextStyle(fontWeight: FontWeight.w500, color: Colors.black),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 5.6,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.5,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?"),
                  TextButton(
                      onPressed: () {
                       Navigator.pushReplacement((context), MaterialPageRoute(builder: (context) => const SignUp()));
                      },
                      child: const Text("Sign up"))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
