import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
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
          height: height/4,
          width: width,
          child: Swiper(
            itemBuilder: (BuildContext context, int index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  "https://www.hellokpop.com/wp-content/uploads/2018/09/asf_5.png",
                  fit: BoxFit.fill,
                ),
              );
            },
            loop: true,
            autoplay: true,
            itemWidth: width*0.9,
            layout: SwiperLayout.STACK,
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
