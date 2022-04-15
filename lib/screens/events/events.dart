import 'package:flutter/material.dart';
import 'package:fms_ditu/API/event_records.dart';
import 'package:fms_ditu/screens/events/components/body.dart';

class Events extends StatelessWidget {
  Events({Key? key, required this.obj}) : super(key: key);

  Map<String, dynamic> obj;

  static String routeName = "/Events";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: EventsBody(obj: obj),
    );
  }
}
//test comment