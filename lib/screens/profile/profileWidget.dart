import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fms_ditu/constants.dart';
import 'package:fms_ditu/screens/profile/user.dart';
import 'package:fms_ditu/screens/profile/userPreferences.dart';

import 'package:rive/rive.dart';

class ProfileWidget extends StatelessWidget {
  ProfileWidget({Key? key, required this.name, required this.gender})
      : super(key: key);

  final String gender;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: buildImage(context),
    );
  }

  Widget buildImage(BuildContext context) {
      var height, width;
      height = MediaQuery.of(context).size.height;
      width = MediaQuery.of(context).size.width;
    print(name);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            width: width * 0.45,
            height: width * 0.45,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(width * 0.23),
              color: Colors.black,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(2),
              child: RiveAnimation.asset(
                gender=="Male"? "assets/rive/idleBoy.riv"
                    : "assets/rive/idleGirl.riv",
                animations: ['idlePreview'],
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
        ]),
      ),
    );
  }
}
