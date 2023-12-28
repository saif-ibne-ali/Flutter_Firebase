
import 'dart:async';
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
  LocationData? mytLocation;
  late StreamSubscription locationSubscription;

  @override
  void initState() {
    listenToLocation();
    super.initState();
  }

  void listenToLocation() {
    locationSubscription = location.onLocationChanged.listen((locationData) {
      mytLocation = locationData;
      if (mounted) setState(() {});
    });
  }

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
              'Static Location ${currentLocation?.latitude ?? ''} & ${currentLocation?.longitude ?? ''}'),
          Text(
              'RealTime Location ${mytLocation?.latitude ?? ''} & ${mytLocation?.longitude ?? ''}'),
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
          const Text('Has permission?'),
          ElevatedButton(
            onPressed: () async {
              PermissionStatus status = await location.hasPermission();
              if (status == PermissionStatus.denied ||
                  status == PermissionStatus.deniedForever) {
                location.requestPermission();
              }
            },
            child: const Text('Grant Permission'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    locationSubscription.cancel();
    super.dispose();
  }
}
