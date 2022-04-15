import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fms_ditu/routes.dart';
import 'package:fms_ditu/screens/dashboard/components/body.dart';
import 'package:fms_ditu/screens/dashboard/dashboard.dart';
import 'package:fms_ditu/screens/event_entry/event_entry.dart';
import 'package:fms_ditu/screens/events/events.dart';
import 'package:fms_ditu/screens/profile/profilePage.dart';
import 'package:fms_ditu/screens/signin/signin.dart';
import 'package:fms_ditu/screens/signup/signup.dart';
import 'package:fms_ditu/sizeConfig.dart';
import 'package:splashscreen/splashscreen.dart';
import 'constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'montserrat',
        primaryColor: kTextColorDark,
        scaffoldBackgroundColor: kBackgroundColor,
      ),
      title: 'FMS DITU',
      home: SafeArea(
        child: SplashScreen(
            seconds: 2,
            navigateAfterSeconds: StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasData) {
                  return const dashboard();
                } else {
                  return const SignIn();
                }
              },
            ),
            title: const Text(
              'Welcome to Youthopia\'22',
              style: TextStyle(fontSize: 18),
            ),
            image: new Image.asset('assets/images/youthopiaLogo.png'),
            backgroundColor: Colors.white,
            loadingText: Text(
              "Ankit Jailwal | Ayush Santri | Shubhi Agarwal",
              style: TextStyle(fontSize: 10),
            ),
            styleTextUnderTheLoader: new TextStyle(),
            photoSize: 100.0,
            loaderColor: kTextColorDark),
      ),
      routes: routes,
    );
  }
}
