import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/homescreen.dart';
import 'package:flutter_application_1/service/user_service.dart';

class AuthProvider with ChangeNotifier {
  FirebaseAuth _auth = FirebaseAuth.instance;
  String smsOtp;
  String varificationId;
  String error = '';
  UserService _userService = UserService();
  Future<void> verifyPhone(BuildContext context, String number) async {
    final varificationCompleted = (PhoneAuthCredential credential) async {
      await _auth.signInWithCredential(credential);
    };
    try {
      _auth.verifyPhoneNumber(
          phoneNumber: number,
          verificationCompleted: varificationCompleted,
          verificationFailed: (FirebaseAuthException e) {
            print(e);
          },
          codeSent: (String verificationId, int resendToken) async {
            this.varificationId = verificationId;
            smsoptdialog(context, number);
            // PhoneAuthCredential credential = PhoneAuthProvider.credential(
            //     verificationId: verificationId, smsCode:);

            // await _auth.signInWithCredential(credential);
          },
          codeAutoRetrievalTimeout: (String verificationId) {
            this.varificationId = verificationId;
          });
    } catch (e) {}
  }

  Future<bool> smsoptdialog(BuildContext context, String number) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Column(
              children: [
                Text("Verifcation Code"),
                SizedBox(
                  height: 6,
                ),
                Text("Enter opt")
              ],
            ),
            content: Container(
              height: 85,
              child: TextField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                maxLength: 6,
                onChanged: (value) {
                  this.smsOtp = value;
                },
              ),
            ),
            actions: [
              FlatButton(
                  onPressed: () async {
                    try {
                      PhoneAuthCredential credential =
                          PhoneAuthProvider.credential(
                              verificationId: varificationId, smsCode: smsOtp);
                      // await _auth.signInWithCredential(credential);
                      final User user =
                          (await _auth.signInWithCredential(credential)).user;

                      _createUser(id: user.uid, number: user.phoneNumber);
                      if (user != null) {
                        Navigator.of(context).pop();
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => HomeScreen()));
                      } else {
                        print('logn in failed');
                      }
                    } catch (e) {
                      this.error = "cant do it";
                      notifyListeners();
                      print(error);
                      Navigator.of(context).pop();
                    }
                  },
                  child: Text("done"))
            ],
          );
        });
  }

  void _createUser({String id, String number}) {
    _userService.createUser({
      'id': id,
      'number': number,
    });
  }
}
