import 'package:flutter/widgets.dart';
import 'package:fms_ditu/screens/profile/profilePage.dart';
import 'package:fms_ditu/screens/signin/signin.dart';
import 'package:fms_ditu/screens/signup/signup.dart';
import 'package:fms_ditu/screens/events/events.dart';
import 'package:fms_ditu/screens/dashboard/dashboard.dart';

final Map<String, WidgetBuilder> routes = {
  SignIn.routeName: (context) => const SignIn(),
  SignUp.routeName: (context) => const SignUp(),
  Events.routeName: (context) => const Events(),
  dashboard.routeName: (context) => const dashboard(),
  ProfilePage.routeName: (context) => const ProfilePage(),
};
