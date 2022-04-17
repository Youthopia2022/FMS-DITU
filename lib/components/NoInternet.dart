import 'package:flutter/material.dart';
import 'package:fms_ditu/constants.dart';
import 'package:rive/rive.dart';

class NoInternet extends StatefulWidget {
  const NoInternet({Key? key}) : super(key: key);

  @override
  State<NoInternet> createState() => _NoInternetState();
}

class _NoInternetState extends State<NoInternet> {

  late RiveAnimationController _controller;

  /// Is the animation currently playing?
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _controller = OneShotAnimation(
      'Hit',
      autoplay: false,
      onStop: () => setState(() => _isPlaying = false),
      onStart: () => setState(() => _isPlaying = true),
    );
  }
  var height, width;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          focusColor: Colors.transparent,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () => _isPlaying ? null : _controller.isActive = true,
          child: Container(
            height: height * 0.4,
            child:  RiveAnimation.asset(
              'assets/rive/zombie.riv',
              animations: const ['In', 'Walk'],
              controllers: [_controller],
            ),
          ),
        ),
        SizedBox(height: 20,),
        Text("No internet!",style: TextStyle(fontSize: 24,fontWeight: FontWeight.w600,color: kTextColorDark),),
        Text("Meanwhile you can hit the zombie",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: kTextColorLight),)
      ],
    );
  }
}


