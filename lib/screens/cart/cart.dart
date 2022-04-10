import 'package:flutter/material.dart';
import 'package:fms_ditu/screens/cart/components/body.dart';

class events extends StatelessWidget {
  const events({Key? key}) : super(key: key);

  static String routeName = "/cart";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: CartBody(),
      ),
    );
  }
}
