import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:fms_ditu/screens/signin/components/body.dart';

import '../../components/NoInternet.dart';

class SignIn extends StatelessWidget {
  const SignIn({Key? key}) : super(key: key);

  static String routeName = "/sign_in";
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
                  return !connected?NoInternet():SingleChildScrollView(
                    child: Body(),
                  );
                },
                child: Container()
            );
          },
        ),
      ),
    );
  }
}
