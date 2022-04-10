import 'package:flutter/material.dart';
import 'package:fms_ditu/screens/dashboard/components/BottomNavigationBar.dart';
import 'package:fms_ditu/screens/dashboard/components/body.dart';

class dashboard extends StatefulWidget {
  const dashboard({Key? key}) : super(key: key);

  static String routeName = "/dashboard";

  @override
  State<dashboard> createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: body(),
        bottomNavigationBar: const BottomNavBar()
      )
      );
  }
}