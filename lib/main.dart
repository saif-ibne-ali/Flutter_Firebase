import 'package:flutter/material.dart';
import 'package:flutter_google_maps/map_home_screen.dart';

void main(List<String> args) {
  runApp(const GoogleMapsApp());
}

class GoogleMapsApp extends StatelessWidget {
  const GoogleMapsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MapHomeScreen(),
    );
  }
}
