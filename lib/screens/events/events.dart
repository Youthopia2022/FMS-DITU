import 'package:flutter/material.dart';
import 'package:fms_ditu/API/eventDetails.dart';
import 'package:fms_ditu/API/event_records.dart';
import 'package:fms_ditu/screens/events/components/body.dart';

class Events extends StatelessWidget {
  Events({Key? key, required this.list}) : super(key: key);

  // Map<String, dynamic> obj;

  EventDetails list;

  static String routeName = "/Events";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: EventsBody(list: list),
    );
  }
}
//test comment