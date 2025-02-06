
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class PolylineScreen extends StatefulWidget {
  const PolylineScreen({super.key});

  @override
  State<PolylineScreen> createState() => _PolylineScreenState();
}

class _PolylineScreenState extends State<PolylineScreen> {

  Completer<GoogleMapController> _controller = Completer();
  CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(33.654235, 73.073000),
      zoom: 14
  );

  final Set<Marker> _markers = {};
  final Set<Polyline> _polyline = {};

  List<LatLng> latlng = [
    LatLng(33.738045, 73.084488),
    LatLng(33.567997728, 72.635997456),
    LatLng(33.689531, 72.763160),
    LatLng(34.131452, 72.662334),
    LatLng(33.647326, 72.820175),
    LatLng(33.654235, 73.073000),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for(int i = 0; i < latlng.length; i++){
      _markers.add(
        Marker(markerId: MarkerId(i.toString()),
          position: latlng[i],
          infoWindow: InfoWindow(
            title: "really cool places",
            snippet: '5 Star Rating'
          ),
          icon: BitmapDescriptor.defaultMarker
        ),
      );
      setState(() {

      });
      _polyline.add(Polyline(polylineId: PolylineId('1'),points: latlng,color: Colors.orange));
    }
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
       markers: _markers,
        polylines: _polyline,
        onMapCreated: (GoogleMapController controller){
          _controller.complete(controller);
        },
      ),
    );
  }
}
