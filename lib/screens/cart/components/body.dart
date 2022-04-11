import 'package:flutter/material.dart';
import 'package:fms_ditu/constants.dart';
import 'package:line_icons/line_icons.dart';

class CartBody extends StatefulWidget {
  const CartBody({Key? key}) : super(key: key);

  @override
  State<CartBody> createState() => _CartBodyState();
}

class _CartBodyState extends State<CartBody> {
  var height, width;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        SizedBox(
          height: height * 0.01,
        ),
        Expanded(
            child: ListView.builder(
                itemCount: 4, //list view declaration
                padding: EdgeInsets.only(top: 10.0, bottom: 15.0),
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 5, right: 5),
                        child: Container(
                          width: width,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                blurRadius: 5.0,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: 10, bottom: 10, left: 15, right: 20),
                            child: Column(
                              children: [
                                Column(
                                  children: [
                                    Center(
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                              width: height * 0.12,
                                              height: height * 0.15,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                child: Image.network(
                                                  "https://i.pinimg.com/736x/89/48/46/89484620b6843259ed3ee0705b3e80de.jpg",
                                                  fit: BoxFit.cover,
                                                ),
                                              )),

                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          child: Text(
                                                            "Robo Soccer",
                                                            style: TextStyle(
                                                                color:
                                                                    kTextColorDark,
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                        ),
                                                        Container(
                                                          width: width * 0.4,
                                                          child: Text(
                                                            "RoboSoccer, Sherlocked, Hackathon, CODEGEMS 2.0 + Blind Code",
                                                            style: TextStyle(
                                                                color:
                                                                    kTextColorLight,
                                                                fontSize: 11,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(width: width*0.07,),
                                                    ClipOval(
                                                      child: Material(
                                                        color:
                                                            kContainerColorPrimary, // Button color
                                                        child: InkWell(
                                                          splashColor:
                                                              kButtonColorSecondary, // Splash color
                                                          onTap: () {},
                                                          child: SizedBox(
                                                              width:
                                                                  width * 0.11,
                                                              height:
                                                                  width * 0.11,
                                                              child: Icon(
                                                                  LineIcons
                                                                      .trash)),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Divider(),
                                                Row(
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Icon(
                                                              LineIcons.clock,
                                                              color:
                                                                  kTextColorLight,
                                                              size: 18,
                                                            ),
                                                            SizedBox(
                                                              width: 5,
                                                            ),
                                                            Text(
                                                              "8:00 PM",
                                                              style: TextStyle(
                                                                  color:
                                                                      kTextColorLight,
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Icon(
                                                              LineIcons
                                                                  .calendar,
                                                              color:
                                                                  kTextColorLight,
                                                              size: 18,
                                                            ),
                                                            SizedBox(
                                                              width: 5,
                                                            ),
                                                            Text(
                                                              "22nd April",
                                                              style: TextStyle(
                                                                  color:
                                                                      kTextColorLight,
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                        width: width * 0.17),
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        color:
                                                            kButtonColorSecondary,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 14,
                                                                right: 14,
                                                                top: 8,
                                                                bottom: 8),
                                                        child: Text(
                                                          "₹500",
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),

                                                // SizedBox(height: 4,),
                                              ],
                                            ),
                                          ),
                                          // SizedBox(width: width*0.06),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.015,
                      ),
                    ],
                  );
                })),
        Container(
          width: width,
          margin: EdgeInsets.only(left: width*0.15, right: width*0.15, bottom: 10, top: 10),
          decoration: BoxDecoration(
              color: kButtonColorPrimary,
              borderRadius: BorderRadius.circular(30)),
          child: Padding(
            padding: const EdgeInsets.only(top: 12,bottom: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Pay ₹500 with",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
                SizedBox(
                  width: 7,
                ),
                Image.asset("assets/images/gpay.png",height: height * 0.025,color: Colors.white,)
              ],
            ),
          ),
        )
      ],
    );
  }
}
