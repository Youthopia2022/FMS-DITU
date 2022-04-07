import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fms_ditu/routes.dart';
import 'package:fms_ditu/screens/signup/signup.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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