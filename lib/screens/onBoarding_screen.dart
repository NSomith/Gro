import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';

import '../constants.dart';


class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreen createState() => _OnBoardingScreen();
}

final _controller = PageController(
  initialPage: 0,
);

int _currpage = 0;

List<Widget> _pages = [
  Column(
    children: [
      Expanded(child: Image.asset("images/enteraddress.png")),
      Text("Set Your Delivery Location",style: kPageViewTextStyle,textAlign: TextAlign.left,)
    ],
  ),
  Column(
    children: [
      Expanded(child: Image.asset("images/orderfood.png")),
      Text("Order online from your favourite store",style: kPageViewTextStyle,textAlign: TextAlign.left)
    ],
  ),
  Column(
    children: [
      Expanded(child: Image.asset("images/deliverfood.png")),
      Text("Quick deliver to your doorsteps",style: kPageViewTextStyle,textAlign: TextAlign.left)
    ],
  )
];

class _OnBoardingScreen extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Expanded(
          child: PageView(
            controller: _controller,
            children: _pages,
            onPageChanged: (index) {
              setState(() {
                _currpage = index;
              });
            },
          ),
        ),
        SizedBox(height: 20,),
        DotsIndicator(
          dotsCount: _pages.length,
          position: _currpage.toDouble(),
          decorator: DotsDecorator(
            size: const Size.square(9.0),
            activeColor: Colors.blueAccent,
            activeSize: const Size(18.0, 9.0),
            activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          ),
        ),
        SizedBox(height: 20,),
      ]),
    );
  }
}
