
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
  LocationData? currentLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
              'My Location ${currentLocation?.latitude ?? ''} & ${currentLocation?.longitude ?? ''} '),
          ElevatedButton(
            autofocus: true,
            onPressed: () async {
              currentLocation = await location.getLocation();
              log(currentLocation!.altitude.toString());
              log(currentLocation!.longitude.toString());
              log(currentLocation!.latitude.toString());
              if (mounted) setState(() {});
            },
            child: const Text('Get location'),
          ),
        ],
      ),
    );
  }
}
