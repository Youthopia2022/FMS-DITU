import 'package:flutter/material.dart';
import 'package:fms_ditu/screens/signup/components/body.dart';

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);
  static String routeName = "/sign_up";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Body(),
      ),
    );
  }
}
