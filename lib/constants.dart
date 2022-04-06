import 'package:flutter/material.dart';

// Don't use these colors. They will be changed in future
const kPrimaryColor = Color(0xFF025ACF);
const kPrimaryLightColor = Color(0xFFFFECDF);
const kPrimaryGradientColor = Color(0xFFFFECDF);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);


// Form Error
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