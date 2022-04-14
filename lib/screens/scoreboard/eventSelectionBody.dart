import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fms_ditu/constants.dart';
import 'package:fms_ditu/screens/scoreboard/scoreboard.dart';

class EventSelectionMain extends StatefulWidget {
  const EventSelectionMain({Key? key}) : super(key: key);

  @override
  State<EventSelectionMain> createState() => _EventSelectionMainState();
}

class _EventSelectionMainState extends State<EventSelectionMain> {
  int i = 10;
  String eventTitle = "Crescendo";
  String organizer = "Mesmeronica";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: kBackgroundColor,
          child: ListView.builder(
              padding: const EdgeInsets.all(8),
              physics: const BouncingScrollPhysics(),
              itemCount: i,
              itemBuilder: (context, index) => Card(
                    shadowColor: kButtonColorPrimary,
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      selectedTileColor: Colors.grey[100],
                      title: Text(
                        eventTitle,
                        style: const TextStyle(
                            fontSize: 14, color: kTextColorDark),
                      ),
                      subtitle: Text(
                        organizer,
                        style: const TextStyle(
                            fontSize: 12, color: kTextColorLight),
                      ),
                      onTap: () {
                        Scoreboard();
                        // Navigator.push(
                        //     context,
                        //     CupertinoPageRoute(
                        //         builder: (redContext) =>
                        //             const Scoreboard())); //chnage to calling body
                      },
                    ),
                  ))),
    );
  }
}
