import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import './BottomNavigationBar.dart';

class body extends StatefulWidget {
  const body({Key? key}) : super(key: key);

  @override
  State<body> createState() => _bodyState();
}

class _bodyState extends State<body> {
  var height , width;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Column(
      children:  [
        SizedBox(height: height*0.025),

        Container(
          height: height/3.5,
          width: width,
          child: Swiper(
            itemBuilder: (BuildContext context, int index) {
              return Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      "https://www.hellokpop.com/wp-content/uploads/2018/09/asf_5.png",
                      fit: BoxFit.fill,
                    ),
                  ),

                  Column(
                    children: [
                      RawMaterialButton(
                        onPressed: () {
                          print("object");
                        },
                        elevation: 2.0,
                        fillColor: Colors.white,
                        child: Icon(LineIcons.desktop),
                        padding: EdgeInsets.all(5.0),
                        shape: CircleBorder(),
                      ),
                      ClipOval(
                        child: Material(
                          color: Colors.blue, // Button color
                          child: InkWell(
                            splashColor: Colors.red, // Splash color
                            onTap: () {},
                            child: SizedBox(width: 56, height: 56, child: Icon(Icons.menu)),
                          ),
                        ),
                      ),
                      RawMaterialButton(
                        onPressed: () {
                          print("object");
                        },
                        elevation: 2.0,
                        fillColor: Colors.white,
                        child: Icon(LineIcons.desktop),
                        padding: EdgeInsets.all(5.0),
                        shape: CircleBorder(),
                      ),
                    ],
                  ),
                ],
              );
            },
            loop: true,
            autoplay: true,
            itemHeight: height/4,
            itemWidth: width,
            layout: SwiperLayout.DEFAULT,
            itemCount: 10,
            viewportFraction: 0.8,
            scale: 0.9,
          ),
        ),
        SizedBox(height: height*0.03),
        Center(
            child: Text("Dashboard Screen")
        ),


      ],
    );
  }
}
