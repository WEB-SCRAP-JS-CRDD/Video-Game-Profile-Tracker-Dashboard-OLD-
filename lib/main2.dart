import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Dashboard Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Dashboard Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Les données des statistiques à afficher
  final List<Map<String, dynamic>> stats = [
    {'label': 'Utilisateurs', 'value': 1234, 'color': Colors.green},
    {'label': 'Ventes', 'value': 5678, 'color': Colors.red},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Un widget qui affiche une statistique en forme ronde
            StatWidget(
              label: stats[0]['label'],
              value: stats[0]['value'],
              color: stats[0]['color'],
            ),
            SizedBox(height: 16), // Un espace vertical
            // Un autre widget qui affiche une statistique en forme ronde
            StatWidget(
              label: stats[1]['label'],
              value: stats[1]['value'],
              color: stats[1]['color'],
            ),
          ],
        ),
      ),
    );
  }
}

// Un widget personnalisé qui affiche une statistique en forme ronde
class StatWidget extends StatelessWidget {
  final String label; // Le nom de la statistique
  final int value; // La valeur de la statistique
  final Color color; // La couleur de la statistique

  // Le constructeur du widget, qui prend les paramètres en entrée
  const StatWidget({
    Key? key,
    required this.label,
    required this.value,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200, // La largeur du widget
      height: 200, // La hauteur du widget
      decoration: BoxDecoration(
        shape: BoxShape.circle, // La forme ronde du widget
        color: color, // La couleur du widget
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              label, // Le nom de la statistique
              style: TextStyle(
                fontSize: 24, // La taille du texte
                color: Colors.white, // La couleur du texte
              ),
            ),
            Text(
              value.toString(), // La valeur de la statistique
              style: TextStyle(
                fontSize: 48, // La taille du texte
                fontWeight: FontWeight.bold, // Le style du texte
                color: Colors.white, // La couleur du texte
              ),
            ),
          ],
        ),
      ),
    );
  }
}
