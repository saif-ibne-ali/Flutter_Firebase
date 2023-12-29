import 'dart:developer';

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

  Future<void> getCurrentLocation() async {
    final LocationData locationData = await location.getLocation();
    // googleMapController.moveCamera(
    //   CameraUpdate.newCameraPosition(
    //     CameraPosition(
    //       target: LatLng(locationData.latitude!, locationData.longitude!),
    //     ),
    //   ),
    // );

    googleMapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(locationData.latitude!, locationData.longitude!),
        ),
      ),
    );
    if(mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getCurrentLocation();
          // Navigator.push(context,
          //     MaterialPageRoute(builder: (context) => const LocationScreen()));
        },
        child: const Icon(Icons.location_on_rounded),
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
        onMapCreated: (GoogleMapController controller) {
          googleMapController = controller;
          getCurrentLocation();
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
              polylineId: const PolylineId('Draw line'),
              color: Colors.green,
              width: 6,
              endCap: Cap.roundCap,
              startCap: Cap.roundCap,
              jointType: JointType.mitered,
              patterns: [
                PatternItem.gap(10),
                PatternItem.dash(10),
                PatternItem.dot,
                PatternItem.dash(10),
              ],
              points: const [
                LatLng(23.83589969260255, 90.53978014737368),
                LatLng(23.835925146981904, 90.54001718759537),
                LatLng(23.835680110038282, 90.53999472409487),
                LatLng(23.83589969260255, 90.53978014737368),
              ]),
          Polyline(
              polylineId: const PolylineId('Draw line 2'),
              color: Colors.green,
              width: 6,
              endCap: Cap.roundCap,
              startCap: Cap.roundCap,
              jointType: JointType.mitered,
              patterns: [
                PatternItem.gap(10),
                PatternItem.dash(10),
                PatternItem.dot,
                PatternItem.dash(10),
              ],
              points: const [
                LatLng(23.836607813171575, 90.53973454982042),
                LatLng(23.836602906329492, 90.54002959281206),
                LatLng(23.836310948890954, 90.53973589092493),
                LatLng(23.836294694938612, 90.54000310599804),
              ]),
        },
        polygons: {
          Polygon(
              polygonId: const PolygonId('Rectangale'),
              visible: true,
              fillColor: Colors.grey,
              strokeColor: Colors.indigo,
              strokeWidth: 6,
              consumeTapEvents: true,
              onTap: () {
                log('tapped on rectangular area');
              },
              points: const [
                LatLng(23.83601837743711, 90.53947638720274),
                LatLng(23.836059472419105, 90.53966984152794),
                LatLng(23.836267707239667, 90.53964000195265),
                LatLng(23.836231519179982, 90.53940363228321),
              ]),
        },
        circles: {
          Circle(
              circleId: const CircleId('It is circle'),
              center: const LatLng(23.83656886510737, 90.53937379270792),
              radius: 10,
              fillColor: Colors.pink.shade400,
              strokeColor: Colors.indigo,
              strokeWidth: 4,
              consumeTapEvents: true,
              onTap: () {
                log('Tapped on The Circle');
              }),
        },
      ),
    );
  }
}
