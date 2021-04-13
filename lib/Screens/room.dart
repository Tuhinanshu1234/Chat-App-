import 'package:flutter/material.dart';
import 'package:kumarchat_app/Screens/chat.dart';
import 'package:kumarchat_app/Screens/login.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shimmer/shimmer.dart';

class Room extends StatefulWidget {
  @override
  _RoomState createState() => _RoomState();
}

class _RoomState extends State<Room> {
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
            "WELCOME",
            style: TextStyle(
              fontSize: 40.0,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Mylog();
                }));
              },
            );
          },
        ),
      ),
      body: Container(
        color: Color(0xff273A4F),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                children: [
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Tuhinanshu Panda",
                        style: TextStyle(
                            fontSize: 18,
                            fontStyle: FontStyle.normal,
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: 0.5,
                      ),
                      Text(
                        "tuhin271199@gmail.com",
                        style: TextStyle(
                            fontSize: 18,
                            fontStyle: FontStyle.normal,
                            color: Colors.white),
                      ),
                    ],
                  )),
                  Material(
                    color: Colors.lightBlueAccent,
                    borderRadius: BorderRadius.circular(10),
                    elevation: 10,
                    child: MaterialButton(
                        minWidth: 100,
                        height: 40,
                        child: Text("Click"),
                        onPressed: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  child: MyChat(),
                                  type:
                                      PageTransitionType.rightToLeftWithFade));
                        }),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
