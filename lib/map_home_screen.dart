import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapHomeScreen extends StatefulWidget {
  const MapHomeScreen({super.key});

  @override
  State<MapHomeScreen> createState() => _MapHomeScreenState();
}

class _MapHomeScreenState extends State<MapHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map'),
      ),
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          zoom: 19,
          target: LatLng(23.835925219207976, 90.54001712570638),
          bearing: 0,
          tilt: 5,
        ),
        onTap: (LatLng position) {
          print(position);
        },
        onLongPress: (LatLng position) {
          print('On long press at $LatLng');
        },
        onCameraMove: (cameraPosition) {
          print(cameraPosition);
        },
        zoomControlsEnabled: true,
        zoomGesturesEnabled: true,
        compassEnabled: true,
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
      ),
    );
  }
}
