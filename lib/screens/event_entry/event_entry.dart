import 'package:flutter/material.dart';
import 'package:fms_ditu/constants.dart';
import 'package:fms_ditu/screens/event_entry/components/Body.dart';
import 'package:fms_ditu/screens/event_entry/components/EventBrief.dart';

class EventsEntry extends StatelessWidget {
  const EventsEntry({Key? key}) : super(key: key);

  static String routeName = "/eventBrief";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: AppBar(
          title: Text("Event Entry"),
        ),
        body: Body(),
      ),
    );
  }
}
