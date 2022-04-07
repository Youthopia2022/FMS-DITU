import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                key: const ValueKey('email'),
                style: const TextStyle(color: Colors.grey),
                decoration: const InputDecoration(
                  labelText: "email",
                ),
                validator: (value) {
                  if (value?.isEmpty == true ||
                      value?.contains('@') == false) {
                    return "Incorrect email";
                  }
                  return null;
                },
                onSaved: (value) {
                  setState(() {
                    _email = value!;
                  });
                },
              ),
            ),
            TextButton(
                onPressed: () {
                  sendResetLink();
                },
                child: const Text("send request"))
          ],
        ),
      ),
    );
  }
}
