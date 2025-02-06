import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class GetUsercurrentLocation extends StatefulWidget {
  const GetUsercurrentLocation({super.key});

  @override
  State<GetUsercurrentLocation> createState() => _GetUsercurrentLocationState();
}

class _GetUsercurrentLocationState extends State<GetUsercurrentLocation> {
  
  final Completer<GoogleMapController> _controller = Completer();
  static const CameraPosition _KGooglePlex = CameraPosition(
      target: LatLng(29.3544, 71.6911),
    zoom: 14
  );


  final List<Marker> _marker = <Marker>[
  Marker(
      markerId: MarkerId('1'),
      position: LatLng(31.5204, 74.3587),
      infoWindow: InfoWindow(
          title: "My postion Lahore"
      )
  )
];
  

  loadData()async{
    getUserCurrentLocation().then((value)async{
      print("My current location");
      print(value.latitude.toString() + " " + value.longitude.toString());
      _marker.add(Marker(markerId: MarkerId('2'),position: LatLng(value.latitude, value.longitude),
          infoWindow: InfoWindow(title: " User My current location")
      ));
      CameraPosition cameraPosition = CameraPosition(
          zoom: 14,
          target: LatLng(value.latitude, value.longitude)
      );
      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      setState(() {

      });
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }



  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission().then((value){
      
    }).onError((error,stackTrace){
      print("Error => "+error.toString());
    });
    return await Geolocator.getCurrentPosition();
  }
  
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
          initialCameraPosition: _KGooglePlex,
        markers: Set<Marker>.of(_marker),
        onMapCreated: (GoogleMapController controller){
            _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            getUserCurrentLocation().then((value)async{
              print("My current location");
              print(value.latitude.toString() + " " + value.longitude.toString());
              _marker.add(Marker(markerId: MarkerId('2'),position: LatLng(value.latitude, value.longitude),
              infoWindow: InfoWindow(title: " User My current location")
              ));
              CameraPosition cameraPosition = CameraPosition(
                zoom: 14,
                  target: LatLng(value.latitude, value.longitude)
              );
              final GoogleMapController controller = await _controller.future;
              controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
              setState(() {

              });
            });
          },
        child: Icon(Icons.local_activity),
      ),
    );
  }
}
