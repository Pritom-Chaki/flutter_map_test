import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Marker> _markers = [
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
    new Marker(
      width: 45.0,
      height: 45.0,
      point: LatLng(23.8123, 90.4115),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new FlutterMap(
        options: new MapOptions(
          center: LatLng(23.8103, 90.4125),
          zoom: 13,
        ),
        layers: [
          new TileLayerOptions(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c']),
          new MarkerLayerOptions(markers: _markers),
        ],
      ),
    );
  }
}
