import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final auth = FirebaseAuth.instance;
  late String _email;
  final _formKey = GlobalKey<FormState>();


  sendResetLink() {
    final validity = _formKey.currentState!.validate();

    if(validity == true) {
      _formKey.currentState!.save();
      auth.sendPasswordResetEmail(email: _email);
      Navigator.pop(context);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 30, top: 50, bottom: 90),
              child: Align(
                alignment: Alignment.topLeft,
                child: RichText(
                    text: const TextSpan(
                      text: "Forgot",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Colors.black,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                            text: '\nPassword!',
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
            Container(
              margin: const EdgeInsets.only(left: 60, top: 5, bottom: 90),
              child: Align(
                alignment: Alignment.topLeft,
                child: RichText(
                    text: const TextSpan(
                      text: "We will send you email to set your",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w200,
                        color: Colors.black,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                            text: '\nnew password',
                            style: TextStyle(
                                 fontSize: 15)),
                      ],
                    )),
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
                  sendResetLink();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "Send link",
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
          ],
        ),
      ),
    );
  }
}
