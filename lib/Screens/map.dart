import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shimmer/shimmer.dart';

class Map extends StatefulWidget {
  @override
  _MapState createState() => _MapState();
}

lw() async {
  var p = await Geolocator()
      .getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
  print(p);
}

var lat = 20.251636;
var lang = 85.788249;

class _MapState extends State<Map> {
  Completer<GoogleMapController> _controller = Completer();
  static const LatLng _center = const LatLng(22.078862, 78.839943);

  LatLng _lastMapPosition = _center;

  static final CameraPosition _position1 = CameraPosition(
    bearing: 192.833,
    target: LatLng(20.251636, 85.788249),
    tilt: 50,
    zoom: 11.0,
  );
  _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  Future<void> _goToPosition1() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_position1));
  }

  Widget button(Function function, IconData icon) {
    return FloatingActionButton(
      onPressed: function,
      materialTapTargetSize: MaterialTapTargetSize.padded,
      backgroundColor: Colors.blue,
      child: Icon(
        icon,
        size: 36.0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var cp = CameraPosition(
      target: _center,
      zoom: 10,
      tilt: 50,
    );
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color(0xff273A4F),
          title: Shimmer.fromColors(
            period: Duration(milliseconds: 1500),
            baseColor: Color(0xff82EEFD),
            highlightColor: Colors.blue,
            child: Text(
              "GOOGLE_MAP",
              style: TextStyle(
                fontSize: 40.0,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ),
        body: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: cp,
              mapType: MapType.hybrid,
              zoomControlsEnabled: true,
              onMapCreated: _onMapCreated,
              onCameraMove: _onCameraMove,
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.topRight,
                child: Column(
                  children: <Widget>[
                    button(_goToPosition1, Icons.location_searching),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
