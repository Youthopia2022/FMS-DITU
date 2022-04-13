import 'package:flutter/material.dart';
import 'package:fms_ditu/screens/event_entry/components/EventBrief.dart';
import 'package:fms_ditu/screens/event_entry/components/EventShort.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const EventBrief()),
                );
              },
              child: Text("Add Event Info(Brief)"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const EventShort()),
                );
              },
              child: Text("Add Event Info(Short)"),
            ),
          ),
        ],
      ),
    );
  }
}
