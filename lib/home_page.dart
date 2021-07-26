import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import 'direction_model.dart';
import 'direction_repository.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  MapController _mapController = MapController();
  DirectionsModel? direction;

  //marker list
  List<Marker> _markers = [
    //marker 1
    new Marker(
      width: 45.0,
      height: 45.0,
      point: LatLng(23.8103, 90.4125),
      builder: (ctx) => Container(
          child: IconButton(
        icon: Icon(
          Icons.location_on,
        ),
        color: Colors.red,
        onPressed: () {
          print('Red Tap');
        },
      )),
    ),
    //marker 2
    new Marker(
      width: 45.0,
      height: 45.0,
      point: LatLng(23.8523, 90.4215),
      builder: (ctx) => Container(
          child: IconButton(
        icon: Icon(
          Icons.location_on,
        ),
        color: Colors.blue,
        onPressed: () {
          print('Blue Tap');
        },
      )),
    ),
  ];

//testing value
  var _points = <LatLng>[
    LatLng(23.8103, 90.4125),
    LatLng(23.8113, 90.4125),
    LatLng(23.8123, 90.4115),
  ];

//polyline points
  List<LatLng> _pointC = [];

  @override
  void initState() {
    getDirection();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  getDirection() async {
//get direction
    final directions = await DirectionsRepository().getDirections(
      userLatLng: LatLng(23.8103, 90.4125),
      businessLatLng: LatLng(23.8523, 90.4215),
    );
    setState(() {
      print("directions poly = ${directions!.polylinePoints}");
      //direction = directions;
      _pointC = directions.polylinePoints!
          .map((e) => LatLng(e.latitude, e.longitude))
          .toList();

      print('PointC : $_pointC');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new FlutterMap(
        mapController: _mapController,
        options: new MapOptions(
          center: LatLng(23.8103, 90.4125),
          zoom: 13,
        ),
        layers: [
          new TileLayerOptions(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c']),
          new PolylineLayerOptions(polylines: [
            Polyline(points: _pointC, color: Colors.red, strokeWidth: 2.5)
          ]),
          new MarkerLayerOptions(markers: _markers),
        ],
      ),
    );
  }
}
