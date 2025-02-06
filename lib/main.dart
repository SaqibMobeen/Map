import 'package:flutter/material.dart';
import 'package:map/convert_latiang_longuite.dart';
import 'package:map/custom_marker_info_window.dart';
import 'package:map/custom_network_image_maker.dart';
import 'package:map/get_userCurrent_Location.dart';
import 'package:map/google_map_screen.dart';
import 'package:map/google_places_api.dart';
import 'package:map/polygone_screen.dart';
import 'package:map/polyline.dart';
import 'package:map/style_google_map_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: CustomNetworkImageMakerSecreen(),
    );
  }
}


