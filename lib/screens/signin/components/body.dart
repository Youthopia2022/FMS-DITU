import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fms_ditu/screens/dashboard/dashboard.dart';

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

    if(validity == true) {
      _formKey.currentState!.save();
      startAuthentication();
    }
  }

  startAuthentication() async{
    final user = FirebaseAuth.instance;

    await user.signInWithEmailAndPassword(email: _email, password: _password).then((value) {
      Navigator.pushReplacement((context), MaterialPageRoute(builder: (context) => dashboard()));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Form(
        key: _formKey,
          child: Column(children: [
            SizedBox(
              width: MediaQuery.of(context).size.width/2,
              child: TextFormField(
                keyboardType: TextInputType.name,
                key: const ValueKey('email'),
                style: const TextStyle(color: Colors.grey),
                decoration: const InputDecoration(
                  labelText: "email",
                ),
                validator: (value) {
                  return null;
                },
                onSaved: (value) {
                  _email = value!;
                },
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width/2,
              child: TextFormField(
                keyboardType: TextInputType.visiblePassword,
                key: const ValueKey('password'),
                style: const TextStyle(color: Colors.grey),
                decoration: const InputDecoration(
                  labelText: "password",
                ),
                validator: (value) {
                  return null;
                },
                onSaved: (value) {
                  _password = value!;
                },
              ),
            ),

            TextButton(onPressed: (){
              validateForm();
            }, child: Text("Submit"),),
          ],)),
    );
  }
}
