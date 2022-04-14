import 'package:flutter/material.dart';
import 'eventSelectionBody.dart';

class EventSelection extends StatelessWidget {
  const EventSelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: EventSelectionMain(),
    );
  }
}
