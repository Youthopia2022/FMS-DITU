import 'package:flutter/material.dart';
import 'package:fms_ditu/constants.dart';
import 'package:fms_ditu/screens/cart/components/body.dart';

import '../../sizeConfig.dart';

class events extends StatelessWidget {
  const events({Key? key}) : super(key: key);

  static String routeName = "/cart";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: AppBar(),
        body: CartBody(),
      ),
    );
  }
}
