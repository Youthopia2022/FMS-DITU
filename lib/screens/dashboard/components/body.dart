import 'package:card_swiper/card_swiper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fms_ditu/components/loader.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../constants.dart';
import './BottomNavigationBar.dart';

class DashboardBody extends StatefulWidget {
  const DashboardBody({Key? key}) : super(key: key);

  @override
  State<DashboardBody> createState() => _DashboardBodyState();
}

class _DashboardBodyState extends State<DashboardBody> {
  var height, width;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return FutureBuilder(
        future: FirebaseFirestore.instance.collection("events").get(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return loader();
          }
          else if(snapshot.hasData){
            print("Snapshottt ${snapshot.data}");
          }
        return SingleChildScrollView(
          child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: height * 0.015),
                  // const Padding(
                  //   padding: EdgeInsets.only(left: 35, bottom: 10, top: 10),
                  //   child: Text(
                  //     "Top Events",
                  //     style: TextStyle(
                  //         fontSize: 24,
                  //         fontWeight: FontWeight.bold,
                  //         color: kTextColorDark),
                  //   ),
                  // ),
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
                                        colors: [
                                          Colors.transparent,
                                          Colors.transparent,
                                          Colors.transparent,
                                          kIconColorDark
                                        ],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        stops: [0, 0.2, 0.8, 1],
                                      ),
                                    ),
                                    child: Image.network(
                                      "https://d1csarkz8obe9u.cloudfront.net/posterpreviews/trippy-modern-creative-rock-concert-poster-design-template-a449ecc056eed70aa9e48b6f3f2e636f_screen.jpg",
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
                                padding: const EdgeInsets.only(
                                    left: 10, right: 20, bottom: 45),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(LineIcons.calendar,
                                            color: Colors.white),
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
                                    // Column(
                                    //   children: [
                                    //     ClipOval(
                                    //       child: Material(
                                    //         color:
                                    //             kContainerColorPrimary, // Button color
                                    //         child: InkWell(
                                    //           splashColor:
                                    //               kContainerColorSecondary, // Splash color
                                    //           onTap: () {},
                                    //           child: SizedBox(
                                    //               width: width * 0.11,
                                    //               height: width * 0.11,
                                    //               child: Icon(
                                    //                   LineIcons.addToShoppingCart)),
                                    //         ),
                                    //       ),
                                    //     ),
                                    //   ],
                                    // ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                      loop: true,
                      autoplay: true,
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
                      physics: BouncingScrollPhysics(),
                      viewportFraction: 0.8,
                      scale: 0.9,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10, bottom: 10, right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: const Text(
                            "Technical",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: kTextColorDark),
                          ),
                        ),
                        Container(
                          height: width * 0.3*1.4,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: 10,
                            itemBuilder: (BuildContext context, int index) => Row(
                              children: [
                                SizedBox(
                                  width: 4,
                                ),
                                GestureDetector(
                                    onTap: () {},
                                    child: SizedBox(
                                      width: width * 0.3,
                                      height: width * 0.3*1.4,
                                      child: ClipRRect(
                                          borderRadius: BorderRadius.circular(5),
                                          child: Image.network(
                                            "https://i.pinimg.com/originals/d4/49/5c/d4495c4e1fbd3bca820490cf20975f8d.jpg",
                                            fit: BoxFit.fill,
                                          )),
                                    )),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: height * 0.015),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: const Text(
                            "Cultural",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: kTextColorDark),
                          ),
                        ),
                        Container(
                          height: width * 0.46*1.4,
                          width: width,
                          child: Center(
                            child: ListView.builder(
                              shrinkWrap: false,
                              scrollDirection: Axis.horizontal,
                              itemCount: 2,
                              itemBuilder: (BuildContext context, int index) => Row(
                                children: [
                                  index == 0
                                      ? Container()
                                      : SizedBox(width: width * 0.02),
                                  GestureDetector(
                                    onTap: () {},
                                    child: Center(
                                      child: Container(
                                        height: width * 0.46*1.4,
                                        width: width * 0.46,
                                        child: ClipRRect(
                                            borderRadius: BorderRadius.circular(10),
                                            child: Image.network(
                                              "https://marketplace.canva.com/EAE674LNif0/2/0/1131w/canva-club-cyber-party-night-promotion-poster-j-RytAB4ThY.jpg",
                                              fit: BoxFit.fill,
                                            )),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: height * 0.015),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: const Text(
                            "Informal",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: kTextColorDark),
                          ),
                        ),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemCount: 34,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 4,
                            crossAxisSpacing: 4,
                          ),
                          itemBuilder: (context, index) => Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    print("Pressed $index");
                                  },
                                  child: Container(
                                    width: width * 0.3,
                                    height: width * 0.3,
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
                                        child: Image.network(
                                          "https://m.media-amazon.com/images/M/MV5BZWNkMzVkN2EtOGZkYi00MjYwLWE4YjItNDBlZTRkZmY2NDkxXkEyXkFqcGdeQXVyMjE2MDg1MDQ@._V1_.jpg",
                                          fit: BoxFit.fill,
                                        )),
                                  )),
                            ],
                          ),
                        ),
                        SizedBox(height: height * 0.015),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: const Text(
                            "Debate & Declamation",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: kTextColorDark),
                          ),
                        ),
                        Container(
                          height: width * 0.30*1.4,
                          width: width,
                          child: Center(
                            child: ListView.builder(
                              shrinkWrap: false,
                              scrollDirection: Axis.horizontal,
                              itemCount: 3,
                              itemBuilder: (BuildContext context, int index) => Row(
                                children: [
                                  index == 0
                                      ? Container()
                                      : SizedBox(width: width * 0.02),
                                  GestureDetector(
                                    onTap: () {},
                                    child: Center(
                                      child: Container(
                                        height: width * 0.30*1.4,
                                        width: width * 0.30,
                                        child: ClipRRect(
                                            borderRadius: BorderRadius.circular(10),
                                            child: Image.network(
                                              "https://d1csarkz8obe9u.cloudfront.net/posterpreviews/debate-design-template-74075a22d130b91c103d5a9eac326944_screen.jpg",
                                              fit: BoxFit.fill,
                                            )),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: height * 0.015),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: const Text(
                            "Gaming",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: kTextColorDark),
                          ),
                        ),
                        Container(
                          height: width * 0.46*1.4,
                          width: width,
                          child: Center(
                            child: ListView.builder(
                              shrinkWrap: false,
                              scrollDirection: Axis.horizontal,
                              itemCount: 2,
                              itemBuilder: (BuildContext context, int index) => Row(
                                children: [
                                  index == 0
                                      ? Container()
                                      : SizedBox(width: width * 0.02),
                                  GestureDetector(
                                    onTap: () {},
                                    child: Center(
                                      child: Container(
                                        height: width * 0.46*1.4,
                                        width: width * 0.46,
                                        child: ClipRRect(
                                            borderRadius: BorderRadius.circular(10),
                                            child: Image.network(
                                              "https://m.media-amazon.com/images/I/91A1IwuM9KL._AC_SY741_.jpg",
                                              fit: BoxFit.fill,
                                            )),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: height * 0.06),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: width * 0.55,
                              child: Text(
                                "can't find what you're looking for?",
                                style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w600,
                                    color: kTextColorLight),
                              ),
                            ),
                            SizedBox(height: height * 0.015),
                            Container(
                              width: width * 0.6,
                              child: Text(
                                "raise your query request and we will get back to you soon.",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: kTextColorLight),
                              ),
                            ),
                            SizedBox(height: height * 0.02),
                            Container(
                              width: width * 0.4,
                              child: InkWell(
                                onTap: () {
                                  launch("tel://214324234");
                                },
                                highlightColor: Colors.transparent,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Raise query",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: kTextColorDark),
                                    ),
                                    SizedBox(width: width * 0.01),
                                    Icon(
                                      LineIcons.chevronCircleRight,
                                      size: 14,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: height * 0.015),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
        );
      }
    );
  }
}
