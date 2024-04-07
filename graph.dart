import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class RankData {
  final String rank;
  final double percentage;
  final charts.Color color;

  RankData(this.rank, this.percentage, Color color)
      : this.color = charts.Color(
    r: color.red,
    g: color.green,
    b: color.blue,
    a: color.alpha,
  );
}

List<RankData> rankData = [
  RankData('I IV', 0.98, const Color(0xFFBDBDBD)),
  RankData('I III', 1.51, const Color(0xFFBDBDBD)),
  RankData('I II', 2.51, const Color(0xFFBDBDBD)),
  RankData('I I', 3.25, const Color(0xFFBDBDBD)),
  RankData('B IV', 5.48, const Color(0xFF795548)),
  RankData('B III', 4.89, const Color(0xFF795548)),
  RankData('B II', 4.67, const Color(0xFF795548)),
  RankData('B I', 3.88, const Color(0xFF795548)),
  RankData('S IV', 5.53, const Color(0xFFE0E0E0)),
  RankData('S III', 4.49, const Color(0xFFE0E0E0)),
  RankData('S II', 4.18, const Color(0xFFE0E0E0)),
  RankData('S I', 3.55, const Color(0xFFE0E0E0)),
  RankData('G IV', 6.15, const Color(0xFFFBC02D)),
  RankData('G III', 4.60, const Color(0xFFFBC02D)),
  RankData('G II', 4.62, const Color(0xFFFBC02D)),
  RankData('G I', 4.15, const Color(0xFFFBC02D)),
  RankData('P IV', 7.11, const Color(0xFF18FFFF)),
  RankData('P III', 4.63, const Color(0xFF18FFFF)),
  RankData('P II', 3.94, const Color(0xFF18FFFF)),
  RankData('P I', 3.08, const Color(0xFF18FFFF)),
  RankData('E IV', 5.71, const Color(0xFF00E676)),
  RankData('E III', 2.86, const Color(0xFF00E676)),
  RankData('E II', 1.94, const Color(0xFF00E676)),
  RankData('E I', 1.90, const Color(0xFF00E676)),
  RankData('D IV', 1.78, const Color(0xFF40C4FF)),
  RankData('D III', 0.84, const Color(0xFF40C4FF)),
  RankData('D II', 0.60, const Color(0xFF40C4FF)),
  RankData('D I', 0.44, const Color(0xFF40C4FF)),
  RankData('M', 0.66, const Color(0xFFE040FB)),
  RankData('GM', 0.03, const Color(0xFFFF1744)),
  RankData('C', 0.01, const Color(0xFFFBC02D)),
];


class RankGroup {
  final String imagePath;
  final int divisions; // 4 pour les rangs avec sous-divisions, 1 pour les autres
  RankGroup({required this.imagePath, required this.divisions});
}
List<RankGroup> rankGroups = [
  RankGroup(imagePath: "assets/iconrank/iron.webp", divisions: 4),
  RankGroup(imagePath: "assets/iconrank/bronze.webp", divisions: 4),
  RankGroup(imagePath: "assets/iconrank/silver.webp", divisions: 4),
  RankGroup(imagePath: "assets/iconrank/gold.webp", divisions: 4),
  RankGroup(imagePath: "assets/iconrank/platinium.webp", divisions: 4),
  RankGroup(imagePath: "assets/iconrank/emerald.webp", divisions: 4),
  RankGroup(imagePath: "assets/iconrank/diamond.webp", divisions: 4),
  RankGroup(imagePath: "assets/iconrank/master.webp", divisions: 1),
  RankGroup(imagePath: "assets/iconrank/grandmaster.webp", divisions: 1),
  RankGroup(imagePath: "assets/iconrank/challenger.webp", divisions: 1),
];



class RankBarChart extends StatefulWidget {
  final List<RankData> rankData;

  const RankBarChart({Key? key, required this.rankData}) : super(key: key);

  @override
  _RankBarChartState createState() => _RankBarChartState();
}

class _RankBarChartState extends State<RankBarChart> {
  late List<RankData> _displayedData;

  @override
  void initState() {
    super.initState();
    _displayedData = widget.rankData; // Initialiser avec toutes les données
  }


  void _onBarTapped(RankData rank) {
    setState(() {
      // Si _displayedData est déjà filtré, revenez à l'affichage complet
      if (_displayedData.length != widget.rankData.length) {
        _displayedData = widget.rankData;
      } else {
        // Sinon, filtrez pour montrer seulement les sous-divisions du rang sélectionné
        // Cette logique dépend de la structure de vos données, ajustez-la selon vos besoins
        String rankPrefix = rank.rank.split(' ')[0]; // Prendre la première partie du rank comme identifiant du groupe
        _displayedData = widget.rankData.where((data) => data.rank.startsWith(rankPrefix)).toList();
      }
    });
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



    return Column(
      children: [
        Expanded(
          child: charts.BarChart(
            series,
            animate: true,
            domainAxis: charts.OrdinalAxisSpec(
              renderSpec: charts.SmallTickRendererSpec(
                labelStyle: const charts.TextStyleSpec(fontSize: 10, color: charts.MaterialPalette.white,),
                lineStyle: charts.LineStyleSpec(color: charts.MaterialPalette.gray.shade800,),
              ),
            ),
            primaryMeasureAxis: charts.NumericAxisSpec(
              renderSpec: charts.GridlineRendererSpec(
                labelStyle: const charts.TextStyleSpec(fontSize: 10, color: charts.MaterialPalette.white,),// Taille de la police // Couleur des étiquettes
                lineStyle: charts.LineStyleSpec(color: charts.MaterialPalette.gray.shade800,),// Couleur des lignes de la grille
              ),
            ),
            selectionModels: [
              charts.SelectionModelConfig(
                  type: charts.SelectionModelType.info,
                  changedListener: (charts.SelectionModel model){
                    //print ("Une barre a été selec");
                    if (model.hasDatumSelection){
                      RankData selectedRank = _displayedData[model.selectedDatum.first.index!];
                      _onBarTapped(selectedRank);
                    }
                  }
              )
            ],
            customSeriesRenderers: [
              charts.BarRendererConfig(
                  customRendererId: 'customBarRenderer'
              )
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Ajustez cela en fonction de votre disposition
          children: rankGroups.map((rankGroup) {
            // Vous pourriez vouloir ajuster le widget retourné ici pour mieux contrôler l'espacement
            return Expanded(
              flex: rankGroup.divisions,
              child: Image.asset(rankGroup.imagePath, height: 50), // Ajuster hauteur au besoin
            );
          }).toList(),
        ),
      ],
    );
  }
}


void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: const Text('Rank Distribution')),
      body: Center(
        child: Container(
          color: const Color(0xFF000000), // Fond en noir pour le conteneur
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: RankBarChart(rankData: rankData),
          ),
        ),
      ),
    ),
  ));
}

