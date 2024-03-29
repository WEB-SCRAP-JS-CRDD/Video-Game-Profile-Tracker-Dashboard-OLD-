import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:video_player/video_player.dart';
import 'compt.dart';
import 'champions_page.dart';
import 'graph.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late VideoPlayerController _controller;
  Map<String, dynamic> data = {};

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/wall.mp4')
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
        _controller.setLooping(true);
      });
    loadData();
  }

  Future<void> loadData() async {
    final jsonString = await rootBundle.loadString('assets/data_import.json');
    final Map<String, dynamic> jsonMap = json.decode(jsonString);
    setState(() {
      data = jsonMap;
    });
  }

  List<Widget> buildCounters() {
    return data.entries.map((entry) {
      return CustomCounter(
        title: entry.key,
        value: entry.value.toString(),
        maxValue: 100, // Ajustez selon vos besoins
      );
    }).toList();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bienvenue sur la faille de l'invocateur"),
      ),
      body: Stack(
        children: [
          // Fond d'écran vidéo
          _controller.value.isInitialized
              ? SizedBox.expand(
            child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: _controller.value.size.width,
                height: _controller.value.size.height,
                child: VideoPlayer(_controller),
              ),
            ),
          )
              : Center(child: CircularProgressIndicator()), // Affiche un indicateur de chargement pendant que la vidéo se charge

          // Compteurs dynamiques
          Align(
            alignment: Alignment.center, // Ajustez l'alignement selon vos préférences
            child: Wrap(
              children: buildCounters(),
            ),
          ),

          // Boutons en bas de la page
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: ElevatedButton(
                        child: Text('🧍‍♂️', style: TextStyle(fontSize: 36)),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ChampionsPage()),
                          );
                        },
                        style: ElevatedButton.styleFrom(minimumSize: Size(0, 100)),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: ElevatedButton(
                        child: Text('📈', style: TextStyle(fontSize: 36)),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Scaffold(
                                appBar: AppBar(title: Text("Distribution des rangs")),
                                body: RankBarChart(rankData: rankData), // Assurez-vous que rankData est défini quelque part
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(minimumSize: Size(0, 100)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


