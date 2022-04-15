import 'dart:ffi';

import 'package:flutter/widgets.dart';
import 'package:fms_ditu/API/eventDetails.dart';
import 'package:fms_ditu/API/event_records.dart';
import 'package:fms_ditu/screens/profile/profilePage.dart';
//import 'package:fms_ditu/screens/scoreboard/scoreboard.dart';
import 'package:fms_ditu/screens/signin/signin.dart';
import 'package:fms_ditu/screens/signup/signup.dart';
import 'package:fms_ditu/screens/events/events.dart';
import 'package:fms_ditu/screens/dashboard/dashboard.dart';

// EventDetails obj =
//     EventDetails('', "", "", "", "", 0, 0, "", false, 0, 0, "", "");

final Map<String, WidgetBuilder> routes = {
  SignIn.routeName: (context) => const SignIn(),
  SignUp.routeName: (context) => const SignUp(),
  // Events.routeName: (context) => Events(
  //       list: obj,
  //     ),
  dashboard.routeName: (context) => const dashboard(),
  ProfilePage.routeName: (context) => const ProfilePage(),
  //Scoreboard.routeName: (context) => const Scoreboard(),
};
