import 'package:fms_ditu/API/eventDetails.dart';

class CartSum {
  static final CartSum _singleton = CartSum._internal();
  static double total = 0;

  factory CartSum(var cartData) {
    return _singleton;
  }
  CartSum._internal();
}



