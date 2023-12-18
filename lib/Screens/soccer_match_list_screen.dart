import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/Models/soccer_match_model.dart';
import 'package:flutter_firebase/Screens/match_detail_screen.dart';

class SoccerMatchList extends StatefulWidget {
  const SoccerMatchList({super.key});

  @override
  State<SoccerMatchList> createState() => _SoccerMatchListState();
}

class _SoccerMatchListState extends State<SoccerMatchList> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  late CollectionReference soccerStatsCollectionRef =
      db.collection('soccerstats');
  List<SoccerMatch> matchList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Match List'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: RefreshIndicator(
        onRefresh: () async => soccerStatsCollectionRef.get(),
        child: StreamBuilder(
            stream: soccerStatsCollectionRef
                .orderBy('runningTime', descending: true)
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              }
              if (snapshot.hasData) {
                matchList.clear();
                for (QueryDocumentSnapshot element in snapshot.data!.docs) {
                  SoccerMatch soccerMatch = SoccerMatch(
                    team1: element.get('team1'),
                    team2: element.get('team2'),
                    runningTime: element.get('runningTime'),
                    totalTime: element.get('totalTime'),
                    team1Goal: element.get('team1Goal'),
                    team2Goal: element.get('team2Goal'),
                    id: element.id,
                  );
                  matchList.add(soccerMatch);
                }
                return ListView.builder(
                    itemCount: matchList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                            '${matchList[index].team1} vs ${matchList[index].team2}'),
                        trailing: IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MatchDetailScreen(
                                    soccerMatch: matchList[index]),
                              ),
                            );
                          },
                          icon: const Icon(Icons.arrow_forward),
                        ),
                      );
                    });
              }
              return const SizedBox();
            }),
      ),
    );
  }
}

