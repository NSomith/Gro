import 'package:flutter/material.dart';

import 'onBoarding_screen.dart';

class WelcomeScreen extends StatelessWidget {
  bool _validPhoneno = false;
  void showBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (context) =>
            StatefulBuilder(builder: (context, StateSetter myState) {
              return Container(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Login",
                        style:
                        TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Enter your phone number ",
                        style: TextStyle(fontSize: 12),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      TextField(
                        decoration: InputDecoration(
                            prefix: Text("+91"), labelText: "10 digits number"),
                        autofocus: true,
                        keyboardType: TextInputType.phone,
                        maxLength: 10,
                        onChanged: (value){
                          if(value.length == 10){
                            myState((){
                              _validPhoneno = true;
                            });
                          }else{
                            myState((){
                              _validPhoneno = false;
                            });
                          }
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(children: [
                        Expanded(
                          child: AbsorbPointer(
                            absorbing:_validPhoneno?false:true,
                            child: FlatButton(
                                color: _validPhoneno?Theme.of(context).primaryColor:Colors.grey,
                                onPressed: () {},
                                child: Text(
                                  _validPhoneno?"Continue":
                                  "Enter Phone number",
                                  style: TextStyle(color: Colors.white),
                                )),
                          ),
                        ),
                      ])
                    ],
                  ),
                ),
              );
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: EdgeInsets.all(20.0),
          child: Stack(
            children: [
              Positioned(
                right: 0.0,
                top: 10.0,
                child: FlatButton(
                  child: Text(
                    "SKIP",
                    style: TextStyle(color: Colors.blue),
                  ),
                  onPressed: () {},
                ),
              ),
              Column(
                children: [
                  Expanded(child: OnBoardingScreen()),
                  Text(
                    "Ready to order from your nearest shop?",
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  FlatButton(
                    onPressed: () {},
                    child: Text(
                      "Set Delivery Location",
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.deepOrangeAccent,
                  ),
                  FlatButton(
                    onPressed: () {
                      showBottomSheet(context);
                    },
                    child: RichText(
                        text: TextSpan(
                            text: "Already a customer?",
                            style: TextStyle(color: Colors.blue),
                            children: [
                          TextSpan(
                              text: "Login",
                              style: TextStyle(fontWeight: FontWeight.bold))
                        ])),
                  )
                ],
              ),
            ],
          )),
    );
  }
}