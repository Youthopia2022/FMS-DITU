import 'package:flutter/material.dart';
import 'package:fms_ditu/constants.dart';
import 'package:fms_ditu/screens/dashboard/components/BottomNavigationBar.dart';
import 'package:fms_ditu/screens/dashboard/components/Drawer.dart';
import 'package:fms_ditu/screens/dashboard/components/body.dart';

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
    const ProfilePage(),
    const CartBody(),
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
                new Container(),
                Padding(
                  padding: const EdgeInsets.only(right: 10, top: 5, bottom: 5),
                  child: Image.asset(
                    "assets/images/ditu.png",
                    width: 40,
                  ),
                ),
              ],
              backgroundColor: Colors.white,
              leading: Padding(
                padding: const EdgeInsets.only(left: 12, top: 7, bottom: 7),
                child: ClipOval(
                    child: Container(
                      padding: EdgeInsets.all(7),
                      color: Colors.amber,
                      child: Image.asset(
                  "assets/images/youthopia_small.png",
                ),
                    )),
              ),
              title: Center(
                  child: Text(
                "Dashboard",
                style: TextStyle(color: kTextColorDark),
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
