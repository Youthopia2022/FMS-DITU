import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fms_ditu/API/event_records.dart';
import 'package:fms_ditu/constants.dart';
import 'package:fms_ditu/screens/dashboard/components/DrawerItem.dart';
import 'package:fms_ditu/screens/signin/signin.dart';
import 'package:rive/rive.dart';
import 'package:url_launcher/url_launcher.dart';

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
  static var auth = FirebaseAuth.instance;
  static User? user = auth.currentUser;
  String uid = user!.uid;

  static const _websiteUrl = "http://youthopia.dituniversity.co.in/";
  static const _instaUrl = "https://www.instagram.com/ditu.youthopia/";
  static const _fbUrl = "https://www.facebook.com/ditu.youthopia";
  static const _twitterUrl = "https://twitter.com/ditu_youthopia";

  Future<void> getUserData() async {
    if (EventRecord.gender.isEmpty ||
        EventRecord.email.isEmpty ||
        EventRecord.name.isEmpty) {
      var userData =
          await FirebaseFirestore.instance.collection("users").doc(uid).get();
      var data = userData.data();
      EventRecord.email = data?.entries.elementAt(5).value;
      EventRecord.name = data?.entries.elementAt(6).value;
      EventRecord.gender = data?.entries.elementAt(1).value;
      EventRecord.number = data?.entries.elementAt(3).value;
    }
  }

  Future<void> _launchInBrowser(String url) async {
    if (!await launch(
      url,
      forceSafariVC: false,
      forceWebView: false,
      headers: <String, String>{'my_header_key': 'my_header_value'},
    )) {
      throw 'Could not launch $url';
    }
  }

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
                  FutureBuilder(
                      future: getUserData(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                              child: const CircularProgressIndicator(
                            color: kTextColorDark,
                          ));
                        }
                        return Row(
                          children: [
                            Container(
                              width: width * 0.20,
                              height: width * 0.20,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(width * 0.23),
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
                                  EventRecord.gender == "Male"
                                      ? "assets/rive/idleBoy.riv"
                                      : "assets/rive/idleGirl.riv",
                                  animations: ['idlePreview'],
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(EventRecord.name,
                                    style: TextStyle(
                                        fontSize: 14, color: kTextColorDark)),
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  width: width * 0.4,
                                  child: Text(
                                    EventRecord.email,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: false,
                                    style: TextStyle(
                                        color: kTextColorDark, fontSize: 14),
                                  ),
                                ),
                              ],
                            )
                          ],
                        );
                      }),
                  SizedBox(
                    height: height * 0.045,
                  ),
                  const Divider(
                    thickness: 1,
                    height: 10,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    height: height * 0.045,
                  ),
                  DrawerItem(
                    name: 'Leaderboard',
                    icon: Icons.assessment_rounded,
                    onPressed: () => onItemPressed(context, index: 0),
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  DrawerItem(
                      name: 'Meet our team',
                      icon: Icons.people,
                      onPressed: () => onItemPressed(context, index: 1)),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  DrawerItem(
                      name: 'Visit our website',
                      icon: Icons.web_sharp,
                      onPressed: () => onItemPressed(context, index: 2)),
                  SizedBox(
                    height: height * 0.04,
                  ),
                  const Divider(
                    thickness: 1,
                    height: 10,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    height: height * 0.04,
                  ),
                  DrawerItem(
                      name: 'Log out',
                      icon: Icons.logout,
                      onPressed: () => onItemPressed(context, index: 3)),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      
                      InkWell(
                          onTap: () => onItemPressed(context, index: 4),
                          child: SvgPicture.asset("assets/images/fb.svg",height: height*0.04,color: kTextColorDark,)),
                      SizedBox(width: width*0.03,),
                      InkWell(
                          onTap: () => onItemPressed(context, index: 5),
                          child: SvgPicture.asset("assets/images/insta.svg",height: height*0.04,color: kTextColorDark,)),
                      SizedBox(width: width*0.03,),
                      InkWell(
                          onTap: () => onItemPressed(context, index: 6),
                          child: SvgPicture.asset("assets/images/twitter.svg",height: height*0.04,color: kTextColorDark,)),
                    ],
                  ),
                  SizedBox(height: height*0.03)
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
        _launchInBrowser(_websiteUrl);
        break;
      case 3:
        FirebaseAuth.instance.signOut();
        EventRecord.email = "";
        EventRecord.name = "";
        EventRecord.gender = "";
        EventRecord.number = "";
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const SignIn()));
        break;
      case 4:
        _launchInBrowser(_fbUrl);
        break;
      case 5:
        _launchInBrowser(_instaUrl);
        break;
      case 6:
        _launchInBrowser(_twitterUrl);
        break;
    }
  }
}
