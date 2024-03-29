import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  Map<String, dynamic> data = {};

  @override
  void initState() {
    super.initState();
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.front,
      appBar: AppBar(
        title: Text("Dashboard"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),

          child: Wrap(
            alignment: WrapAlignment.spaceEvenly,
            spacing: 8.0,
            runSpacing: 4.0,
            children: data.entries.map((entry) {
              String value = entry.value.toString(); // Convertir toutes les valeurs en String
              int maxValue = 100; // Définir une valeur max par défaut ou une logique spécifique
              return CustomCounter(title: entry.key, value: value, maxValue: maxValue);
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class CustomCounter extends StatelessWidget {
  final String title;
  final String value;
  final int maxValue;
  final double circleSize; // Nouveau paramètre pour la taille du cercle
  final double titleFontSize; // Nouveau paramètre pour la taille de la police du titre
  final Color titleColor; // Nouveau paramètre pour la couleur du titre

  CustomCounter({
    required this.title,
    required this.value,
    required this.maxValue,
    this.circleSize = 300.0, // Valeur par défaut pour la taille du cercle
    this.titleFontSize = 30.0, // Valeur par défaut pour la taille de la police du titre
    this.titleColor = AppColors.front,

  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: circleSize,
      height: circleSize, // Utilisez le paramètre circleSize pour définir la taille du cercle
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: AppColors.back.withOpacity(0.5),
        shape: BoxShape.circle,
      ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.front,
              fontSize: titleFontSize, // Utilisez le paramètre titleFontSize pour la taille de la police
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          Text(
            value,
            style: TextStyle(fontSize: 30, color: AppColors.front),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );

  }
}


class AppColors {
  static const Color back = Color(0xFF25232A); // Plus sombre
  static const Color front = Color(0xFFd0bcff); // Plus sombre
}