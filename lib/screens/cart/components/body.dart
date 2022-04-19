import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fms_ditu/API/cartSum.dart';
import 'package:fms_ditu/API/event_records.dart';
import 'package:fms_ditu/API/registration.dart';
import 'package:fms_ditu/constants.dart';
import 'package:line_icons/line_icons.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:rive/rive.dart';

import '../../../components/loader.dart';

class CartBody extends StatefulWidget {
  const CartBody({Key? key}) : super(key: key);

  @override
  State<CartBody> createState() => _CartBodyState();
}

class _CartBodyState extends State<CartBody> {
  static const platform = MethodChannel("razorpay_flutter");

  late Razorpay _razorpay;
  late bool _register = false;

  @override
  void initState() {
    getUID();
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  var height, width;
  String uid = "";
  getUID() {
    final auth = FirebaseAuth.instance;

    User? user = auth.currentUser;

    uid = user!.uid;
    print(uid);
  }

  Future carSum(var data) async {
    double total = 0;
    for (int i = 0; i < data.length; i++) {
      total += data[i]['fee'];
    }
    CartSum.total = total;
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('cart items')
            .doc(uid)
            .collection("my cart")
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          EventRecord.registeredEvents.removeRange(0, EventRecord.registeredEvents.length);
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const loader();
          } else {
            final docs = snapshot.data!.docs;
            carSum(docs);
            return docs.isEmpty
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: SizedBox(
                          height: height * 0.4,
                          child: const RiveAnimation.asset('assets/rive/cart.riv'),
                        ),
                      ),
                      const Text(
                        "Your cart is empty",
                        style: TextStyle(
                            color: kTextColorDark,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  )
                : Column(
                    children: [
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Expanded(
                          child: ListView.builder(
                              itemCount: docs.length, //list view declaration
                              padding: const EdgeInsets.only(top: 10.0, bottom: 15.0),
                              itemBuilder: (BuildContext context, int index) {
                                if(_register == true) {
                                  FirebaseFirestore.instance.collection("Registered Event").doc("User personal").collection(uid).doc(docs[index]['timestamp']).update({"isPayed" : true});
                                  FirebaseFirestore.instance.collection('cart items').doc(uid).collection("my cart").doc(docs[index]['timestamp']).delete();
                                }
                                print(EventRecord.registeredEvents.length);
                                return Column(
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 5, right: 5),
                                      child: Container(
                                        width: width,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              blurRadius: 5.0,
                                              offset: const Offset(0, 3),
                                            ),
                                          ],
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 10,
                                              bottom: 10,
                                              left: 15,
                                              right: 15),
                                          child: Column(
                                            children: [
                                              Column(
                                                children: [
                                                  Center(
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                            width:
                                                                height * 0.12,
                                                            height:
                                                                height * 0.15,
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                              child:
                                                                  Image.network(
                                                                docs[index]
                                                                    ['image'],
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            )),

                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 10),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              SizedBox(
                                                                width: width *
                                                                    0.59,
                                                                child: Row(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Container(
                                                                          child:
                                                                              Text(
                                                                            docs[index]['team name'],
                                                                            style: const TextStyle(
                                                                                color: kTextColorDark,
                                                                                fontSize: 15,
                                                                                fontWeight: FontWeight.w600),
                                                                          ),
                                                                        ),
                                                                        Container(
                                                                          height:
                                                                              height * 0.068,
                                                                          width:
                                                                              width * 0.4,
                                                                          child:
                                                                              Text(
                                                                            docs[index]['about'],
                                                                            style: const TextStyle(
                                                                                color: kTextColorLight,
                                                                                fontSize: 11,
                                                                                overflow: TextOverflow.ellipsis,
                                                                                fontWeight: FontWeight.w500),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Center(
                                                                      child:
                                                                          ClipOval(
                                                                        child:
                                                                            Material(
                                                                          color:
                                                                              kContainerColorPrimary, // Button color
                                                                          child:
                                                                              InkWell(
                                                                            splashColor:
                                                                                kButtonColorSecondary, // Splash color
                                                                            onTap:
                                                                                () {
                                                                                  FirebaseFirestore.instance.collection("Registered Event").doc("For judges").collection(docs[index]['eventname']).doc(docs[index]['timestamp']).delete();
                                                                              FirebaseFirestore.instance.collection("Registered Event").doc("User personal").collection(uid).doc(docs[index]['timestamp']).delete();
                                                                              FirebaseFirestore.instance.collection('cart items').doc(uid).collection("my cart").doc(docs[index]['timestamp']).delete();
                                                                            },
                                                                            child: SizedBox(
                                                                                width: width * 0.11,
                                                                                height: width * 0.11,
                                                                                child: const Icon(LineIcons.trash)),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                              const Divider(),
                                                              SizedBox(
                                                                width: width *
                                                                    0.59,
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Row(
                                                                          children: [
                                                                            const Icon(
                                                                              LineIcons.clock,
                                                                              color: kTextColorLight,
                                                                              size: 18,
                                                                            ),
                                                                            const SizedBox(
                                                                              width: 5,
                                                                            ),
                                                                            Text(
                                                                              docs[index]['time'],
                                                                              style: const TextStyle(color: kTextColorLight, fontSize: 12, fontWeight: FontWeight.w500),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        Row(
                                                                          children: [
                                                                            const Icon(
                                                                              LineIcons.calendar,
                                                                              color: kTextColorLight,
                                                                              size: 18,
                                                                            ),
                                                                            const SizedBox(
                                                                              width: 5,
                                                                            ),
                                                                            Text(
                                                                              docs[index]['date'],
                                                                              style: const TextStyle(color: kTextColorLight, fontSize: 12, fontWeight: FontWeight.w500),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    const Divider(
                                                                      thickness:
                                                                          2,
                                                                    ),
                                                                    Container(
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color:
                                                                            kButtonColorSecondary,
                                                                        borderRadius:
                                                                            BorderRadius.circular(15),
                                                                      ),
                                                                      child:
                                                                          Padding(
                                                                        padding: const EdgeInsets.only(
                                                                            left:
                                                                                14,
                                                                            right:
                                                                                14,
                                                                            top:
                                                                                8,
                                                                            bottom:
                                                                                8),
                                                                        child:
                                                                            Text(
                                                                          "₹${docs[index]['fee']}",
                                                                          style: const TextStyle(
                                                                              fontSize: 12,
                                                                              fontWeight: FontWeight.w600),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),

                                                              // SizedBox(height: 4,),
                                                            ],
                                                          ),
                                                        ),
                                                        // SizedBox(width: width*0.06),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: height * 0.015,
                                    ),
                                  ],
                                );
                              })),
                      Container(
                        width: width,
                        decoration: const BoxDecoration(
                            color: kButtonColorPrimary,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: const Radius.circular(20))),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 15, right: 10, top: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "₹${CartSum.total}",
                                style: const TextStyle(
                                    fontSize: 22,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              ),

                              //TODO: RazerPay Gateway
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 12, bottom: 12),
                                child: FlatButton(
                                  onPressed: openCheckout,
                                  child: Container(
                                    width: width * 0.4,
                                    height: height * 0.05,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const Text("Pay with"),
                                        const SizedBox(width: 5,),
                                        Image.asset(
                                          'assets/images/razorpay.png',
                                          width: width * 0.18,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  );
          }
        });
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout() async {
    var options = {
      'key': 'rzp_live_ILgsfZCZoFIKMb',
      'amount': CartSum.total*100,
      'name': 'Youthopia 2022',
      'description': 'Payment for youthopia event',
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {'contact': EventRecord.number, 'email': EventRecord.email},
      // 'external': {
      //   'wallets': ['paytm']
      // }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    setState(() {
      _register = true;
    });

    print('Success Response: $response');
    Fluttertoast.showToast(
        msg: "SUCCESS: " + response.paymentId!,
        toastLength: Toast.LENGTH_SHORT);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    var errorData = jsonDecode(response.message.toString());
    print('Error Response: ${errorData}');

    Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString() + " - " + errorData['error']['description']!,
        toastLength: Toast.LENGTH_SHORT);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print('External SDK Response: $response');
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName!,
        toastLength: Toast.LENGTH_SHORT);
  }
}
