import 'package:card_swiper/card_swiper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fms_ditu/API/eventDetails.dart';
import 'package:fms_ditu/components/loader.dart';
import 'package:fms_ditu/screens/cart/cart.dart';
import 'package:fms_ditu/screens/events/events.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../constants.dart';
import './BottomNavigationBar.dart';
import 'package:fms_ditu/API/event_records.dart';

class DashboardBody extends StatefulWidget {
  const DashboardBody({Key? key}) : super(key: key);

  @override
  State<DashboardBody> createState() => _DashboardBodyState();
}

class _DashboardBodyState extends State<DashboardBody> {
  var height, width;

  // EventRecord EventRecord() = new EventRecord();

  // Map<String, dynamic> details = {};

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return FutureBuilder(
        future: FirebaseFirestore.instance.collection("events").get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const loader();
          } else if (snapshot.hasData) {
            final docs = snapshot.data!.docs;
            int n = docs.length;
            print("Snapshottt ${snapshot.data!.docs[0]['category']}");
            print(n);
            for (int i = 0; i < n; i++) {
              if (docs[i]['isTopEvent'] == true) {
                EventRecord.topEvent.add(EventDetails(
                    docs[i]['event name'],
                    docs[i]['venue'],
                    docs[i]['about'],
                    docs[i]['club'],
                    docs[i]['date'].toString(),
                    (1.0 * docs[i]['eventFeeDIT']),
                    (1.0 * docs[i]['eventFeeNonDIT']),
                    docs[i]['image'],
                    docs[i]['isTopEvent'],
                    (1.0 * docs[i]['max_member']),
                    (1.0 * docs[i]['min_member']),
                    docs[i]['time'],
                    docs[i]['category']));
                // eventDetails.addEntries(newEntries)
              }
              if (docs[i]['category'] == "Technical") {
                EventRecord.technicalEvent.add(EventDetails(
                    docs[i]['event name'],
                    docs[i]['venue'],
                    docs[i]['about'],
                    docs[i]['club'],
                    docs[i]['date'].toString(),
                    (1.0 * docs[i]['eventFeeDIT']),
                    (1.0 * docs[i]['eventFeeNonDIT']),
                    docs[i]['image'],
                    docs[i]['isTopEvent'],
                    (1.0 * docs[i]['max_member']),
                    (1.0 * docs[i]['min_member']),
                    docs[i]['time'],
                    docs[i]['category']));
              }
              // else if (docs[i]['category'] == "Informal") {
              //   EventRecord().informalEvent.add(
              //       EventDetails(
              //           docs[i]['event name'],
              //           docs[i]['venue'],
              //           docs[i]['about'],
              //           docs[i]['club'],
              //           docs[i]['date'].toString(),
              //           (1.0 * docs[i]['eventFeeDIT']),
              //           (1.0 * docs[i]['eventFeeNonDIT']),
              //           docs[i]['image'],
              //           docs[i]['isTopEvent'],
              //           (1.0 * docs[i]['max_member']),
              //           (1.0 * docs[i]['min_member']),
              //           docs[i]['time'],
              //           docs[i]['category']));
              // }
              else if (docs[i]['category'] == "Debate and Declamation" ||
                  docs[i]['category'] == "Debate") {
                EventRecord.debateEvent.add(EventDetails(
                    docs[i]['event name'],
                    docs[i]['venue'],
                    docs[i]['about'],
                    docs[i]['club'],
                    docs[i]['date'].toString(),
                    (1.0 * docs[i]['eventFeeDIT']),
                    (1.0 * docs[i]['eventFeeNonDIT']),
                    docs[i]['image'],
                    docs[i]['isTopEvent'],
                    (1.0 * docs[i]['max_member']),
                    (1.0 * docs[i]['min_member']),
                    docs[i]['time'],
                    docs[i]['category']));
              } else if (docs[i]['category'] == "Gaming") {
                EventRecord.gamingEvent.add(EventDetails(
                    docs[i]['event name'],
                    docs[i]['venue'],
                    docs[i]['about'],
                    docs[i]['club'],
                    docs[i]['date'].toString(),
                    (1.0 * docs[i]['eventFeeDIT']),
                    (1.0 * docs[i]['eventFeeNonDIT']),
                    docs[i]['image'],
                    docs[i]['isTopEvent'],
                    (1.0 * docs[i]['max_member']),
                    (1.0 * docs[i]['min_member']),
                    docs[i]['time'],
                    docs[i]['category']));
              } else if (docs[i]['category'] == "Cultural") {
                EventRecord.culturalEvent.add(EventDetails(
                    docs[i]['event name'],
                    docs[i]['venue'],
                    docs[i]['about'],
                    docs[i]['club'],
                    docs[i]['date'].toString(),
                    (1.0 * docs[i]['eventFeeDIT']),
                    (1.0 * docs[i]['eventFeeNonDIT']),
                    docs[i]['image'],
                    docs[i]['isTopEvent'],
                    (1.0 * docs[i]['max_member']),
                    (1.0 * docs[i]['min_member']),
                    docs[i]['time'],
                    docs[i]['category']));
              }
            }
            print("Tech ${EventRecord.technicalEvent.length}");
            print("Top ${EventRecord.topEvent.length}");
            print("Cul ${EventRecord.culturalEvent.length}");
            print("infor ${EventRecord.informalEvent.length}");
            print("game ${EventRecord.gamingEvent.length}");
            print("debate ${EventRecord.debateEvent.length}");
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
                                    EventRecord.topEvent[index].image,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(LineIcons.calendar,
                                          color: Colors.white),
                                      Text(EventRecord.topEvent[index].date,
                                          style: const TextStyle(
                                              color: Colors.white))
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Icon(LineIcons.clock,
                                          color: Colors.white),
                                      Text(EventRecord.topEvent[index].time,
                                          style: const TextStyle(
                                              color: Colors.white))
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
                    onTap: (index) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                Events(list: EventRecord.topEvent[index]),
                          ));
                      //navigator.push to events
                    },
                    itemWidth: width / 1.3,
                    layout: SwiperLayout.DEFAULT,
                    itemCount: EventRecord.topEvent.length,
                    physics: const BouncingScrollPhysics(),
                    viewportFraction: 0.8,
                    scale: 0.9,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 10, bottom: 10, right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Text(
                          "Technical",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: kTextColorDark),
                        ),
                      ),
                      Container(
                        height: width * 0.3 * 1.4,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: EventRecord.technicalEvent.length,
                          itemBuilder: (BuildContext context, int index) => Row(
                            children: [
                              const SizedBox(
                                width: 4,
                              ),
                              GestureDetector(
                                  onTap: () {
                                    // details.addAll(EventRecord.technicalEvent[index]
                                    //     as Map<String, dynamic>);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Events(
                                          list:
                                              EventRecord.technicalEvent[index],
                                        ), //correct it
                                      ),
                                    );
                                  },
                                  child: Container(
                                    width: width * 0.3,
                                    height: width * 0.3 * 1.4,
                                    color: kButtonColorSecondary,
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
                                        child: Image.network(
                                          EventRecord
                                              .technicalEvent[index].image,
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
                        child: Text(
                          "Cultural",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: kTextColorDark),
                        ),
                      ),
                      Container(
                        height: width * 0.46 * 1.4,
                        width: width,
                        child: Center(
                          child: ListView.builder(
                            shrinkWrap: false,
                            scrollDirection: Axis.horizontal,
                            itemCount: EventRecord.culturalEvent.length,
                            itemBuilder: (BuildContext context, int index) =>
                                Row(
                              children: [
                                index == 0
                                    ? Container()
                                    : SizedBox(width: width * 0.02),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Events(
                                            list: EventRecord
                                                .culturalEvent[index],
                                          ),
                                        ));
                                    // details.addAll(EventRecord.culturalEvent[index]
                                    //     as Map<String,
                                    //         dynamic>); //navigator.puch to events
                                  },
                                  child: Center(
                                    child: Container(
                                      height: width * 0.46 * 1.4,
                                      width: width * 0.46,
                                      color: kButtonColorSecondary,
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.network(
                                            EventRecord
                                                .culturalEvent[index].image,
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
                        child: Text(
                          "Informal",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: kTextColorDark),
                        ),
                      ),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        itemCount: EventRecord.informalEvent.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 4,
                          crossAxisSpacing: 4,
                        ),
                        itemBuilder: (context, index) => Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Events(
                                          list:
                                              EventRecord.informalEvent[index],
                                        ),
                                      ));
                                  // details.addAll(EventRecord.informalEvent[index]
                                  //     as Map<String, dynamic>);
                                },
                                child: Container(
                                  width: width * 0.3,
                                  height: width * 0.3,
                                  color: kButtonColorSecondary,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: Image.network(
                                        EventRecord.informalEvent[index].image,
                                        fit: BoxFit.fill,
                                      )),
                                )),
                          ],
                        ),
                      ),
                      SizedBox(height: height * 0.015),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Text(
                          "Debate & Declamation",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: kTextColorDark),
                        ),
                      ),
                      Container(
                        height: width * 0.30 * 1.4,
                        width: width,
                        child: Center(
                          child: ListView.builder(
                            shrinkWrap: false,
                            scrollDirection: Axis.horizontal,
                            itemCount: EventRecord.debateEvent.length,
                            itemBuilder: (BuildContext context, int index) =>
                                Row(
                              children: [
                                index == 0
                                    ? Container()
                                    : SizedBox(width: width * 0.02),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Events(
                                            list:
                                                EventRecord.debateEvent[index],
                                          ),
                                        ));
                                    // details.addAll(EventRecord.debateEvent[index]
                                    //     as Map<String,
                                    //         dynamic>); //navigator.push
                                  },
                                  child: Center(
                                    child: Container(
                                      height: width * 0.30 * 1.4,
                                      width: width * 0.30,
                                      color: kButtonColorSecondary,
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.network(
                                            EventRecord
                                                .debateEvent[index].image,
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
                        child: Text(
                          "Gaming",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: kTextColorDark),
                        ),
                      ),
                      Container(
                        height: width * 0.46 * 1.4,
                        width: width,
                        child: Center(
                          child: ListView.builder(
                            shrinkWrap: false,
                            scrollDirection: Axis.horizontal,
                            itemCount: EventRecord.gamingEvent.length,
                            itemBuilder: (BuildContext context, int index) =>
                                Row(
                              children: [
                                index == 0
                                    ? Container()
                                    : SizedBox(width: width * 0.02),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Events(
                                            list:
                                                EventRecord.gamingEvent[index],
                                          ),
                                        ));
                                    // details.addAll(EventRecord.gamingEvent[index]
                                    //     as Map<String, dynamic>); //navigator
                                  },
                                  child: Center(
                                    child: Container(
                                      height: width * 0.46 * 1.4,
                                      width: width * 0.46,
                                      color: kButtonColorSecondary,
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.network(
                                            EventRecord
                                                .gamingEvent[index].image,
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
                            child: const Text(
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
                            child: const Text(
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
                                launch("tel://9426335465");
                              },
                              highlightColor: Colors.transparent,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Raise query",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: kTextColorDark),
                                  ),
                                  SizedBox(width: width * 0.01),
                                  const Icon(
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
        });
  }
}
