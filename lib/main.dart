import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/welcome_screen.dart';


void main() {
  runApp(MyApp());
}

class MyApp  extends StatelessWidget {
  @override
  Widget build(BuildContext context){
      return MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.deepOrangeAccent
        ),
        home: SplashScreen(),
      );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(
      Duration(
        seconds: 3,
      ),(){
        Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => WelcomeScreen(),
        ));
    }
    );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Hero(
              tag: 'logo',
              child: Image.asset('images/logo.png')),
        ),
    );
  }
}

