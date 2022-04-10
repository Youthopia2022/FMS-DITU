import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import '../../../constants.dart';
import './BottomNavigationBar.dart';

class body extends StatefulWidget {
  const body({Key? key}) : super(key: key);

  @override
  State<body> createState() => _bodyState();
}

class _bodyState extends State<body> {
  var height, width;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: height * 0.015),
        const Padding(
          padding: EdgeInsets.only(left: 35, bottom: 10, top: 10),
          child: Text(
            "Top Events",
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: kTextColorDark),
          ),
        ),
        Container(
          height: height / 2.28,
          width: width,
          child: Swiper(
            itemBuilder: (BuildContext context, int index) {
              return Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Stack(
                      children: [
                        Container(
                          foregroundDecoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.transparent, Colors.transparent, Colors.transparent, kIconColorDark ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              stops: [0, 0.2, 0.8, 1],
                            ),
                          ),
                          child: Image.network(
                            "https://www.hellokpop.com/wp-content/uploads/2018/09/asf_5.png",
                            fit: BoxFit.cover,
                            height: height / 2.5,
                            width: width / 1.3,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Positioned(
                    bottom: 0.0,
                    right: 0.0,
                    left: 0.0,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10,right: 20,bottom: 45),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(LineIcons.calendar, color: Colors.white),
                                  Text("22nd April",
                                      style: TextStyle(color: Colors.white))
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(LineIcons.clock, color: Colors.white),
                                  Text("10:00 AM",
                                      style: TextStyle(color: Colors.white))
                                ],
                              )
                            ],
                          ),
                          Column(
                            children: [
                              ClipOval(
                                child: Material(
                                  color: kContainerColorPrimary, // Button color
                                  child: InkWell(
                                    splashColor:
                                        kContainerColorSecondary, // Splash color
                                    onTap: () {},
                                    child: SizedBox(
                                        width: width * 0.11,
                                        height: width * 0.11,
                                        child: Icon(LineIcons.addToShoppingCart)),
                                  ),
                                ),
                              ),
                              // ClipOval(
                              //   child: Material(
                              //     color: kContainerColorPrimary, // Button color
                              //     child: InkWell(
                              //       splashColor:
                              //           kContainerColorSecondary, // Splash color
                              //       onTap: () {},
                              //       child: SizedBox(
                              //           width: width * 0.1,
                              //           height: width * 0.1,
                              //           child: Icon(LineIcons.heart)),
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
            loop: false,
            pagination: const SwiperPagination(
                builder: DotSwiperPaginationBuilder(
                    color: kIconColorLight,
                    activeColor: kIconColorDark,
                    size: 5.0,
                    activeSize: 7)),
            itemHeight: height / 2.5,
            itemWidth: width / 1.3,
            layout: SwiperLayout.DEFAULT,
            itemCount: 10,
            viewportFraction: 0.8,
            scale: 0.9,
          ),
        ),
        SizedBox(height: height * 0.015),
      ],
    );
  }
}
