import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fms_ditu/API/cartSum.dart';
import 'package:fms_ditu/constants.dart';
import 'package:fms_ditu/screens/payment/RazorPay.dart';
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
  static const platform = const MethodChannel("razorpay_flutter");

  late Razorpay _razorpay;
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
    for(int i=0;i<data.length;i++){
      total +=  data[i]['fee'];
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
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const loader();
          } else {

            final docs = snapshot.data!.docs;
            carSum(docs);
            return docs.length == 0
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Container(
                          height: height * 0.4,
                          child: RiveAnimation.asset('assets/rive/cart.riv'),
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
                              padding: EdgeInsets.only(top: 10.0, bottom: 15.0),
                              itemBuilder: (BuildContext context, int index) {
                                return Column(
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: 5, right: 5),
                                      child: Container(
                                        width: width,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              blurRadius: 5.0,
                                              offset: Offset(0, 3),
                                            ),
                                          ],
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              top: 10,
                                              bottom: 10,
                                              left: 15,
                                              right: 20),
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
                                                                    docs[index]['image'],
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
                                                              Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                                                          style: TextStyle(
                                                                              color: kTextColorDark,
                                                                              fontSize: 15,
                                                                              fontWeight: FontWeight.w600),
                                                                        ),
                                                                      ),
                                                                      Container(
                                                                        height: height*0.068,
                                                                        width: width *
                                                                            0.4,
                                                                        child:
                                                                            Text(
                                                                          docs[index]
                                                                              [
                                                                              'about'],
                                                                          style: TextStyle(
                                                                              color: kTextColorLight,
                                                                              fontSize: 11,
                                                                              overflow: TextOverflow.ellipsis,
                                                                              fontWeight: FontWeight.w500),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),

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
                                                                          FirebaseFirestore
                                                                              .instance
                                                                              .collection('cart items')
                                                                              .doc(uid)
                                                                              .collection("my cart")
                                                                              .doc(docs[index]['timestamp'])
                                                                              .delete();
                                                                        },
                                                                        child: SizedBox(
                                                                            width: width *
                                                                                0.11,
                                                                            height: width *
                                                                                0.11,
                                                                            child:
                                                                                Icon(LineIcons.trash)),
                                                                      ),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                              Divider(),
                                                              Row(
                                                                children: [
                                                                  Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [

                                                                      Row(
                                                                        children: [
                                                                          Icon(
                                                                            LineIcons.clock,
                                                                            color:
                                                                                kTextColorLight,
                                                                            size:
                                                                                18,
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                5,
                                                                          ),
                                                                          Text(
                                                                            docs[index]['time'],
                                                                            style: TextStyle(
                                                                                color: kTextColorLight,
                                                                                fontSize: 12,
                                                                                fontWeight: FontWeight.w500),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          Icon(
                                                                            LineIcons.calendar,
                                                                            color:
                                                                                kTextColorLight,
                                                                            size:
                                                                                18,
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                5,
                                                                          ),
                                                                          Text(
                                                                            docs[index]['date'],
                                                                            style: TextStyle(
                                                                                color: kTextColorLight,
                                                                                fontSize: 12,
                                                                                fontWeight: FontWeight.w500),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color:
                                                                          kButtonColorSecondary,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              15),
                                                                    ),
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
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
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                12,
                                                                            fontWeight:
                                                                                FontWeight.w600),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
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
                        decoration: BoxDecoration(
                            color: kButtonColorPrimary,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20))),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 15, right: 10, top: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "₹${CartSum.total}",
                                style: TextStyle(
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
                                        Text("Pay with"),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Image.asset(
                                          'assets/images/upi.png',
                                          width: width * 0.12,
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
      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
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
}
