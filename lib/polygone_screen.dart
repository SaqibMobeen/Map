
import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class PolygoneScreen extends StatefulWidget {
  const PolygoneScreen({super.key});

  @override
  State<PolygoneScreen> createState() => _PolygoneScreenState();
}

class _PolygoneScreenState extends State<PolygoneScreen> {


  Completer<GoogleMapController> _controller = Completer();
  CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(33.654235, 73.073000),
      zoom: 14
  );

  final Set<Marker> _markers = {};
  Set<Polygon> _polygon = HashSet<Polygon>();

  List<LatLng> points = [
    LatLng(33.654235, 73.073000),
    LatLng(33.647326, 72.820175),
    LatLng(33.689531, 72.763160),
    LatLng(34.131452, 72.662334),
    LatLng(33.647326, 72.820175),
    LatLng(33.654235, 73.073000),
  ];




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _polygon.add(Polygon(polygonId: PolygonId('1'),
      points: points,
      fillColor: Colors.red,
      geodesic: true,
      strokeColor: Colors.deepOrange,
      strokeWidth: 4
    ));

  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Polygone'),
      ),
      body: GoogleMap(
        mapType: MapType.normal,
          initialCameraPosition: _kGooglePlex,
        myLocationEnabled: false,
        myLocationButtonEnabled: true,
        polygons: _polygon,
        onMapCreated: (GoogleMapController controller){
          _controller.complete(controller);
        },
      ),
    );
  }
}
