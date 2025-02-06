
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
class ConvertLatiangLonguite extends StatefulWidget {
  const ConvertLatiangLonguite({super.key});

  @override
  State<ConvertLatiangLonguite> createState() => _ConvertLatiangLonguiteState();
}

class _ConvertLatiangLonguiteState extends State<ConvertLatiangLonguite> {

  String stAddress = '', stAdd = '';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Google Map"),
      ),
      body: Column(
        spacing: 10,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(stAddress,style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold)),
          Text(stAdd,style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold)),
          GestureDetector(
            onTap: ()async{
              List<Location> locations = await locationFromAddress("Bahawalpur");
              List<Placemark> placemarks = await placemarkFromCoordinates(29.3544, 71.6911);
              setState(() {
                stAddress = locations.last.longitude.toString() + " " + locations.last.latitude.toString();
                stAdd = placemarks.reversed.last.locality.toString() + " " + placemarks.reversed.last.subAdministrativeArea.toString();
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50,
                decoration: BoxDecoration(color: Colors.green),
                child: Center(child: Text('Convert')),
              ),
            ),
          )
        ],
      ),
    );
  }
}
