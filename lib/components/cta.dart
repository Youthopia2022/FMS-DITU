import 'package:flutter/material.dart';

import '../constants.dart';

class CTA extends StatelessWidget {
  CTA({Key? key, required this.text, required this.size}) : super(key: key);
  String text;
  Size size;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: Text(text),
      style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(8),
          primary: kButtonColorPrimary,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
              side: const BorderSide(color: kButtonColorPrimary))),
    );
  }
}
