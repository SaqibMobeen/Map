

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class GoogleMapScreen extends StatefulWidget {
  const GoogleMapScreen({super.key});

  @override
  State<GoogleMapScreen> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {


  Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(29.3544, 71.6911),
    zoom: 14
  );
   LatLng myCurrentLocation = LatLng(29.3544, 71.6911);
   LatLng myCurrentlocationHome =  LatLng(29.3544, 71.6911);
   BitmapDescriptor customIcon = BitmapDescriptor.defaultMarker;

   List<Marker> _marker = [];
   final List<Marker> _list = const [
     Marker(
         markerId: MarkerId('1'),
       position: LatLng(29.4565, 71.6911),
         infoWindow: InfoWindow(
             title: "My postion Bahawalpur"
         )
     ),
     Marker(
         markerId: MarkerId('2'),
         position: LatLng(29.4133, 71.8460),
       infoWindow: InfoWindow(
         title: "My postion Home"
       )
     ),
     Marker(
         markerId: MarkerId('3'),
         position: LatLng(29.4565, 71.9194),
         infoWindow: InfoWindow(
             title: "My postion home"
         )
     ),

   ];

   @override
  void initState() {
     // customMarker();
    // TODO: implement initState
    super.initState();
    _marker.addAll(_list);
  }

   // void customMarker() {
   //   BitmapDescriptor.asset(
   //       const ImageConfiguration(),
   //       "assets/images/marker.png",
   //   ).then((icon){
   //     setState(() {
   //       customIcon = icon;
   //     });
   //   });
   // }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
          initialCameraPosition: _kGooglePlex,
        markers: Set<Marker>.of(_marker),
        onMapCreated: (GoogleMapController controller){
            _controller.complete(controller);
        },
          ),
        // markers: {
        //     Marker(
        //       markerId: MarkerId('Mrker Id'),
        //       position: myCurrentLocation,
        //       draggable: true,
        //       onDrag: (value){},
        //       infoWindow: InfoWindow(
        //         title: "Title of the makre",
        //         snippet: "more info about marker"
        //       )
        //     )
        // },
      // ),



    );
  }
}
