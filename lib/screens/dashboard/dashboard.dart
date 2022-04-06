import 'package:flutter/material.dart';
import 'package:fms_ditu/screens/events/components/body.dart';

class dashboard extends StatelessWidget {
  const dashboard({Key? key}) : super(key: key);

  static String routeName = "/dashboard";
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