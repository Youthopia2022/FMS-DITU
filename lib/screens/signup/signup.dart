import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:fms_ditu/screens/signup/components/body.dart';

import '../../components/NoInternet.dart';

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);
  static String routeName = "/sign_up";
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        body: Builder(
          builder: (BuildContext context) {
            return OfflineBuilder(
                connectivityBuilder: (
                    BuildContext context,
                    ConnectivityResult connectivity,
                    Widget child,
                    ){
                  final connected = connectivity != ConnectivityResult.none;
                  return !connected?NoInternet():Body();
                },
                child: Container()
            );
          },
        ),
      ),
    );
  }
}
