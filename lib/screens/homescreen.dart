import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/provider/auth_provider.dart';
import 'package:flutter_application_1/screens/welcome_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  static const String id = 'home-screen';
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    return Scaffold(
        body: RaisedButton(
            onPressed: () {
              FirebaseAuth.instance.signOut().then((value) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => WelcomeScreen()));
              });
            },
            child: Text("Sing in ")));
  }
}
