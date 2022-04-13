import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fms_ditu/constants.dart';
import 'package:fms_ditu/screens/profile/profileWidget.dart';
import 'package:fms_ditu/screens/profile/user.dart';
import 'package:fms_ditu/screens/profile/userPreferences.dart';
import 'package:fms_ditu/screens/signin/signin.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);
  static String routeName = "/profile";
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  logOut() async{
    await FirebaseAuth.instance.signOut();
  }


  UserData user = UserPreferences.myUser;
  List<String> names = [
    "Robo soccer",
    "Sherlocked"
  ]; //list of registered events of individual participant, clickable button

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          ProfileWidget(
            img: (user.gender == "Male")
                ? (const AssetImage("assets/images/male_icon.jpg"))
                : (const AssetImage("assets/images/female_icon.jpg")),
          ),
          const SizedBox(height: 24),
          buildDetails(user),
          registeredEvents(),
          const SizedBox(
            height: 32,
          ),
          logoutButton(),
        ],
      ),
    );
  }

  Widget buildDetails(UserData user) => Column(
        children: [
          Text(
            "Mobile Number: ${user.phone}",
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
                "Year: ${user.year.toString()}",
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
                "Branch: ${user.branch.toString()}",
                style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: kTextColorDark),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            "College: ${user.college.toString()}",
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
                setState(()  {
                  logOut();
                  Navigator.pushReplacement((context), MaterialPageRoute(builder: (context) => const SignIn()));
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
