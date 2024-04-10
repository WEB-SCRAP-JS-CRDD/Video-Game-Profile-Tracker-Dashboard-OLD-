import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

String getIconName(String role) {
  switch (role.toUpperCase()) {
    case 'ADC':
      return 'ADC';
    case 'SUPP':
      return 'SUPP';
    case 'MID':
      return 'MID';
    case 'JUNGLE':
      return 'JUNGLE';
    case 'TOP':
      return 'TOP';
    default:
      return 'ALL';
  }
}

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
  final double iconSize = 32.0;
  final TextStyle textStyle = TextStyle(fontSize: 22);
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadChampions();
    _searchController.addListener(_filterChampionsByName);
  }

  Future<void> loadChampions() async {
    setState(() => isLoading = true);
    //await Future.delayed(
    //    Duration(seconds: 2)); // Simule un chargement de 5 secondes

    final String response =
        await rootBundle.loadString('assets/data_export.json');
    final data = json.decode(response) as List;

    setState(() {
      champions = data
          .map((jsonChampion) =>
              Champion.fromJson(jsonChampion as Map<String, dynamic>))
          .toList();
      filteredChampions = champions;
      isLoading = false;
    });
  }

  @override
  void dispose() {
    // N'oubliez pas de disposer le TextEditingController lorsque le widget est disposé
    _searchController.dispose();
    super.dispose();
  }

  void _filterChampionsByName() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      filteredChampions = champions.where((champion) {
        return champion.name.toLowerCase().contains(query);
      }).toList();
    });
  }

  void onSort(int columnIndex, bool ascending) {
    List<Champion> tempSorted = List.from(filteredChampions);
    if (columnIndex == 0) {
      tempSorted.sort((a, b) => compareString(ascending, a.name, b.name));
    } else if (columnIndex == 1) {
      tempSorted.sort((a, b) => compareString(ascending, a.winRate, b.winRate));
    } else if (columnIndex == 2) {
      tempSorted.sort((a, b) => compareString(ascending, a.banRate, b.banRate));
    } else if (columnIndex == 3) {
      tempSorted.sort((a, b) => compareNumber(ascending, a.matches, b.matches));
    }
    setState(() {
      sortColumnIndex = columnIndex;
      isAscending = ascending;
      filteredChampions = tempSorted; // Ne pas limiter la liste ici
    });
  }

  List<Champion> getVisibleChampions() {
    return filteredChampions.take(8).toList();
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
    List<Champion> tempFiltered = role == 'All'
        ? champions
        : champions.where((champion) => champion.role == role).toList();

    setState(() {
      selectedRole = role;
      filteredChampions = tempFiltered; // Ne pas limiter la liste ici
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/tabtitle.png',
          width: 300,
          height: 50,
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/finvid2.png'),
            fit: BoxFit
                .cover, // Couvre toute la zone du Container sans déformer l'image.
          ),
        ),
        child: isLoading
            ? Center(
                child: AnimatedOpacity(
                  opacity: _opacity,
                  duration: Duration(milliseconds: 500),
                  child: Image.asset(
                      'assets/logo.jpg'), // Assurez-vous que cet asset est ajouté à votre projet
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        for (var role in [
                          'ALL',
                          'ADC',
                          'SUPP',
                          'MID',
                          'JUNGLE',
                          'TOP'
                        ])
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedRole = role == 'ALL' ? 'All' : role;
                              });
                              filterChampions(selectedRole);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                color: selectedRole ==
                                        (role == 'ALL' ? 'All' : role)
                                    ? AppColors.back
                                    : Colors.transparent,
                                // Change background color if selected
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              child: SvgPicture.asset(
                                'assets/icons/$role.svg',
                                width: iconSize,
                                height: iconSize,
                                color: selectedRole ==
                                        (role == 'ALL' ? 'All' : role)
                                    ? AppColors.front
                                    : null, // Change icon color if selected
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        labelText: 'Search Champion',
                        suffixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Container(
                          width: 1500, // Définir la largeur fixe ici
                          decoration: BoxDecoration(
                            color: AppColors.back.withOpacity(0.7),
                            // Ici, '0.7' est l'opacité du fond blanc. Vous pouvez ajuster cette valeur entre 0.0 et 1.0.
                            borderRadius: BorderRadius.circular(20),
                            //border: Border.all(
                            //width: 2, color: AppColors.front),
                          ),

                          child: DataTable(
                            dataRowHeight: 60.0,

                            sortAscending: isAscending,
                            sortColumnIndex: sortColumnIndex,
                            columnSpacing: 200,
                            // Ajustez l'espacement si nécessaire
                            horizontalMargin: 10,
                            // Ajustez les marges si nécessaire
                            columns: <DataColumn>[
                              DataColumn(
                                label: Container(
                                  width:
                                      200, // Largeur fixe pour la colonne "Champion"
                                  child: Text('Champion',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ),
                                onSort: onSort,
                              ),
                              DataColumn(
                                label: Container(
                                  width:
                                      100, // Largeur fixe pour la colonne "Win Rate"
                                  child: Text('Win Rate',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ),
                                onSort: onSort,
                              ),
                              DataColumn(
                                label: Container(
                                  width:
                                      100, // Largeur fixe pour la colonne "Ban Rate"
                                  child: Text('Ban Rate',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ),
                                onSort: onSort,
                              ),
                              DataColumn(
                                label: Container(
                                  width:
                                      100, // Largeur fixe pour la colonne "Matches"
                                  child: Text('Matches',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ),
                                onSort: onSort,
                              ),
                              DataColumn(
                                label: Container(
                                  width:
                                      100, // Largeur fixe pour la colonne "Role"
                                  child: Text('Role',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                            ],
                            rows: getVisibleChampions()
                                .map((champion) => DataRow(
                                      cells: [
                                        DataCell(
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Image.asset(
                                                  'assets/champ/${champion.name}.webp',
                                                  width: iconSize,
                                                  height: iconSize),
                                              SizedBox(width: 8),
                                              Text(champion.name,
                                                  style: textStyle),
                                            ],
                                          ),
                                        ),
                                        DataCell(Text(champion.winRate,
                                            style: textStyle)),
                                        DataCell(Text(champion.banRate,
                                            style: textStyle)),
                                        DataCell(Text(champion.matches,
                                            style: textStyle)),
                                        DataCell(
                                          SvgPicture.asset(
                                            'assets/icons/${getIconName(champion.role)}.svg',
                                            width: iconSize,
                                            height: iconSize,
                                          ),
                                        ),
                                      ],
                                    ))
                                .toList(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

class AppColors {
  static const Color back = Color(0xFF25232A); // Plus sombre
  static const Color front = Color(0xFFd0bcff); // Plus sombre
}
