import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fms_ditu/screens/profile/user.dart';
import 'package:fms_ditu/screens/profile/userPreferences.dart';

class ProfileWidget extends StatelessWidget {
  final ImageProvider<Object> img;

  const ProfileWidget({Key? key, required this.img}) : super(key: key);

  final User user = UserPreferences.myUser;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: buildImage(),
    );
  }

  Widget buildImage() {
    final image = Image(
      image: img,
    );
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 80,
                backgroundImage: img, //add image according to gender recieved
              ),
              const Padding(
                padding: EdgeInsets.only(right: 10),
              ),
              Column(
                children: [
                  Text(
                    user.id,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    user.name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 24),
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
