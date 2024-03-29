import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class Champion {
  final String name;
  final String winRate;
  final String banRate;
  final String matches;
  final String role;

  Champion({
    required this.name,
    required this.winRate,
    required this.banRate,
    required this.matches,
    required this.role,
  });

  factory Champion.fromJson(Map<String, dynamic> json) {
    return Champion(
      name: json['Champion Name'],
      winRate: json['Win rate'],
      banRate: json['Ban Rate'],
      matches: json['Matches'],
      role: json['Role'],
    );
  }
}

class ChampionsPage extends StatefulWidget {
  @override
  _ChampionsPageState createState() => _ChampionsPageState();
}

class _ChampionsPageState extends State<ChampionsPage> {
  List<Champion> champions = [];
  List<Champion> filteredChampions = [];
  bool isAscending = false;
  int? sortColumnIndex;
  String selectedRole = 'All';
  bool isLoading = false;
  double _opacity = 1.0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    loadChampions();
  }

  Future<void> loadChampions() async {
    setState(() => isLoading = true);
    await Future.delayed(Duration(seconds: 2)); // Simule un chargement de 5 secondes

    final String response = await rootBundle.loadString('assets/data_export.json');
    final data = json.decode(response) as List;

    if (_timer != null && _timer!.isActive) _timer!.cancel();
    setState(() {
      champions = data.map((jsonChampion) => Champion.fromJson(jsonChampion as Map<String, dynamic>)).toList();
      filteredChampions = champions;
      isLoading = false;
    });

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() => _opacity = _opacity == 1.0 ? 0.0 : 1.0);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void onSort(int columnIndex, bool ascending) {
    if (columnIndex == 0) {
      filteredChampions.sort((a, b) => compareString(ascending, a.name, b.name));
    } else if (columnIndex == 1) {
      filteredChampions.sort((a, b) => compareString(ascending, a.winRate, b.winRate));
    } else if (columnIndex == 2) {
      filteredChampions.sort((a, b) => compareString(ascending, a.banRate, b.banRate));
    } else if (columnIndex == 3) {
      filteredChampions.sort((a, b) => compareNumber(ascending, a.matches, b.matches));
    }
    setState(() {
      sortColumnIndex = columnIndex;
      isAscending = ascending;
    });
  }

  int compareString(bool ascending, String value1, String value2) {
    return ascending ? value1.compareTo(value2) : value2.compareTo(value1);
  }

  int compareNumber(bool ascending, String value1, String value2) {
    int number1 = int.parse(value1.replaceAll(',', ''));
    int number2 = int.parse(value2.replaceAll(',', ''));
    return ascending ? number1.compareTo(number2) : number2.compareTo(number1);
  }

  void filterChampions(String role) {
    setState(() {
      selectedRole = role;
      filteredChampions = role == 'All' ? champions : champions.where((champion) => champion.role == role).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Champions Dashboard'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: loadChampions,
          ),
        ],
      ),
      body: isLoading
          ? Center(
        child: AnimatedOpacity(
          opacity: _opacity,
          duration: Duration(milliseconds: 500),
          child: Image.asset('assets/logo.jpg'), // Assure
        ),
      )
          : Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              color: Colors.grey[900], // Fond noir clair pour le DropdownButton
              child: DropdownButton<String>(
                isExpanded: true, // S'assurer que le DropdownButton s'étend à la largeur du Container
                value: selectedRole,
                onChanged: (value) {
                  if (value != null) filterChampions(value);
                },
                items: <String>['All', 'ADC', 'SUPP', 'MID', 'JUNGLE', 'TOP']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                dropdownColor: Colors.grey[900], // Couleur de fond pour les éléments du menu
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  sortAscending: isAscending,
                  sortColumnIndex: sortColumnIndex,
                  columns: [
                    DataColumn(label: Text('Champion Name'), onSort: onSort),
                    DataColumn(label: Text('Win Rate'), onSort: onSort),
                    DataColumn(label: Text('Ban Rate'), onSort: onSort),
                    DataColumn(label: Text('Matches'), onSort: onSort),
                  ],
                  rows: filteredChampions.map(
                        (champion) => DataRow(
                      cells: [
                        DataCell(
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Image.asset('assets/champ/${champion.name}.webp', width: 24, height: 24), // Assurez-vous que le chemin et le format de fichier sont corrects
                              SizedBox(width: 8), // Espacement entre l'icône et le texte
                              Text(champion.name),
                            ],
                          ),
                        ),
                        DataCell(Text(champion.winRate)),
                        DataCell(Text(champion.banRate)),
                        DataCell(Text(champion.matches)),
                      ],
                    ),
                  ).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}