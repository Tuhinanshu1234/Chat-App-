import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:kumarchat_app/Screens/navscreen.dart';
import 'package:kumarchat_app/Screens/signup.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shimmer/shimmer.dart';

import 'Animation/Fadeanimation.dart';

class Mylog extends StatefulWidget {
  @override
  _MylogState createState() => _MylogState();
}

class _MylogState extends State<Mylog> {
  var x = FirebaseAuth.instance;
  String email;
  String password;
  bool sspin = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff273A4F),
          centerTitle: true,
          title: Shimmer.fromColors(
            period: Duration(milliseconds: 1500),
            baseColor: Color(0xff82EEFD),
            highlightColor: Colors.blue,
            child: Text(
              "LOGIN",
              style: TextStyle(
                fontSize: 40.0,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ),
        body: Container(
          color: Color(0xff273A4F),
          child: ModalProgressHUD(
            inAsyncCall: sspin,
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    FadeAnimation(
                        1,
                        Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: AssetImage('asset/chatgif.webp'))),
                        )),
                    FadeAnimation(
                        1.2,
                        Container(
                            height: 200,
                            width: 300,
                            child: FadeAnimation(
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
                                            hintText: "Email or Phone number"),
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
                                            suffixIcon: Icon(Icons.visibility),
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
                                              child: Text("Login"),
                                              onPressed: () async {
                                                setState(() {
                                                  sspin = true;
                                                });

                                                try {
                                                  var user = await x
                                                      .signInWithEmailAndPassword(
                                                          email: email,
                                                          password: password);
                                                  print(user);
                                                  if (user != null) {
                                                    Navigator.push(
                                                        context,
                                                        PageTransition(
                                                            child: NavScreen(),
                                                            type:
                                                                PageTransitionType
                                                                    .fade));
                                                    setState(() {
                                                      sspin = false;
                                                    });
                                                  }
                                                } catch (e) {
                                                  print(e);
                                                }
                                              }),
                                        )),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    FadeAnimation(
                                        1.8,
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              'Not Registerd ?',
                                              style: TextStyle(
                                                  fontFamily: 'Montserrat'),
                                            ),
                                            SizedBox(
                                              width: 5.0,
                                            ),
                                            InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    PageTransition(
                                                        child: Myreg(),
                                                        type: PageTransitionType
                                                            .fade));
                                              },
                                              child: Text(
                                                'Register',
                                                style: TextStyle(
                                                  color: Colors.blue,
                                                  fontFamily: 'Montserrat',
                                                  fontWeight: FontWeight.bold,
                                                  decoration:
                                                      TextDecoration.underline,
                                                ),
                                              ),
                                            )
                                          ],
                                        )),
                                  ],
                                ),
                              ),
                            )))
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
/*FadeAnimation(
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
                                bottom: BorderSide(color: Colors.grey[300]))),
                        child: TextField(
                          onChanged: (value) {
                            email = value;
                          },
                          decoration: InputDecoration(
                              icon: Icon(
                                Icons.person,
                              ),
                              border: InputBorder.none,
                              hintStyle:
                                  TextStyle(color: Colors.grey.withOpacity(.8)),
                              hintText: "Email or Phone number"),
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
                              suffixIcon: Icon(Icons.visibility),
                              border: InputBorder.none,
                              hintStyle:
                                  TextStyle(color: Colors.grey.withOpacity(.8)),
                              hintText: "Password"),
                        ),
                      ),*/
