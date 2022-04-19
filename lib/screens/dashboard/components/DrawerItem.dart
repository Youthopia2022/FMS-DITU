import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fms_ditu/constants.dart';

class DrawerItem extends StatefulWidget {
  const DrawerItem({Key? key, required this.name, required this.icon, required this.onPressed}) : super(key: key);

  final String name;
  final IconData icon;
  final Function() onPressed;

  @override
  State<DrawerItem> createState() => _DrawerItemState();
}

class _DrawerItemState extends State<DrawerItem> {
  bool isNotActive = false;

  @override
  Widget build(BuildContext context) {
    isNotActive = (widget.name=="Leaderboard"||widget.name=="Meet our team");
    return InkWell(
      onTap: isNotActive?(){
        Fluttertoast.showToast(msg: "${widget.name} will be available soon!");
      }: widget.onPressed,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: SizedBox(
        height: 20,
        child: Row(
          children: [
            Icon(widget.icon, size: 23, color: isNotActive?kTextColorLight:kTextColorDark,),
            const SizedBox(width: 20,),
            Text(widget.name, style:  TextStyle(fontSize: 16, color: isNotActive?kTextColorLight:kTextColorDark),)
          ],
        ),
      ),
    );
  }
}