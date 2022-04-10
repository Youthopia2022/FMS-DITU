import 'package:flutter/material.dart';
import 'package:fms_ditu/screens/dashboard/components/BottomNavigationBar.dart';
import 'package:fms_ditu/screens/dashboard/components/body.dart';

import '../cart/components/body.dart';
import '../events/components/body.dart';
import '../signin/signin.dart';

class dashboard extends StatefulWidget {
  const dashboard({Key? key}) : super(key: key);

  static String routeName = "/dashboard";

  @override
  State<dashboard> createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {

  int _selectedIndex = 0;

  final List<Widget> _tabList = [
    const DashboardBody(),
    const EventsBody(),
    const CartBody(),
    const SignIn()
  ];

  void _update(int count) {
    setState(() => _selectedIndex = count);
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: _tabList[_selectedIndex],
        bottomNavigationBar: BottomNavBar(update: _update)
      )
      );
  }
}