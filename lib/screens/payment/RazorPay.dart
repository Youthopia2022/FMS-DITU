import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fms_ditu/constants.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';


class RazorPay extends StatefulWidget {
  @override
  _RazorPayState createState() => _RazorPayState();
}

class _RazorPayState extends State<RazorPay> {
  static const platform = const MethodChannel("razorpay_flutter");

  late Razorpay _razorpay;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
                'ajkskajsd',
                style: TextStyle(color: kTextColorDark,fontWeight: FontWeight.w600,fontSize: 18),
              )),
        ),
        body: Center(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(onPressed: openCheckout, child: Text('Open'))
                ])),
      );
  }

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout() async {
    var options = {
      'key': 'rzp_live_ILgsfZCZoFIKMb',
      'amount': 100,
      'name': 'Youthopia 2022',
      'description': 'Robo Soccer',
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