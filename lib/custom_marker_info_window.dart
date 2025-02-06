
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class CustomMarkerInfoWindow extends StatefulWidget {
  const CustomMarkerInfoWindow({super.key});

  @override
  State<CustomMarkerInfoWindow> createState() => _CustomMarkerInfoWindowState();
}

class _CustomMarkerInfoWindowState extends State<CustomMarkerInfoWindow> {

  CustomInfoWindowController _customInfoWindowController = CustomInfoWindowController();

  final List<Marker> _markers = <Marker>[];
  final List<LatLng> _latLang = [
    LatLng(33.6941, 72.9734),
    LatLng(33.7008, 72.9684),
    LatLng(33.6992, 72.9744),
    LatLng(33.6939, 72.9771),
    LatLng(33.6910, 72.9887),
    LatLng(33.7036, 72.9785),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  loadData(){
    for(int i = 0; i < _latLang.length; i++){
      _markers.add(
        Marker(markerId: MarkerId(i.toString()),
          icon: BitmapDescriptor.defaultMarker,
          position: _latLang[i],
          onTap: (){
          _customInfoWindowController.addInfoWindow!(
            Container(
              height: 300,
              width: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10.0)
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                Container(
                height: 100,
                  width: 300,
                  decoration: BoxDecoration(
                    color: Colors.green
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10,left: 10,right: 10),
                    child: Row(
                      children: [
                        SizedBox(width: 100,
                          child: Text('Saqib',maxLines: 1,overflow: TextOverflow.fade,softWrap: false),
                        ),
                        const Spacer(),
                        Text('3 mi.')
                      ],
                    ),
                  )
                ],
              ),
            ),
            _latLang[i]
          );
          }
        ),
      );
      setState(() {

      });
    }
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        centerTitle: true,
        title: Text('Custom Info Window Example'),
      ),
      body: Stack(
        children: [
          GoogleMap(
              initialCameraPosition: CameraPosition(
                  target: LatLng(33.6941, 72.9734),
                zoom: 14
              ),
            markers: Set<Marker>.of(_markers),
            onTap: (position){
                _customInfoWindowController.hideInfoWindow!();
            },
            onMapCreated: (GoogleMapController controller){
                _customInfoWindowController.googleMapController = controller;
            },
            onCameraMove: (position){
                _customInfoWindowController.onCameraMove!();
            },
          ),
          CustomInfoWindow(
              controller: _customInfoWindowController,
            height: 100,
            width: 300,
            offset: 35,
          )
        ],
      ),
    );
  }
}
