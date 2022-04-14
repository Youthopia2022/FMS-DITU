import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fms_ditu/constants.dart';
import 'package:fms_ditu/screens/profile/user.dart';
import 'package:fms_ditu/screens/profile/userPreferences.dart';

import 'package:rive/rive.dart';

class ProfileWidget extends StatelessWidget {
  final String avatarType;

  const ProfileWidget({Key? key, required this.avatarType}) : super(key: key);

  final UserData user = UserPreferences.myUser;

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
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                    avatarType,
                    animations: ['idlePreview'],
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              const Padding(
                padding: EdgeInsets.only(right: 10),
              ),
              Column(
                children: [
                  Text(
                    user.name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: kTextColorDark),
                  ),
                  const SizedBox(height: 8),
                  FlatButton(
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: user.id));
                      var snackBar = const SnackBar(
                        content: Text(
                          'User ID copied!',
                          style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'montserrat',
                              fontWeight: FontWeight.w600),
                        ),
                        duration: Duration(seconds: 1),
                        backgroundColor: kTextColorDark,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: width * 0.5,
                          child: Text(
                            user.id,
                            maxLines: 1,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                overflow: TextOverflow.ellipsis,
                                color: kTextColorDark),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        const Icon(
                          Icons.copy,
                          color: kTextColorDark,
                          size: 18,
                        ),
                      ],
                    ),
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
