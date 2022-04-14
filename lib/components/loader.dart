import 'package:flutter/material.dart';
import 'package:rive/rive.dart';


class loader extends StatefulWidget {
  const loader({Key? key}) : super(key: key);

  @override
  State<loader> createState() => _loaderState();
}

class _loaderState extends State<loader> {
  var height, width;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Center(
      child: Container(
        height: height*0.2,
        child: RiveAnimation.asset(
          'assets/rive/men2.riv',
          animations: ['running'],
        ),
      ),
    );
  }
}
