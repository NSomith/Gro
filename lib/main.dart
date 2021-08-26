import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/provider/auth_provider.dart';
import 'package:flutter_application_1/provider/location_provider.dart';
import 'package:flutter_application_1/screens/homescreen.dart';
import 'package:flutter_application_1/screens/map_screen.dart';
import 'package:flutter_application_1/screens/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (_) => AuthProvider(),
    ),
     ChangeNotifierProvider(
      create: (_) => LocationProvider(),
    )
  ],child: MyApp(),));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.deepOrangeAccent),
      initialRoute: SplashScreen.id,
      routes: {
        SplashScreen.id:(context)=>SplashScreen(),
        HomeScreen.id:(context)=>HomeScreen(),
        WelcomeScreen.id:(context)=>WelcomeScreen(),
        MapScreen.id:(context)=>MapScreen()
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  static const String id = 'splash-screen';
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(
        Duration(
          seconds: 3,
        ), () {
      FirebaseAuth.instance.authStateChanges().listen((User user) {
        if (user == null) {
         Navigator.pushReplacementNamed(context, WelcomeScreen.id);
        }else{
           Navigator.pushReplacementNamed(context, HomeScreen.id);
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Hero(tag: 'logo', child: Image.asset('images/logo.png')),
      ),
    );
  }
}
