import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:video_player/video_player.dart';
import 'compteur2status.dart';
import 'champions_page.dart';
import 'graph.dart';
import 'dashboard_widget.dart' as dashboard;
import 'gauge.dart' as gauge;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late VideoPlayerController _controller;
  Map<String, dynamic> data = {};
  bool _isVideoFinished = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/wall.mp4')
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
        _controller.setLooping(false);
      });
    _controller.addListener(() {
      if (!_controller.value.isPlaying &&
          _controller.value.isInitialized &&
          (_controller.value.duration == _controller.value.position)) {
        setState(() {
          _isVideoFinished = true;
        });
      }
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

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    dashboard.Champion sampleChampion = dashboard.Champion(
      name: 'Blitzcrank',
      winRate: 'WR : 52.3%',
      matches: 'PLAYED : 235',
      role: 'SUPP',
    );
    return Scaffold(
      body: Stack(
        children: [
          _isVideoFinished
              ? Image.asset('assets/finvid.png',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity)
              : _controller.value.isInitialized
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
                  : Center(child: CircularProgressIndicator()),

          if (data.isNotEmpty)
            Positioned(
              top: 10,
              right: 10,
              child: StatusBar(statusData: {
                "LIVE VIEWERS": data['LIVE VIEWERS'],
                "RANK": data['RANK'],
                "Players": data['Players'],
                "Server Capacity": data['Server Capacity'],
              }),
            ),
          Positioned(
            top: 10,
            right: 575,
            child: gauge.StatusBar(statusData: {
              "LIVE VIEWERS": data['LIVE VIEWERS'],
              "RANK": data['RANK'],
              "Players": data['Players'],
              "Server Capacity": data['Server Capacity'],
            }),
          ),
          Positioned(
            top: 10,
            left: 10,
            child: dashboard.DashboardWidget(
              textContent: 'Emerald IV   ',
              textContent2: 'Main Champion : Blitzcrank !',
              textContent3: '   Gotaga #EUW  (Level 486)',
              textContent4: '   (16% of EUW)',
              imagePath: 'assets/iconrank/emerald.webp',
              imagePath2: 'assets/pp.png',
              champion: sampleChampion,
            ),
          ),
          // Les boutons en bas de la page
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Bouton pour la page des champions
                  _buildBottomButton('🧍‍♂️', () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChampionsPage()));
                  }),

                  // Bouton pour la page des statistiques
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChampionsPage()));
                    },
                    child: Image.asset(
                        'assets/pp.png'), // Utilisez Image.network si votre image est en ligne
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomButton(String label, VoidCallback onPressed) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: ElevatedButton(
          child: Text(label, style: TextStyle(fontSize: 36)),
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(minimumSize: Size(0, 100)),
        ),
      ),
    );
  }
}
