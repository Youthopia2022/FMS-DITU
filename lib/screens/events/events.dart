import 'package:flutter/material.dart';
import 'package:fms_ditu/screens/events/components/body.dart';

class Events extends StatelessWidget {
  const Events({Key? key}) : super(key: key);

  static String routeName = "/Events";
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: body(),
      ),
    );
  }
}
