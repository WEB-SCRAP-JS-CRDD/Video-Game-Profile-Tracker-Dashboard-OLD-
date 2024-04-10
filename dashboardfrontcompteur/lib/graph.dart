import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'rankdata.dart';

List<RankGroup> rankGroups = [
  RankGroup(imagePath: "assets/iconrank/fer.webp", divisions: 4),
  RankGroup(imagePath: "assets/iconrank/bronze.webp", divisions: 4),
  RankGroup(imagePath: "assets/iconrank/argent.webp", divisions: 4),
  RankGroup(imagePath: "assets/iconrank/or.webp", divisions: 4),
  RankGroup(imagePath: "assets/iconrank/platine.webp", divisions: 4),
  RankGroup(imagePath: "assets/iconrank/emeraude.webp", divisions: 4),
  RankGroup(imagePath: "assets/iconrank/diamant.webp", divisions: 4),
  RankGroup(imagePath: "assets/iconrank/maitre.webp", divisions: 1),
  RankGroup(imagePath: "assets/iconrank/grandmaitre.webp", divisions: 1),
  RankGroup(imagePath: "assets/iconrank/challenger.webp", divisions: 1),
];

class RankBarChart extends StatefulWidget {
  const RankBarChart({Key? key}) : super(key: key);

  @override
  _RankBarChartState createState() => _RankBarChartState();
}

class _RankBarChartState extends State<RankBarChart> {
  late List<RankData> _displayedData;
  bool _isZoomed = false;
  String? _currentZoomedRankPrefix;
  int? _currentZoomedRankIndex;

  GameRegion _selectedRegion = GameRegion.EUW; // Région sélectionnée par défaut

  @override
  void initState() {
    super.initState();
    _displayedData =
        regionRankData[_selectedRegion]!; // Initialiser avec toutes les données
  }

  void _onBarTapped(RankData rank) {
    setState(() {
      String rankPrefix = rank.rank.split(' ')[0];
      if (_isZoomed && _currentZoomedRankPrefix == rankPrefix) {
        // Si oui, revenir à l'affichage de tous les rangs pour la région sélectionnée
        _displayedData = regionRankData[_selectedRegion]!;
        _isZoomed = false;
        _currentZoomedRankPrefix = null;
        _currentZoomedRankIndex = null;
      } else {
        // Filtrer pour afficher seulement les sous-divisions du rang sélectionné
        _displayedData = regionRankData[_selectedRegion]!
            .where((data) => data.rank.startsWith(rankPrefix))
            .toList();
        _isZoomed = true;
        _currentZoomedRankPrefix = rankPrefix;
        _currentZoomedRankIndex = rankGroups.indexWhere(
          (rankGroup) {
            var rankGroupImageName =
                rankGroup.imagePath.split('/').last.split('.').first;
            var normalizedRank = rankPrefix.toLowerCase().replaceAll(' ', '');
            return normalizedRank == rankGroupImageName;
          },
        );
        // On vérifie si on a trouvé un index valide
        if (_currentZoomedRankIndex == -1) {
          _isZoomed = false; // On désactive le zoom si l'index est invalide
        }
      }
    });
  }

  void _onRegionSelected(GameRegion? newRegion) {
    if (newRegion != null) {
      setState(() {
        _selectedRegion = newRegion;
        _displayedData = regionRankData[_selectedRegion]!;
        _isZoomed = false;
        _currentZoomedRankPrefix = null;
        _currentZoomedRankIndex = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<charts.Series<RankData, String>> series = [
      charts.Series<RankData, String>(
        id: 'Ranks',
        domainFn: (RankData ranks, _) => ranks.rank,
        measureFn: (RankData ranks, _) => ranks.percentage,
        colorFn: (RankData ranks, _) => ranks.color,
        data: _displayedData,
        labelAccessorFn: (RankData row, _) => row.rank,
      )..setAttribute(charts.rendererIdKey, 'customBarRenderer'),
    ];

    // Crée la liste des DropdownMenuItems pour chaque région
    var dropdownMenuItems = GameRegion.values.map((region) {
      return DropdownMenuItem(
        value: region,
        child: Text(region.toString().split('.').last),
      );
    }).toList();

    final Map<GameRegion, Widget> regionWidgets = {
      GameRegion.EUW: Text('West Europe'),
      GameRegion.NA: Text('North America'),
      GameRegion.KR: Text('Korea'),
      GameRegion.AW: Text('Global'),
    };

    return Scaffold(
        appBar: AppBar(
          title: Image.asset(
            'assets/graphtitle.png',
            width: 300,
            height: 50,
          ),
        ),
        body: Stack(children: [
          Positioned.fill(
            child: Image.asset(
              "assets/finvid3.png",
              fit: BoxFit.cover,
            ),
          ),
          Center(
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      child: Container(
                          padding: EdgeInsets.all(8),
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: MediaQuery.of(context).size.height * 0.8,
                          decoration: BoxDecoration(
                            color: AppColors.back.withOpacity(1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              SizedBox(height: 20),
                              Expanded(
                                flex: 1,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children:
                                        regionWidgets.entries.map((entry) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ChoiceChip(
                                          label: entry.value,
                                          selected:
                                              _selectedRegion == entry.key,
                                          onSelected: (bool selected) {
                                            setState(() {
                                              _selectedRegion = entry.key;
                                              _displayedData = regionRankData[
                                                  _selectedRegion]!;
                                              _isZoomed = false;
                                            });
                                          },
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 8,
                                child: charts.BarChart(
                                  series,
                                  animate: true,
                                  domainAxis: charts.OrdinalAxisSpec(
                                    showAxisLine: true,
                                    renderSpec: _isZoomed
                                        ? charts.SmallTickRendererSpec(
                                            labelStyle:
                                                const charts.TextStyleSpec(
                                              fontSize: 15,
                                              color:
                                                  charts.MaterialPalette.white,
                                            ),
                                            lineStyle: charts.LineStyleSpec(
                                              color: charts.MaterialPalette.gray
                                                  .shade800,
                                            ),
                                          )
                                        : charts.NoneRenderSpec(),
                                  ),
                                  primaryMeasureAxis: charts.NumericAxisSpec(
                                    renderSpec: charts.GridlineRendererSpec(
                                      labelStyle: const charts.TextStyleSpec(
                                        fontSize: 15,
                                        color: charts.MaterialPalette.white,
                                      ), // Taille de la police // Couleur des étiquettes
                                      lineStyle: charts.LineStyleSpec(
                                        color: charts
                                            .MaterialPalette.gray.shade800,
                                      ), // Couleur des lignes de la grille
                                    ),
                                    tickFormatterSpec:
                                        charts.BasicNumericTickFormatterSpec(
                                            (num? value) {
                                      return '${value?.toStringAsFixed(2)}%'; // Format des étiquettes en pourcentage
                                    }),
                                  ),
                                  selectionModels: [
                                    charts.SelectionModelConfig(
                                        type: charts.SelectionModelType.info,
                                        changedListener:
                                            (charts.SelectionModel model) {
                                          //print ("Une barre a été selec");
                                          if (model.hasDatumSelection) {
                                            RankData selectedRank =
                                                _displayedData[model
                                                    .selectedDatum
                                                    .first
                                                    .index!];
                                            _onBarTapped(selectedRank);
                                          }
                                        })
                                  ],
                                  customSeriesRenderers: [
                                    charts.BarRendererConfig(
                                      customRendererId: 'customBarRenderer',
                                    )
                                  ],
                                ),
                              ),
                              _isZoomed && _currentZoomedRankIndex != null
                                  ? Image.asset(
                                      rankGroups[_currentZoomedRankIndex!]
                                          .imagePath,
                                      height:
                                          120, // Ajuster la hauteur selon l'aspect souhaité
                                    )
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: rankGroups.map((rankGroup) {
                                        return Expanded(
                                          flex: rankGroup.divisions,
                                          child: Image.asset(
                                              rankGroup.imagePath,
                                              height: 70),
                                        );
                                      }).toList(),
                                    ),
                            ],
                          )))))
        ]));
  }
}

class AppColors {
  static const Color back = Color(0xFF25232A);
  static const Color front = Color(0xFFd0bcff);
}

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: const Text('Rank Distribution'),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.grey[900],
      body: Center(
        child: Container(
          color: const Color(0xFF000000), // Fond en noir pour le conteneur
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: RankBarChart(),
          ),
        ),
      ),
    ),
  ));
}
