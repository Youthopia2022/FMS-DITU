import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fms_ditu/constants.dart';
import 'package:fms_ditu/screens/profile/user.dart';
import 'package:fms_ditu/screens/profile/userPreferences.dart';

import 'package:rive/rive.dart';

class ProfileWidget extends StatelessWidget {
  final ImageProvider<Object> img;

  const ProfileWidget({Key? key, required this.img}) : super(key: key);

  final UserData user = UserPreferences.myUser;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: buildImage(),
    );
  }

  Widget buildImage() {
    // const image = RiveAnimation.asset(
    //   'assets/rive/men.riv',
    //   animations: ['running'],
    // );
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const CircleAvatar(
                radius: 80,
                child: RiveAnimation.asset(
                  'assets/rive/avatar.riv',
                  animations: ['running'],
                ),
                // backgroundImage: image,
                backgroundColor: Colors.grey,
              ),
              const Padding(
                padding: EdgeInsets.only(right: 10),
              ),
              Column(
                children: [
                  Text(
                    user.id,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: kTextColorDark),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    user.name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: kTextColorDark),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
