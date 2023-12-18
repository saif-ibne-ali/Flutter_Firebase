import 'package:flutter/material.dart';
import 'package:flutter_firebase/Screens/soccer_match_list_screen.dart';

class SoccerApp extends StatelessWidget {
  const SoccerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SoccerMatchList(),
    );
  }
}
