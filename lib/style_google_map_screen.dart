import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class StyleGoogleMapScreen extends StatefulWidget {
  const StyleGoogleMapScreen({super.key});

  @override
  State<StyleGoogleMapScreen> createState() => _StyleGoogleMapScreenState();
}

class _StyleGoogleMapScreenState extends State<StyleGoogleMapScreen> {
  String mapTheme = '';
  Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition _kGooglePlex =
      CameraPosition(target: LatLng(29.3544, 71.6911), zoom: 14);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DefaultAssetBundle.of(context)
        .loadString('assets/maptheme/silver_theme.json')
        .then((value) {
      mapTheme = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.blue,
        title: Text('Maps Theme'),
        actions: [
          PopupMenuButton(
              icon: Icon(Icons.menu,color: Colors.white,size: 26),
              itemBuilder: (context) => [
                    PopupMenuItem(
                        onTap: () {
                          _controller.future.then((value) {
                            DefaultAssetBundle.of(context)
                                .loadString('assets/maptheme/silver_theme.json')
                                .then((string) {
                              value.setMapStyle(string);
                            });
                          });
                        },
                        child: Text('Sliver')),
                    PopupMenuItem(onTap: () {
                       _controller.future.then((value) {
                            DefaultAssetBundle.of(context)
                                .loadString('assets/maptheme/retro_theme.json')
                                .then((string) {
                              value.setMapStyle(string);
                            });
                          });
                    }, child: Text('Retro')),
                    PopupMenuItem(onTap: () {
                       _controller.future.then((value) {
                            DefaultAssetBundle.of(context)
                                .loadString('assets/maptheme/night_theme.json')
                                .then((string) {
                              value.setMapStyle(string);
                            });
                          });
                    }, child: Text('Night')),
                  ])
        ],
      ),
      body: SafeArea(
          child: GoogleMap(
        initialCameraPosition: _kGooglePlex,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        onMapCreated: (GoogleMapController controller) {
          controller.setMapStyle(mapTheme);
          _controller.complete(controller);
        },
      )),
    );
  }
}
