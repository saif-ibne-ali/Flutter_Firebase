import 'dart:developer';

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
            log(position.toString());
          },
          onLongPress: (LatLng position) {
            log('On long press at $LatLng');
          },
          onCameraMove: (cameraPosition) {
            log(cameraPosition.toString());
          },
          zoomControlsEnabled: true,
          zoomGesturesEnabled: true,
          compassEnabled: true,
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          markers: {
            Marker(
              markerId: const MarkerId('Initial Position'),
              position: const LatLng(23.835925219207976, 90.54001712570638),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueYellow),
              infoWindow: const InfoWindow(
                  title: 'Marker Title', snippet: 'This is a snippet'),
              draggable: true,
              onDragEnd: (LatLng position) {
                log(position.toString());
              },
              onDragStart: (LatLng position) {
                log(position.toString());
              },
              onDrag: (LatLng position) {
                log(position.toString());
              },
              onTap: () => log('Tapped in marker'),
            ),
            Marker(
              markerId: const MarkerId('Initial Position B'),
              position: const LatLng(23.835680110038282, 90.53999472409487),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueYellow),
              infoWindow: const InfoWindow(
                  title: 'Marker Title', snippet: 'This is a snippet'),
              draggable: true,
              onDragEnd: (LatLng position) {
                log(position.toString());
              },
              onDragStart: (LatLng position) {
                log(position.toString());
              },
              onDrag: (LatLng position) {
                log(position.toString());
              },
              onTap: () => log('Tapped in marker'),
            ),
            Marker(
              markerId: const MarkerId('Initial Position B'),
              position: const LatLng(23.83589969260255, 90.53977981209755),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueYellow),
              infoWindow: const InfoWindow(
                  title: 'Marker Title', snippet: 'This is a snippet'),
              draggable: true,
              onDragEnd: (LatLng position) {
                log(position.toString());
              },
              onDragStart: (LatLng position) {
                log(position.toString());
              },
              onDrag: (LatLng position) {
                log(position.toString());
              },
              onTap: () => log('Tapped in marker'),
            ),
          },
          polylines: {
            Polyline(
                polylineId: PolylineId('Draw line'),
                color: Colors.green,
                width: 3,
                points: [
                  LatLng(23.83589969260255, 90.53978014737368),
                  LatLng(23.835925146981904, 90.54001718759537),
                ]),
          }),
    );
  }
}
