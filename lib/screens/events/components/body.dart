import 'package:flutter/material.dart';

import '../../../constants.dart';

// ignore: camel_case_types
class body extends StatefulWidget {
  const body({Key? key}) : super(key: key);

  @override
  State<body> createState() => _bodyState();
}

// ignore: camel_case_types
class _bodyState extends State<body> {
  var count = 0;
  bool written = false;
  final _formKey = GlobalKey<FormState>();
  bool isSoloAllowed = false; //remove later
  int minMembers = 3; //remove later
  int maxMembers = 4; //remove later //maxMembers - 1, 1 is the team leader
  bool isLeaderRequired = true; //remove later
  String eventName = "Cresendo"; //remove later
  String organizer = "CodeGenX";
  String eventDescription =
      "Indian solo, Western solo, duet, instrumental, rapping+beatboxing"; //remove later
  String eventDate = "22nd April, 2022"; //remove later
  String eventTime = "2:00 PM";
  String eventFee = "400";
  String about =
      "kjhiu snfise flksehfkaes flkafkeb dad/lkhf,ms,fmlkfb a d.kAHFkj AFkJHFj DSM<niofweyfj d,mahdkug jhbbamwc.kjguydchycd.bjhyiduuuhjasbwskjhweiuvyxbUIWAN;OYRBCAWX;NY;EITYAB;WCIUYRBCU;IYN;IUjchgxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx ,hguyxek76 675sl6estt,syts ytd uysd.iur s.idduyd fi.dlud.iuif u6lej/ .iuut;7rrjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjdddddddi.............................................. urry aoweu9q8euqbekjaw;o7e98q239 qCI IUWET RIJPRCO WIETR OWh'upir;oct'pocw rt;oicw owzyit";

  final List<Widget> _cardList = [];
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;

    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        Expanded(
          child: Container(
            color: (kBackgroundColor),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              buildEventPoster(height, width),
              const SizedBox(height: 20.0),
              buildEventDetails(),
              const SizedBox(height: 8),
              description(),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  addToCartButton(size),
                  const SizedBox(width: 12),
                  registerButton(size),
                ],
              )
            ]),
          ),
        ),
      ],
    );
  }

  Widget buildEventPoster(double height, double width) => const ClipRRect(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(12.0),
            bottomRight: Radius.circular(12.0)),
        child: Image(
          image: AssetImage('assets/images/test_poster.jpg'),
          alignment: Alignment.center,
        ),
      );

  Widget buildEventDetails() => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                eventName,
                style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: kTextColorDark),
              ),
              const SizedBox(height: 4),
              Text(
                eventDescription,
                style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: kTextColorDark),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    child: Row(
                      children: [
                        const Icon(
                          Icons.calendar_today,
                          // size: 14,
                          color: Colors.green,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          eventDate,
                          style: const TextStyle(
                              fontSize: 12,
                              color: kTextColorDark,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Container(
                    child: Row(
                      children: [
                        const Icon(
                          Icons.access_time,
                          // size: 14,
                          color: Colors.red,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          eventTime,
                          style: const TextStyle(
                              fontSize: 12,
                              color: kTextColorDark,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    child: Row(
                      children: [
                        const Icon(
                          Icons.monetization_on_rounded,
                          color: Colors.amber,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          '\u{20B9}$eventFee',
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: kTextColorDark),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Container(
                    child: Row(
                      children: [
                        const Icon(
                          Icons.handyman,
                          color: Colors.blue,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          organizer,
                          textAlign: TextAlign.end,
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: kTextColorDark),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(top: 16.0),
                child: Divider(color: kTextColorDark, thickness: 0.75),
              ),
            ]),
      );

  Widget description() => Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: Text(
              about,
              style: const TextStyle(color: kTextColorDark, fontSize: 14),
            ),
          ),
        ],
      );

  Widget addToCartButton(Size size) => ElevatedButton(
        onPressed: () {
          if (isSoloAllowed) {
            //add event to cart
            infoPopUp("Succesfully added to cart");
            //add for failure
          } else {
            teamRegistrationPopUp("Add to cart");
            //popup for adding team members and team leader, button for "add to cart"
          }
        },
        child: const Text(
          "Add to cart",
          style: TextStyle(color: kButtonColorSecondary),
        ),
        style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            primary: kButtonColorPrimary,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
                side: const BorderSide(color: kButtonColorPrimary))),
      );

  Widget registerButton(Size size) => ElevatedButton(
        onPressed: () {
          if (isSoloAllowed) {
            infoPopUp("Redirecting to payments page");
            //add for failure
          } else {
            teamRegistrationPopUp("Make Payment");
            //popup for adding team members and team leader, with a button for "Make payment"
          }
        },
        child: const Text(
          "Register Now",
          style: TextStyle(color: kButtonColorSecondary),
        ),
        style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            primary: kButtonColorPrimary,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
                side: const BorderSide(color: kButtonColorPrimary))),
      );

  Future infoPopUp(String message) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: kBackgroundColor,
              title: const Text(
                "Information",
                style: TextStyle(color: kTextColorDark),
              ),
              content: Text(
                message,
                style: const TextStyle(color: kTextColorDark, fontSize: 14),
              ),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      "OK",
                      style: TextStyle(color: kButtonColorPrimary),
                    )),
              ],
            ));
  }

  dynamic teamRegistrationPopUp(String message) {
    return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            backgroundColor: kBackgroundColor,
            content:
                ListView(physics: const BouncingScrollPhysics(), children: [
              Column(
                children: [
                  const SizedBox(
                    height: 40,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Participant Details",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            color: kTextColorDark,
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          style: const TextStyle(
                              fontSize: 12, color: kTextColorDark),
                          cursorColor: kButtonColorPrimary,
                          decoration: InputDecoration(
                            helperText: "Team Name",
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
                            prefixIcon: const Icon(
                              Icons.person,
                              color: kButtonColorPrimary,
                            ),
                            hintText: "Team Name",
                            hintStyle:
                                const TextStyle(color: kButtonColorPrimary),
                            filled: true,
                            fillColor: kButtonColorSecondary,
                          ),
                        ),
                        SizedBox(height: 12),
                        isLeaderRequired
                            ? TextFormField(
                                style: const TextStyle(
                                    fontSize: 12, color: kTextColorDark),
                                cursorColor: kButtonColorPrimary,
                                decoration: InputDecoration(
                                  helperText: "Team Leader Participant ID",
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: kButtonColorPrimary),
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: kButtonColorPrimary),
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  prefixIcon: const Icon(
                                    Icons.person,
                                    color: kButtonColorPrimary,
                                  ),
                                  hintText: "Team Leader Participant ID",
                                  hintStyle: const TextStyle(
                                      color: kButtonColorPrimary),
                                  filled: true,
                                  fillColor: kButtonColorSecondary,
                                ),
                              )
                            : const SizedBox(height: 0, width: 0),
                        const SizedBox(height: 12),
                        SizedBox(
                          height: 300,
                          width: 200,
                          child: ListView.builder(
                              physics: BouncingScrollPhysics(),
                              itemCount: _cardList.length,
                              itemBuilder: (context, index) {
                                if (index <= maxMembers) {
                                  // count++;
                                  return _cardList[index];
                                } else {
                                  if (written) {
                                    return const SizedBox
                                        .shrink(); //modify this
                                  } else {
                                    written = !written;
                                    return const SizedBox(
                                      height: 20,
                                      child: Text(
                                        "Max participant limit reached",
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    );
                                  }
                                }
                              }),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FloatingActionButton(
                              onPressed: () {
                                setState(() {
                                  count++;
                                  _cardList.add(_card());
                                  if (count > maxMembers) {
                                    // disable ebutton
                                  }
                                });
                              },
                              tooltip: 'Add',
                              child: const Icon(Icons.add),
                              backgroundColor: kButtonColorPrimary,
                              foregroundColor: kButtonColorSecondary,
                            ),
                            const SizedBox(width: 8),
                            FloatingActionButton(
                              onPressed: () {
                                setState(() {
                                  if (count > 1) {
                                    count--;
                                    print("deleted$count");
                                    _cardList.removeLast();
                                  } else {}
                                  if (count > maxMembers) {
                                    // disable ebutton
                                  }
                                });
                              },
                              tooltip: 'Delete',
                              child: const Icon(Icons.clear),
                              backgroundColor: kButtonColorPrimary,
                              foregroundColor: kButtonColorSecondary,
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                              onPressed: () {},
                              child: Text(
                                message,
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w500),
                              ),
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 16),
                                primary: kButtonColorPrimary,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    side: const BorderSide(
                                        color: kButtonColorPrimary)),
                                minimumSize: Size(
                                    MediaQuery.of(context).size.width * 0.30,
                                    MediaQuery.of(context).size.height * 0.05),
                              )),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ]),
          );
        });
      },
    );
  }

  Widget _card() {
    var container = Center(
        child: Padding(
      padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
      child: TextFormField(
        cursorColor: kButtonColorPrimary,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: -10),
          helperText: "Enter Participant ID",
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: kButtonColorPrimary),
            borderRadius: BorderRadius.circular(40),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: kButtonColorPrimary),
            borderRadius: BorderRadius.circular(40),
          ),
          prefixIcon: const Icon(
            Icons.person,
            color: kButtonColorPrimary,
          ),
          hintText: "Enter Participant ID",
          hintStyle: const TextStyle(color: kButtonColorPrimary),
          filled: true,
          fillColor: kButtonColorSecondary,
        ),
        style: const TextStyle(fontSize: 12, color: kTextColorDark),
      ),
    ));
    return container;
  }

// class Question extends StatefulWidget {
//   const Question({Key? key}) : super(key: key);

//   @override
//   State<Question> createState() => _QuestionState();
// }

// class _QuestionState extends State<Question> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 170.0,
//       padding: const EdgeInsets.all(8.0),
//       child: Column(children: <Widget>[
//         TextFormField(
//           decoration: const InputDecoration(
//             labelText: 'Contato',
//           ),
//         ),
//       ]),
//     );
//   }
// }

//   void addQuestion() {
//     setState(() {
//       _count = _count + 1;
//     });
}
// children: [
//         Expanded(
//           child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
//             buildEventPoster(height, width),
//             const SizedBox(height: 20.0),
//             buildEventDetails(),
//             const SizedBox(height: 8),
//             description(), //including cost
//             const SizedBox(height: 8),
//             addToCartButton(size),
//             const SizedBox(height: 8),
//             registerButton(size),
//             FloatingActionButton(
//               onPressed: _addQuestion,
//               tooltip: 'Add',
//               child: Icon(Icons.add),
//             ),
//             SizedBox(
//               height: 200,
//               width: 200,
//               child: ListView.builder(
//                   itemCount: _cardList.length,
//                   itemBuilder: (context, index) {
//                     return _cardList[index];
//                   }),
//             ),
//           ]
