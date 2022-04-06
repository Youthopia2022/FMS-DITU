import 'package:flutter/material.dart';
import 'package:fms_ditu/screens/events/components/body.dart';

class events extends StatelessWidget {
  const events({Key? key}) : super(key: key);

  static String routeName = "/events";
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
