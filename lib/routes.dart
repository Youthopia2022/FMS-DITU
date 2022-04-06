import 'package:flutter/widgets.dart';
import 'package:fms_ditu/screens/signin/signin.dart';
import 'package:fms_ditu/screens/signup/signup.dart';
import 'package:fms_ditu/screens/events/events.dart';
import 'package:fms_ditu/screens/dashboard/dashboard.dart';

final Map<String, WidgetBuilder> routes = {
  signin.routeName: (context) => const signin(),
  signup.routeName: (context) => const signup(),
  events.routeName: (context) => const events(),
  dashboard.routeName: (context) => const dashboard(),
};
