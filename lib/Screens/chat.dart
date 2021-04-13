import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kumarchat_app/Screens/navscreen.dart';
import 'package:kumarchat_app/Screens/room.dart';
import 'package:shimmer/shimmer.dart';

class MyChat extends StatefulWidget {
  @override
  _MyChatState createState() => _MyChatState();
}

class _MyChatState extends State<MyChat> {
  Stream<QuerySnapshot> chats;
  var fs = FirebaseFirestore.instance;
  final sendmsg = new TextEditingController();
  final recmsg = new TextEditingController();

  var authc = FirebaseAuth.instance;
  getChats() async {
    return await FirebaseFirestore.instance
        .collection("sender")
        .orderBy('time')
        .snapshots();
  }

  @override
  void initState() {
    getChats().then((val) {
      setState(() {
        chats = val;
      });
    });
    super.initState();
  }

  getConversationMessages(chatMessageData) async {
    return await FirebaseFirestore.instance
        .collection("sender")
        .add(chatMessageData)
        .catchError((e) {
      print(e.toString());
    });
  }

  addsendMessage() {
    if (sendmsg.text.isNotEmpty) {
      Map<String, dynamic> chatMessageData = {
        "sender": sendmsg.text,
        'time': DateTime.now().millisecondsSinceEpoch,
      };
      getConversationMessages(chatMessageData);
      setState(() {
        sendmsg.text = "";
      });
    }
  }

  getRecConversationMessages(recMessageData) async {
    return await FirebaseFirestore.instance
        .collection("reciever")
        .add(recMessageData)
        .catchError((e) {
      print(e.toString());
    });
  }

  addrecMessage() {
    if (recmsg.text.isNotEmpty) {
      Map<String, dynamic> recMessageData = {
        "reciever": recmsg.text,
        'time': DateTime.now().millisecondsSinceEpoch,
      };
      getRecConversationMessages(recMessageData);
      setState(() {
        recmsg.text = "";
      });
    }
  }

  Widget chatMessages() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("sender")
          .orderBy('time', descending: false)
          .snapshots(),
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  return Message2Tile(
                    message: snapshot.data.docs[index].data()["sender"],
                  );
                })
            : Container();
      },
    );
  }

  Widget rcvMessages() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("reciever")
          .orderBy('time', descending: false)
          .snapshots(),
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  return MessageTile(
                    message: snapshot.data.docs[index].data()["reciever"],
                  );
                })
            : Container();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff273A4F),
          centerTitle: true,
          title: Shimmer.fromColors(
            period: Duration(milliseconds: 1500),
            baseColor: Color(0xff82EEFD),
            highlightColor: Colors.blue,
            child: Text(
              "CHAT",
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
                    return NavScreen();
                  }));
                },
              );
            },
          ),
        ),
        body: Container(
          color: Color(0xff273A4F),
          child: Stack(
            children: <Widget>[
              Container(width: deviceWidth, child: chatMessages()),
              Container(width: deviceWidth, child: rcvMessages()),
              Container(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      color: Color(0x54FFFFFF),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: sendmsg,
                              style: TextStyle(
                                color: Colors.tealAccent,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                              decoration: InputDecoration(
                                  hintText: "Sender ...",
                                  hintStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  border: InputBorder.none),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              addsendMessage();
                              sendmsg.clear();
                            },
                            child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        colors: [
                                          const Color(0x36FFFFFF),
                                          const Color(0x0FFFFFFF)
                                        ],
                                        begin: FractionalOffset.topLeft,
                                        end: FractionalOffset.bottomRight),
                                    borderRadius: BorderRadius.circular(40)),
                                padding: EdgeInsets.all(12),
                                child: Image.asset(
                                  "asset/send4.png",
                                  height: 25,
                                  width: 25,
                                  fit: BoxFit.fill,
                                )),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              child: Divider(
                                color: Colors.blue,
                                thickness: 2,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      color: Color(0x54FFFFFF),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: recmsg,
                              style: TextStyle(
                                color: Colors.amber,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                              decoration: InputDecoration(
                                  hintText: "Reciever ...",
                                  hintStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  border: InputBorder.none),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              addrecMessage();
                              recmsg.clear();
                            },
                            child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        colors: [
                                          const Color(0x36FFFFFF),
                                          const Color(0x0FFFFFFF)
                                        ],
                                        begin: FractionalOffset.topLeft,
                                        end: FractionalOffset.bottomRight),
                                    borderRadius: BorderRadius.circular(40)),
                                padding: EdgeInsets.all(12),
                                child: Image.asset(
                                  "asset/send4.png",
                                  height: 25,
                                  width: 25,
                                )),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MessageTile extends StatelessWidget {
  final String message;

  MessageTile({@required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 8, bottom: 8, left: 0, right: 24),
      alignment: Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.only(left: 30),
        padding: EdgeInsets.only(top: 17, bottom: 17, left: 20, right: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(23),
                topRight: Radius.circular(23),
                bottomLeft: Radius.circular(23)),
            gradient: LinearGradient(
              colors: [const Color(0x1AFFFFFF), const Color(0x1AFFFFFF)],
            )),
        child: Text(message,
            textAlign: TextAlign.start,
            style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'OverpassRegular',
                fontWeight: FontWeight.w300)),
      ),
    );
  }
}

class Message2Tile extends StatelessWidget {
  final String message;

  Message2Tile({@required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 8, bottom: 8, left: 24, right: 0),
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(right: 30),
        padding: EdgeInsets.only(top: 17, bottom: 17, left: 20, right: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(23),
                topRight: Radius.circular(23),
                bottomRight: Radius.circular(23)),
            gradient: LinearGradient(
              colors: [const Color(0xff007EF4), const Color(0xff2A75BC)],
            )),
        child: Text(message,
            textAlign: TextAlign.start,
            style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'OverpassRegular',
                fontWeight: FontWeight.w300)),
      ),
    );
  }
}
