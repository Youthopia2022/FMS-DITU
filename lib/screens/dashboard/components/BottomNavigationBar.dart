import 'package:flutter/material.dart';
import 'package:fms_ditu/constants.dart';
import 'package:fms_ditu/screens/signin/signin.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key, required this.update}) : super(key: key);
  final ValueChanged<int> update;
  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            color: Colors.black.withOpacity(.1),
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
        child: GNav(
          rippleColor: kButtonColorSecondary,
          backgroundColor: Colors.white,
          hoverColor: Colors.grey[100]!,
          gap: 8,
          activeColor: Colors.black,
          iconSize: 24,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          duration: const Duration(milliseconds: 400),
          tabBackgroundColor: kButtonColorSecondary,
          color: Colors.black,
          tabs: [
            GButton(
              icon: LineIcons.home,
              onPressed: () => widget.update(0),
              text: 'Home',
              iconActiveColor: kIconColorDark,
              iconColor: kIconColorLight,
            ),
            GButton(
              icon: LineIcons.user,
              onPressed: () => widget.update(1),
              text: 'Profile',
              iconActiveColor: kIconColorDark,
              iconColor: kIconColorLight,
            ),
            GButton(
              icon: LineIcons.shoppingCart,
              onPressed: () => widget.update(2),
              text: 'Cart',
              iconActiveColor: kIconColorDark,
              iconColor: kIconColorLight,
            ),
            GButton(
              icon: const IconData(0xf36e, fontFamily: 'MaterialIcons'),
              onPressed: () => widget.update(3),
              text: 'More',
              iconActiveColor: kIconColorDark,
              iconColor: kIconColorLight,
            ),
          ],
          selectedIndex: _selectedIndex,
          onTabChange: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
    );
  }
}
