import 'package:flutter/material.dart';
import 'package:fms_ditu/screens/signin/components/body.dart';

class SignIn extends StatelessWidget {
  const SignIn({Key? key}) : super(key: key);

  static String routeName = "/sign_in";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Body(),
      ),
    );
  }
}
