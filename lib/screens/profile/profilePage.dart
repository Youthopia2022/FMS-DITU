import 'package:flutter/material.dart';
import 'package:fms_ditu/screens/profile/profileWidget.dart';
import 'package:fms_ditu/screens/profile/user.dart';
import 'package:fms_ditu/screens/profile/userPreferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);
  static String routeName = "/profile";
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<String> names = [
    "Robo soccer",
    "Sherlocked"
  ]; //list of registered events of individual participant

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          const ProfileWidget(
            img: AssetImage("assets/images/male_icon.png"),
          ),
          const SizedBox(height: 24),
          buildDetails(UserPreferences.myUser),
          registeredEvents(),
          logoutButton(),
        ],
      ),
    );
  }

  Widget buildDetails(User user) => Column(
        children: [
          Text(
            "Mobile Number: ${user.phone}",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Year: ${user.year.toString()}",
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                "Branch: ${user.branch.toString()}",
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
            ],
          ),
          Text(
            "College: ${user.college.toString()}",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(
            width: 8,
          ),
          const Text(
            "Registered Events",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          )
        ],
      );

  Widget registeredEvents() => ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: names.length,
      itemBuilder: (context, index) {
        return ListTile(title: Text(names[index]));
      });

  Widget logoutButton() => ElevatedButton(
        onPressed: () {},
        child: const Text("Logout"),
      );
}
