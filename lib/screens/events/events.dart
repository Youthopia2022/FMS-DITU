import 'package:flutter/material.dart';
import 'package:fms_ditu/API/eventDetails.dart';
import 'package:fms_ditu/API/event_records.dart';
import 'package:fms_ditu/screens/events/components/body.dart';

import '../../constants.dart';

class Events extends StatelessWidget {
  Events({Key? key, required this.list}) : super(key: key);

  // Map<String, dynamic> obj;

  EventDetails list;

  static String routeName = "/Events";
  @override
  Widget build(BuildContext context) {
    print("Eventsss list $list");
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          Container(),
          Padding(
            padding: const EdgeInsets.only(right: 10, top: 5, bottom: 5),
            child: Image.asset(
              "assets/images/ditu.png",
              width: 40,
            ),
          ),
        ],
        backgroundColor: Colors.white,
        leading: ClipOval(
          child: Padding(
            padding: const EdgeInsets.only(left: 10, top: 12, bottom: 12),
            child: Image.asset(
              "assets/images/youthopia_small.png",
            ),
          ),
        ),
        title:  Center(
            child: Text(
              list.name,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: kTextColorDark,fontWeight: FontWeight.w600,fontSize: 18),
            )),
      ),
      body: EventsBody(list: list),
    );
  }
}
//test comment