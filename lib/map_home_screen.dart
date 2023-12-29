import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapHomeScreen extends StatefulWidget {
  const MapHomeScreen({super.key});

  @override
  State<MapHomeScreen> createState() => _MapHomeScreenState();
}

class _MapHomeScreenState extends State<MapHomeScreen> {
  late GoogleMapController googleMapController;
  Location location = Location();
  Marker? marker;
  Polyline? polyline;
  List<LatLng> polylinePoints = [];

  void updateLocationBy10sec(){
    location.changeSettings(
      accuracy:  LocationAccuracy.high,
      interval: 10000,
    );
  }
  void updateMarkerAndPolyline(LocationData locationData){
    LatLng latLng = LatLng(locationData.latitude!, locationData.longitude!);
    marker = Marker(
      markerId: const MarkerId('userLocation'),
      position: latLng,
      infoWindow: InfoWindow(
        title: 'My current Location',
        snippet: 'Lat: ${locationData.latitude} & Lng: ${locationData.longitude}',
      )
    );
    polylinePoints.add(latLng);
    polyline =Polyline(
      polylineId: const PolylineId('userPolyline'),
      color: Colors.blue.shade900,
      points: polylinePoints,
    );
    googleMapController.animateCamera(CameraUpdate.newLatLng(latLng));
    if(mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Realtime Location Tracker'),
      ),
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          zoom: 19,
          target: LatLng(23.835925219207976, 90.54001712570638),
          bearing: 0,
          tilt: 5,
        ),
        onMapCreated: (GoogleMapController controller) {
          googleMapController = controller;
          location.onLocationChanged.listen((currentLocation) {
            updateMarkerAndPolyline(currentLocation);
          });
          updateLocationBy10sec();

        },
        zoomControlsEnabled: true,
        zoomGesturesEnabled: true,
        compassEnabled: true,
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        markers: Set.from(marker != null ? {marker}:{}),
        polylines: Set.from(polyline != null ? [polyline]:[]),

      ),
    );
  }
}
