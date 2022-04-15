import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fms_ditu/constants.dart';
import 'package:fms_ditu/screens/profile/profileWidget.dart';
import 'package:fms_ditu/screens/profile/user.dart';
import 'package:fms_ditu/screens/profile/userPreferences.dart';
import 'package:fms_ditu/screens/signin/signin.dart';

import '../../components/loader.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);
  static String routeName = "/profile";
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  static var auth = FirebaseAuth.instance;
  static User? user = auth.currentUser;
  String uid = user!.uid;

  int index = 0;

  logOut() async {
    await FirebaseAuth.instance.signOut();
  }

  List<String> names = ["Robo soccer", "Sherlocked"];

  Map<String, dynamic> udList = {};

  String copiedID = UserPreferences.myUser.id
      .toString(); //list of registered events of individual participant, clickable button

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseFirestore.instance.collection("users").get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const loader();
          } else if (snapshot.hasData) {
            snapshot.data!.docs.forEach(
                (doc) => {udList = doc.data() as Map<String, dynamic>});
            return Scaffold(
              body: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  // ignore: prefer_const_constructors
                  ProfileWidget(
                      name: "Shubhi", //udList['username'],
                      gender: "Female" //udList['gender'],
                      ),
                  const SizedBox(height: 24),
                  buildDetails(udList),
                  registeredEvents(),
                  const SizedBox(
                    height: 32,
                  ),
                  logoutButton(),
                ],
              ),
            );
          } else {
            return const SizedBox();
          }
        });
  }

  Widget buildDetails(Map<String, dynamic> docs) => Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                docs['username'].toString(),
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: kTextColorDark),
              ),
              IconButton(
                  onPressed: () {
                    const snackBar = SnackBar(
                      content: Text("ID copied to clipboard"),
                    );
                    Clipboard.setData(ClipboardData(text: copiedID))
                        .then((value) {
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    });
                  },
                  icon: const Icon(Icons.copy)),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            "Mobile Number: ${docs['phone']!.toString()}",
            style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18,
                color: kTextColorDark),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Year: ${docs['year'].toString()}",
                style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: kTextColorDark),
              ),
              const SizedBox(
                width: 8,
                child: VerticalDivider(),
              ),
              Text(
                "Branch: ${docs['branch'].toString()}",
                style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: kTextColorDark),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            "College: ${docs['college'].toString()}",
            style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18,
                color: kTextColorDark),
          ),
          SizedBox(
            height: 32,
            child: Divider(
              thickness: 1,
              indent: 20,
              endIndent: (MediaQuery.of(context).size.width) - 20, //not working
            ),
          ),
          const Text(
            "Registered Events",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: kTextColorDark),
          )
        ],
      );

  Widget registeredEvents() => ListView.builder(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: names.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: kButtonColorPrimary,
            foregroundColor: kButtonColorSecondary,
            child: IconButton(
                onPressed: () {
                  //call registered event page
                },
                icon: const Icon(Icons.people_rounded)),
          ),
          trailing: CircleAvatar(
            backgroundColor: kButtonColorPrimary,
            foregroundColor: kButtonColorSecondary,
            child: IconButton(
              onPressed: () {
                //call events page
              },
              icon: const Icon(Icons.arrow_circle_right),
            ),
          ),
          title: Text(names[index]),
        );
      });

  Widget logoutButton() => ButtonTheme(
        height: MediaQuery.of(context).size.height * 0.5,
        minWidth: 200,
        child: Align(
          alignment: Alignment.center,
          child: ElevatedButton(
              onPressed: () {
                setState(() {
                  logOut();
                  Navigator.pushReplacement((context),
                      MaterialPageRoute(builder: (context) => const SignIn()));
                });
              },
              child: const Text(
                "Logout",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                primary: kButtonColorPrimary,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    side: const BorderSide(color: kButtonColorPrimary)),
                minimumSize: Size(MediaQuery.of(context).size.width * 0.30,
                    MediaQuery.of(context).size.height * 0.05),
              )),
        ),
      );
}
