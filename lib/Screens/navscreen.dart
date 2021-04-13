import 'package:flutter/material.dart';
import 'package:kumarchat_app/Screens/map.dart';
import 'package:kumarchat_app/Screens/room.dart';
import 'package:kumarchat_app/Screens/user.dart';

class NavScreen extends StatefulWidget {
  @override
  _NavScreenState createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  final List _screens = [Room(), Map(), EditProfilePage()];
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color(0xff273A4F),
        showSelectedLabels: true,
        showUnselectedLabels: false,
        selectedItemColor: Colors.tealAccent,
        unselectedItemColor: Colors.white,
        elevation: 5.0,
        items: [Icons.chat, Icons.location_on, Icons.person_outline]
            .asMap()
            .map((key, value) => MapEntry(
                  key,
                  BottomNavigationBarItem(
                    title: Text(''),
                    icon: Container(
                        padding: EdgeInsets.only(
                            left: 16, right: 16, top: 8, bottom: 8),
                        child: Icon(value)),
                  ),
                ))
            .values
            .toList(),
      ),
    );
  }
}
