import 'package:flutter/material.dart';

class EventsBody extends StatefulWidget {
  const EventsBody({Key? key}) : super(key: key);

  @override
  State<EventsBody> createState() => _EventsBodyState();
}

class _EventsBodyState extends State<EventsBody> {
  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text("Events Screen")
    );
  }
}
