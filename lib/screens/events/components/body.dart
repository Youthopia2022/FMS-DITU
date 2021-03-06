import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fms_ditu/API/eventDetails.dart';
import 'package:fms_ditu/API/event_records.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:flutter/src/services/platform_channel.dart';

import '../../../API/cartSum.dart';
import '../../../API/registration.dart';
import '../../../constants.dart';

// ignore: camel_case_types
class EventsBody extends StatefulWidget {
  EventsBody({Key? key, required this.list}) : super(key: key);

  final EventDetails list;

  @override
  State<EventsBody> createState() => _EventsBodyState();
}

// ignore: camel_case_types
class _EventsBodyState extends State<EventsBody> {
  // static const platform = const MethodChannel("razorpay_flutter");

  late Razorpay _razorpay;

  static var auth = FirebaseAuth.instance;
  static User? user = auth.currentUser;
  String uid = user!.uid;

  var count = 0;
  bool written = false;

  String teamLeaderId = "";
  String teamName = "";
  List<String> teamMembers = [];

  final _formKey = GlobalKey<FormState>();

  static late int minMembers;
  static late int maxMembers; //maxMembers - 1, 1 is the team leader
  static late String eventName;
  static late String organizer;
  static late String eventDescription;
  static late String eventDate;
  static late String eventTime;
  static late double eventFee;
  static late String about;
  bool verified = false;
  var college;

  final List<Widget> _cardList = [];
  final List<String> participantsDetail = ["124", "123", "5"];

  late String imageURL = "";
  // String teamName = "Pta nhi"; //remove

  addToCartInFirestore() async {
    final auth = FirebaseAuth.instance;

    User? user = auth.currentUser;

    String uid = user!.uid;

    //for getting college name, for event fee
    var collection = FirebaseFirestore.instance.collection('users');
    var docSnapshot = await collection.doc('some_id').get();
    if (docSnapshot.exists) {
      Map<String, dynamic> data = docSnapshot.data()!;
      college = data["college"];
    }

    late Razorpay _razorpay;

    var time = DateTime.now();
    FirebaseFirestore.instance
        .collection("cart items")
        .doc(uid)
        .collection("my cart")
        .doc(time.toString())
        .set({
      "image": imageURL,
      "about": about,
      "fee": eventFee,
      "eventname": eventName,
      "date": eventDate,
      "time": eventTime,
      "timestamp": time.toString(),
      "team name": teamName,
      "participantID": participantsDetail,
    });

    Registration(uid, teamName, participantsDetail, eventName, eventDate,
            eventTime, time.toString(), false)
        .registerInFirestore();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    eventName = widget.list.name;
    about = widget.list.about;
    eventDescription = widget.list.venue;
    organizer = widget.list.club;
    minMembers = (widget.list.min).toInt();
    maxMembers = (widget.list.max).toInt();
    eventName = widget.list.name;
    eventDate = widget.list.date;
    eventTime = widget.list.time;
    eventFee = (college == "DIT")
        ? (widget.list.eventFeeDit)
        : (widget.list.eventFeeNonDit);
    imageURL = widget.list.image;

    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;

    bool isSoloAllowed = (maxMembers == 1) ? true : false;
    bool isLeaderRequired = (maxMembers == 1) ? false : true;

    return SafeArea(
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          // Expanded(
          //   child:
          Container(
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
                  addToCartButton(size, isSoloAllowed, isLeaderRequired),
                  const SizedBox(width: 12),
                  registerButton(size, isSoloAllowed, isLeaderRequired),
                ],
              )
            ]),
          ),
          // ),
        ],
      ),
    );
  }

  Widget buildEventPoster(double height, double width) => ClipRRect(
        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(12.0),
            bottomRight: Radius.circular(12.0)),
        child: Image(
          height: MediaQuery.of(context).size.height * 0.5,
          image: NetworkImage(imageURL),
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          overflow: TextOverflow.ellipsis,
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    width: MediaQuery.of(context).size.width*0.5,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Icon(
                          Icons.handyman,
                          color: Colors.blue,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Container(
                          child: Text(
                            organizer,
                            textAlign: TextAlign.end,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: kTextColorDark),
                          ),
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

  Widget addToCartButton(
          Size size, bool isSoloAllowed, bool isLeaderRequired) =>
      ElevatedButton(
        onPressed: () {
          if (isSoloAllowed) {
            addToCartInFirestore();
            infoPopUp("Succesfully added to cart");
            //add for failure
          } else {
            teamRegistrationPopUp("Add to cart", isLeaderRequired);
            //popup for adding team members and team leader, button for  "add to cart"
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

  Widget registerButton(Size size, bool isSoloAllowed, bool isLeaderRequired) =>
      ElevatedButton(
        onPressed: () {
          if (isSoloAllowed) {
            infoPopUp("Redirecting to payments page");
            openCheckout(); //redirect to payments page
            //add for failure
          } else {
            teamRegistrationPopUp("Make Payment", isLeaderRequired);
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

  dynamic teamRegistrationPopUp(String message, bool isLeaderRequired) {
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
                          onSaved: (value) => setState(() => teamName = value!),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Not a valid Team name";
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(height: 12),
                        isLeaderRequired
                            ? TextFormField(
                                style: const TextStyle(
                                    fontSize: 12, color: kTextColorDark),
                                cursorColor: kButtonColorPrimary,
                                decoration: InputDecoration(
                                  helperText: "Team Leader's Participant ID",
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
                                  hintText: "Team Leader's Participant ID",
                                  hintStyle: const TextStyle(
                                      color: kButtonColorPrimary),
                                  filled: true,
                                  fillColor: kButtonColorSecondary,
                                ),
                                onSaved: (value) =>
                                    setState(() => teamLeaderId = value!),
                                validator: (value) {
                                  if (value!.length != 28) {
                                    return "Participant ID must be 28 characters long";
                                  } else {
                                    return null;
                                  }
                                },
                              )
                            : const SizedBox(height: 0, width: 0),
                        const SizedBox(height: 12),
                        Container(
                          height: 300,
                          width: 200,
                          child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: _cardList.length,
                              itemBuilder: (context, index) {
                                if (index < (maxMembers - 1)) {
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
                                  if (count < maxMembers) {
                                    count++;
                                    _cardList.add(_card(_formKey));
                                  }
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
                              onPressed: () {
                                final isValid =
                                    _formKey.currentState!.validate();
                                if (isValid) {
                                  _formKey.currentState!.save();
                                  message == "Add to cart"
                                      ? addToCartInFirestore()
                                      : null; //redirect to make payments page
                                }
                              },
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

  Widget _card(GlobalKey<FormState> _formKey) {
    var container = Center(
        child: Padding(
      padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
      child: TextFormField(
        cursorColor: kButtonColorPrimary,
        decoration: InputDecoration(
          // contentPadding: const EdgeInsets.symmetric(vertical: -10),
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
        onSaved: (value) => setState(() => teamMembers.add(value!)),
        validator: (value) {
          if (value!.length != 28) {
            return "Participant ID must be 28 characters long";
          } else {
            return null;
          }
        },
      ),
    ));
    return container;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DoubleProperty('eventFee', eventFee));
  }

  void openCheckout() async {
    var options = {
      'key': 'rzp_live_ILgsfZCZoFIKMb',
      'amount': eventFee * 100,
      'name': 'Youthopia 2022',
      'description': 'Payment for youthopia event',
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {'contact': EventRecord.number, 'email': EventRecord.email},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print('Success Response: $response');
    Fluttertoast.showToast(
        msg: "SUCCESS: " + response.paymentId!,
        toastLength: Toast.LENGTH_SHORT);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print('Error Response: $response');
    Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString() + " - " + response.message!,
        toastLength: Toast.LENGTH_SHORT);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print('External SDK Response: $response');
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName!,
        toastLength: Toast.LENGTH_SHORT);
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
