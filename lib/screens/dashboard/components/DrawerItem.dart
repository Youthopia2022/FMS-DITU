import 'package:flutter/material.dart';
import 'package:fms_ditu/constants.dart';

class DrawerItem extends StatelessWidget {
  const DrawerItem({Key? key, required this.name, required this.icon, required this.onPressed}) : super(key: key);

  final String name;
  final IconData icon;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: SizedBox(
        height: 20,
        child: Row(
          children: [
            Icon(icon, size: 23, color: kTextColorDark,),
            const SizedBox(width: 20,),
            Text(name, style: const TextStyle(fontSize: 16, color: kTextColorDark),)
          ],
        ),
      ),
    );
  }
}