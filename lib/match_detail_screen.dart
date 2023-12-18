import 'package:flutter/material.dart';
import 'package:flutter_firebase/soccer_app.dart';

class MatchDetailScreen extends StatelessWidget {
  final SoccerMatch soccerMatch;
  const MatchDetailScreen({super.key, required this.soccerMatch});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("${soccerMatch.team1} vs ${soccerMatch.team2}"),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${soccerMatch.team1} vs ${soccerMatch.team2}",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[600],
                    ),
                  ),
                  Text(
                    "${soccerMatch.team1Goal} : ${soccerMatch.team2Goal}",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Text(
                    "Time : ${soccerMatch.runningTime}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Total Time : ${soccerMatch.totalTime}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
