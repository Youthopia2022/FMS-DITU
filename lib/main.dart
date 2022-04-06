import 'package:flutter/material.dart';
import 'package:fms_ditu/routes.dart';
import 'package:fms_ditu/screens/signup/signup.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FMS DITU',
      initialRoute: SignUp.routeName,
      routes: routes,
    );
  }
}