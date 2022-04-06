import 'package:flutter/material.dart';
import 'package:fms_ditu/routes.dart';
import 'package:fms_ditu/screens/signup/signup.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FMS DITU',
      initialRoute: signup.routeName,
      routes: routes,
    );
  }
}