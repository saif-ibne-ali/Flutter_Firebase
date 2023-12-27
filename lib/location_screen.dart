
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  Location location = Location();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location'),
      ),
      body: Column(
        children: [
          const Text('My Location'),
          ElevatedButton(
            onPressed: () async{
             final LocationData currentLocation = await location.getLocation();
             log(currentLocation.altitude.toString());
             log(currentLocation.longitude.toString());
             log(currentLocation.latitude.toString());
            },
            child: const Text('Get location'),
          ),
        ],
      ),
    );
  }
}
