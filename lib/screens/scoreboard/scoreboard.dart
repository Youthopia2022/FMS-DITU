import 'package:flutter/material.dart';

import '../../constants.dart';

class Scoreboard extends StatefulWidget {
  const Scoreboard({Key? key}) : super(key: key);

  static String routeName = "/scoreboard";

  @override
  State<Scoreboard> createState() => _ScoreboardState();
}

class _ScoreboardState extends State<Scoreboard> {
  int i = 15;
  String participantID = "#12345";
  String teamName = "DITDancers";
  bool solo = false; //bool to check if team or solo participation
  late int marks;
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
        title: const Center(
            child: Text(
          "Marking",
          style: TextStyle(color: kTextColorDark),
        )),
      ),
      body: Container(
          color: kBackgroundColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
                // padding: EdgeInsets.all(5.0),
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
                          // side: const BorderSide(color: kButtonColorPrimary),
                        ),
                        selectedTileColor: Colors.grey[100],
                        title: Text(
                          participantID,
                          style: const TextStyle(
                              fontSize: 14, color: kTextColorDark),
                        ),
                        onTap: () {
                          scoreCard();
                        },
                      ),
                    )),
          )),
    );
  }

  Future<dynamic> scoreCard() => showDialog(
        context: context,
        builder: (context) => StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                backgroundColor: kBackgroundColor,
                title: const Text(
                  "Enter marks",
                  style: TextStyle(
                      fontSize: 16,
                      color: kTextColorDark,
                      fontWeight: FontWeight.w500),
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "*Note: Marks once entered cannot be chnaged",
                      style: TextStyle(fontSize: 14, color: kErrorColor),
                    ),
                    const Padding(padding: EdgeInsets.only(bottom: 14)),
                    Form(
                        key: _formkey,
                        child: TextFormField(
                          style: const TextStyle(
                              fontSize: 12, color: kTextColorDark),
                          cursorColor: kButtonColorPrimary,
                          decoration: InputDecoration(
                            helperText: solo
                                ? participantID
                                : teamName, //or participantID, based on bool value
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: kButtonColorPrimary),
                              borderRadius: BorderRadius.circular(40),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: kButtonColorPrimary),
                              borderRadius: BorderRadius.circular(40),
                            ),
                            prefixIcon: Icon(
                              solo ? Icons.person : Icons.people,
                              color: kButtonColorPrimary,
                            ),
                            hintText: teamName,
                            hintStyle:
                                const TextStyle(color: kButtonColorPrimary),
                            filled: true,
                            fillColor: kButtonColorSecondary,
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value!.isEmpty ||
                                int.parse(value) < 0 ||
                                int.parse(value) > 10) {
                              return "Enter marks between 0-10";
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) =>
                              setState(() => marks = int.parse(value!)),
                        )),
                    const SizedBox(
                      height: 5,
                    ),
                    Builder(
                      builder: (context) => ElevatedButton(
                        onPressed: () {
                          final isValid = _formkey.currentState?.validate();
                          if (isValid!) {
                            _formkey.currentState?.save();
                            const snackBar = SnackBar(
                              content: Text("Submitted"),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        },
                        child: const Text(
                          "Submit",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 16),
                          primary: kButtonColorPrimary,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              side:
                                  const BorderSide(color: kButtonColorPrimary)),
                          minimumSize: Size(
                              MediaQuery.of(context).size.width * 0.30,
                              MediaQuery.of(context).size.height * 0.05),
                        ),
                      ),
                    ),
                  ],
                ));
          },
        ),
      );
}
