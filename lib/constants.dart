import 'package:flutter/material.dart';

const kContainerColorPrimary = Color(0xffffffff);
const kContainerColorSecondary = Color(0xfff1f2f4);
const kButtonColorPrimary = Color(0xFF444150);
const kButtonColorSecondary = Color(0xffe8f1ff);
const kTextColorDark = Color(0xFF444150);
const kTextColorLight = Color(0xFF9896a5);
const kIconColorDark = Color(0xFF110f21);
const kIconColorLight = Color(0xFFD9D9D9);
const kErrorColor = Color(0xFFFB3838);
const kBackgroundColor = Color(0xFFF3F2F7);

final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Please Enter your email";
const String kQuantityNullError = "Please Enter quantity";
const String kQuantityError = "Please enter in multiple of min. quantity";
const String kInvalidEmailError = "Please Enter Valid Email";
const String kPassNullError = "Please Enter your password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Passwords don't match";
const String kNamelNullError = "Please Enter your name";
const String kPhoneNumberNullError = "Please Enter your phone number";
const String kAddressNullError = "Please Enter your address";
