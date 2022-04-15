import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fms_ditu/constants.dart';
import 'package:fms_ditu/screens/dashboard/components/DrawerItem.dart';
import 'package:fms_ditu/screens/signin/signin.dart';

class SideDrawer extends StatefulWidget {
  const SideDrawer({Key? key}) : super(key: key);

  @override
  State<SideDrawer> createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
  // int _selectedDestination = 0;
  // void selectDestination(int index) {
  //   setState(() {
  //     _selectedDestination = index;
  //   });
  // }
  var height, width;

  static const String url = "https://images.vexels.com/media/users/3/145908/raw/52eabf633ca6414e60a7677b0b917d92-male-avatar-maker.jpg";
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(width * 0.08),
          bottomLeft: Radius.circular(width * 0.08)),
      child: Container(
        width: width * 0.8,
        child: Drawer(
          child: Material(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24.0, 80, 24, 0),
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: width * 0.1,
                        backgroundImage: NetworkImage(url),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Person name',
                              style: TextStyle(
                                  fontSize: 14, color: kTextColorDark)),
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: width*0.4,
                            child: Text(
                              "ahsxkjasknjcacasjkn@gmail.com",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                              style: TextStyle(color: kTextColorDark, fontSize: 14),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                   SizedBox(
                    height: height*0.045,
                  ),
                  const Divider(
                    thickness: 1,
                    height: 10,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    height: height*0.045,
                  ),
                  DrawerItem(
                    name: 'Leaderboard',
                    icon: Icons.assessment_rounded,
                    onPressed: () => onItemPressed(context, index: 0),
                  ),
                  SizedBox(
                    height: height*0.03,
                  ),
                  DrawerItem(
                      name: 'Meet our team',
                      icon: Icons.people,
                      onPressed: () => onItemPressed(context, index: 1)),
                  SizedBox(
                    height: height*0.03,
                  ),
                  DrawerItem(
                      name: 'Visit our website',
                      icon: Icons.web_sharp,
                      onPressed: () => onItemPressed(context, index: 2)),
                  SizedBox(
                    height: height*0.04,
                  ),
                  const Divider(
                    thickness: 1,
                    height: 10,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    height: height*0.04,
                  ),
                  DrawerItem(
                      name: 'Log out',
                      icon: Icons.logout,
                      onPressed: () => onItemPressed(context, index: 4)),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Todo: Social media handles
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onItemPressed(BuildContext context, {required int index}) {
    Navigator.pop(context);

    switch (index) {
      case 0:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const SignIn()));
        break;
      case 1:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const SignIn()));
        break;
      case 2:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const SignIn()));
        break;
      case 3:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const SignIn()));
        break;
      case 4:
        FirebaseAuth.instance.signOut();
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const SignIn()));
        break;
    }
  }
}
