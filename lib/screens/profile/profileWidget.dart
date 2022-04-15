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
      child: buildImage(),
    );
  }

  Widget buildImage() {
    print(name);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          CircleAvatar(
            radius: 100,
            child: RiveAnimation.asset(
              (gender == "Male")
                  ? 'assets/rive/male_avatar_final.riv'
                  : 'assets/rive/female_avatar_final.riv', //female animation not working
              // animations: ['running'],
            ),
            backgroundColor: Colors.grey,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              name,
              // overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: kTextColorDark),
            ),
          )
        ]),
      ),
    );
  }
}
