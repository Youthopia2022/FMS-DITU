import 'package:flutter/material.dart';
import 'package:fms_ditu/constants.dart';
import 'package:fms_ditu/screens/dashboard/components/BottomNavigationBar.dart';
import 'package:fms_ditu/screens/dashboard/components/Drawer.dart';
import 'package:fms_ditu/screens/dashboard/components/body.dart';
import 'package:fms_ditu/screens/events/events.dart';
import 'package:fms_ditu/screens/scoreboard/eventsSelection.dart';
import 'package:fms_ditu/screens/scoreboard/scoreboard.dart';

import '../cart/components/body.dart';
import '../profile/profilePage.dart';

class dashboard extends StatefulWidget {
  const dashboard({Key? key}) : super(key: key);

  static String routeName = "/dashboard";

  @override
  State<dashboard> createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {
  int _selectedIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final List<Widget> _tabList = [
    const DashboardBody(),
    const ProfilePage(), //ProfilePage()
    const CartBody(), //CartBody()
  ];

  final List<String> _headerList = [
    'Dashboard',
    'My Profile',
    'My Cart'
  ];

  void _update(int count) {
    setState(() => _selectedIndex = count);
  }

  void _openDrawer(int cnt) {
    _scaffoldKey.currentState?.openEndDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            key: _scaffoldKey,
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
                    _headerList[_selectedIndex],
                style: TextStyle(color: kTextColorDark,fontWeight: FontWeight.w600,fontSize: 18),
              )),
            ),
            body: _tabList[_selectedIndex],
            bottomNavigationBar: BottomNavBar(
              update: _update,
              openDrawer: _openDrawer,
            ),
            endDrawer: SideDrawer()));
  }
}
