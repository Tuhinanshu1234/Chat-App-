import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:kumarchat_app/Screens/chat.dart';
import 'package:kumarchat_app/Screens/navscreen.dart';
import 'package:shimmer/shimmer.dart';

import 'Animation/Fadeanimation.dart';

class Myreg extends StatefulWidget {
  @override
  _MyregState createState() => _MyregState();
}

class _MyregState extends State<Myreg> {
  var x = FirebaseAuth.instance;
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color(0xff273A4F),
          title: Shimmer.fromColors(
            period: Duration(milliseconds: 1500),
            baseColor: Color(0xff82EEFD),
            highlightColor: Colors.blue,
            child: Text(
              "REGISTER",
              style: TextStyle(
                fontSize: 40.0,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ),
        body: Container(
            color: Color(0xff273A4F),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FadeAnimation(
                          1,
                          Container(
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('asset/chatgif.webp'))),
                          )),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 200,
                        width: 300,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              FadeAnimation(
                                1.5,
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white),
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    color: Colors.grey[300]))),
                                        child: TextField(
                                          onChanged: (value) {
                                            email = value;
                                          },
                                          decoration: InputDecoration(
                                              icon: Icon(
                                                Icons.person,
                                              ),
                                              border: InputBorder.none,
                                              hintStyle: TextStyle(
                                                  color: Colors.grey
                                                      .withOpacity(.8)),
                                              hintText:
                                                  "Email or Phone number"),
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(),
                                        child: TextField(
                                          obscureText: true,
                                          onChanged: (value) {
                                            password = value;
                                          },
                                          decoration: InputDecoration(
                                              icon: Icon(Icons.lock),
                                              suffixIcon:
                                                  Icon(Icons.visibility),
                                              border: InputBorder.none,
                                              hintStyle: TextStyle(
                                                  color: Colors.grey
                                                      .withOpacity(.8)),
                                              hintText: "Password"),
                                        ),
                                      ),
                                      FadeAnimation(
                                          1.6,
                                          Material(
                                            color: Colors.lightBlueAccent,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            elevation: 10,
                                            child: MaterialButton(
                                              minWidth: 200,
                                              height: 40,
                                              onPressed: () async {
                                                try {
                                                  var user = await x
                                                      .createUserWithEmailAndPassword(
                                                          email: email,
                                                          password: password);
                                                  print(email);
                                                  print(password);
                                                  print(user);

                                                  if (user.additionalUserInfo
                                                          .isNewUser ==
                                                      true) {
                                                    Navigator.push(context,
                                                        MaterialPageRoute(
                                                            builder: (context) {
                                                      return NavScreen();
                                                    }));
                                                  }
                                                } catch (e) {
                                                  print(e);
                                                }
                                              },
                                              child: Text("Submit"),
                                            ),
                                          )),
                                    ],
                                  ),
                                ),
                              )
                            ]),
                      ),
                    ]),
              ),
            )));
  }
}
