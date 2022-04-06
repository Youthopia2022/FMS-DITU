import 'package:flutter/material.dart';
import 'package:fms_ditu/screens/signin/components/body.dart';

class signin extends StatelessWidget {
  const signin({Key? key}) : super(key: key);

  static String routeName = "/sign_in";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: body(),
      ),
    );
  }
}
