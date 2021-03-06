import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fms_ditu/API/event_records.dart';
import 'package:fms_ditu/API/registration.dart';
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

  final String name = "";
  final String gender = "";

  int index = 0;

  logOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Map<String, dynamic> udList = {};

  String copiedID = UserPreferences.myUser.id
      .toString(); //list of registered events of individual participant, clickable button

  @override
  Widget build(BuildContext context) {
    // CollectionReference users = FirebaseFirestore.instance.collection('users');
    print("UID $uid");
    return FutureBuilder(
        future: FirebaseFirestore.instance.collection("users").doc(uid).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const loader();
          } else if (snapshot.hasData) {
            // var data = snapshot.data!.docs;
            // var value = data![data.indexOf(QueryDocumentSnapshot<Object?>uid)];
            udList = snapshot.data!.data() as Map<String, dynamic>;
            print('Listtt $udList}');
            //.doc.forEach((doc)
            // {
            //   print(doc);
            //   udList = doc.data() as Map<String, dynamic>;
            // });
            EventRecord.name = udList['username'];
            EventRecord.email = udList['email'];
            EventRecord.gender = udList['gender'];
            EventRecord.number = udList['phone number'];
            return Scaffold(
              body: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  // ignore: prefer_const_constructors
                  const SizedBox(height: 5),
                  ProfileWidget(
                    name: udList['username'], gender: udList['gender'],
                    //udList['username'],
                    //udList['gender'],
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
          Text(
            docs['username'].toString(),
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: kTextColorDark),
          ),
          const SizedBox(height: 16),
          InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              const snackBar = SnackBar(
                content: Text("ID copied to clipboard"),
              );
              Clipboard.setData(ClipboardData(text: uid)).then((value) {
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 150,
                  child: Text(
                    uid,
                    maxLines: 1,
                    style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        overflow: TextOverflow.ellipsis,
                        color: kTextColorDark),
                  ),
                ),
                const Icon(
                  Icons.copy,
                  size: 20,
                )
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text(
            "Mobile Number: ${docs['phone number'].toString()}",
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
              SizedBox(
                child: Text(
                  "College: ${docs['college'].toString()}",
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: kTextColorDark),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            child: Text(
              "Branch: ${docs['branch'].toString()}",
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: kTextColorDark),
            ),
          ),
          const SizedBox(
            height: 32,
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

  Widget registeredEvents() => StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("Registered Event")
            .doc("User personal")
            .collection(uid)
            .snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasData) {
            final docs = snapshot.data!.docs;
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: docs.length,
              itemBuilder: (context, index) {
                if (docs[index]['isPayed'] == true) {
                  Registration(
                      docs[index]['team leader'],
                      docs[index]['team name'],
                      docs[index]['team member'],
                      docs[index]['event name'],
                      docs[index]['date'],
                      docs[index]['time'],
                      docs[index]['timestamp'],
                      true)
                      .globalRegisterInFirestore();
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
                    title: Text(docs[index]['event name']),
                  );
                }
                return Container();
              },
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      );

  Widget logoutButton() => ButtonTheme(
        height: MediaQuery.of(context).size.height * 0.5,
        minWidth: 200,
        child: Align(
          alignment: Alignment.center,
          child: ElevatedButton(
              onPressed: () {
                setState(() {
                  logOut();
                  EventRecord.email = "";
                  EventRecord.name = "";
                  EventRecord.gender = "";
                  EventRecord.number = "";
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
