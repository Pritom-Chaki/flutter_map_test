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
        iconSize: 30,
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
        iconSize: 30,
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

  Widget _buildZoomControll() {
    return Container(
      margin: EdgeInsets.only(right: 20, bottom: 50),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        color: Colors.white,
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              var newZoom = _mapController.zoom + 1;
              _mapController.move(_mapController.center, newZoom);
            },
            child: Container(
              padding: EdgeInsets.all(3.0),
              child: Icon(
                Icons.zoom_in_rounded,
                size: 30,
                color: Colors.black,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 4.0),
            height: 1.0,
            width: 30,
            color: Colors.black54,
          ),
          InkWell(
            onTap: () {
              var newZoom = _mapController.zoom - 1;
              _mapController.move(_mapController.center, newZoom);
            },
            child: Container(
              padding: EdgeInsets.all(3.0),
              child: Icon(
                Icons.zoom_out_rounded,
                size: 30,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.zoom_out_map),
      //   onPressed: () {
      //     var newZoom = _mapController.zoom + 1;
      //     _mapController.move(_mapController.center, newZoom);
      //   },
      // ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: new MapOptions(
              center: LatLng(23.8103, 90.4125),
              zoom: 13,
            ),
            layers: [
              new TileLayerOptions(
                  urlTemplate:
                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: ['a', 'b', 'c']),
              new PolylineLayerOptions(polylines: [
                Polyline(points: _pointC, color: Colors.red, strokeWidth: 2.5)
              ]),
              new MarkerLayerOptions(markers: _markers),
            ],
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: _buildZoomControll(),
          ),
        ],
      ),
    );
  }
}
