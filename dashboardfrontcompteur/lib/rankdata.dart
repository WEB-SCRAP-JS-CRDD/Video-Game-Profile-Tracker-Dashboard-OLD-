import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

export 'rankdata.dart';

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

class RankGroup {
  final String imagePath;
  final int divisions;
  RankGroup({required this.imagePath, required this.divisions});
}

enum GameRegion { EUW, NA, KR, AW }

List<RankData> rankDataEUW = [
  RankData('Fer IV', 1.20, const Color(0xFFBDBDBD)),
  RankData('Fer III', 1.60, const Color(0xFFBDBDBD)),
  RankData('Fer II', 2.50, const Color(0xFFBDBDBD)),
  RankData('Fer I', 3.10, const Color(0xFFBDBDBD)),
  RankData('Bronze IV', 5.60, const Color(0xFF795548)),
  RankData('Bronze III', 4.80, const Color(0xFF795548)),
  RankData('Bronze II', 4.60, const Color(0xFF795548)),
  RankData('Bronze I', 3.70, const Color(0xFF795548)),
  RankData('Argent IV', 5.50, const Color(0xFFE0E0E0)),
  RankData('Argent III', 4.40, const Color(0xFFE0E0E0)),
  RankData('Argent II', 4.00, const Color(0xFFE0E0E0)),
  RankData('Argent I', 3.30, const Color(0xFFE0E0E0)),
  RankData('Or IV', 7.00, const Color(0xFFFBC02D)),
  RankData('Or III', 5.30, const Color(0xFFFBC02D)),
  RankData('Or II', 5.20, const Color(0xFFFBC02D)),
  RankData('Or I', 4.70, const Color(0xFFFBC02D)),
  RankData('Platine IV', 7.20, const Color(0xFF18FFFF)),
  RankData('Platine III', 4.60, const Color(0xFF18FFFF)),
  RankData('Platine II', 3.80, const Color(0xFF18FFFF)),
  RankData('Platine I', 2.90, const Color(0xFF18FFFF)),
  RankData('Emeraude IV', 5.80, const Color(0xFF00E676)),
  RankData('Emeraude III', 2.80, const Color(0xFF00E676)),
  RankData('Emeraude II', 1.90, const Color(0xFF00E676)),
  RankData('Emeraude I', 2.00, const Color(0xFF00E676)),
  RankData('Diamant IV', 1.80, const Color(0xFF40C4FF)),
  RankData('Diamant III', 0.81, const Color(0xFF40C4FF)),
  RankData('Diamant II', 0.60, const Color(0xFF40C4FF)),
  RankData('Diamant I', 0.46, const Color(0xFF40C4FF)),
  RankData('Maitre', 0.66, const Color(0xFFE040FB)),
  RankData('GrandMaitre', 0.025, const Color(0xFFFF1744)),
  RankData('Challenger', 0.011, const Color(0xFFFBC02D)),
];

List<RankData> rankDataNA = [
  RankData('Fer IV', 1.00, const Color(0xFFBDBDBD)),
  RankData('Fer III', 1.20, const Color(0xFFBDBDBD)),
  RankData('Fer II', 2.10, const Color(0xFFBDBDBD)),
  RankData('Fer I', 2.90, const Color(0xFFBDBDBD)),
  RankData('Bronze IV', 5.90, const Color(0xFF795548)),
  RankData('Bronze III', 5.40, const Color(0xFF795548)),
  RankData('Bronze II', 5.30, const Color(0xFF795548)),
  RankData('Bronze I', 4.60, const Color(0xFF795548)),
  RankData('Argent IV', 6.00, const Color(0xFFE0E0E0)),
  RankData('Argent III', 4.80, const Color(0xFFE0E0E0)),
  RankData('Argent II', 4.30, const Color(0xFFE0E0E0)),
  RankData('Argent I', 3.40, const Color(0xFFE0E0E0)),
  RankData('Or IV', 6.10, const Color(0xFFFBC02D)),
  RankData('Or III', 4.40, const Color(0xFFFBC02D)),
  RankData('Or II', 4.20, const Color(0xFFFBC02D)),
  RankData('Or I', 3.70, const Color(0xFFFBC02D)),
  RankData('Platine IV', 7.01, const Color(0xFF18FFFF)),
  RankData('Platine III', 4.40, const Color(0xFF18FFFF)),
  RankData('Platine II', 3.80, const Color(0xFF18FFFF)),
  RankData('Platine I', 2.90, const Color(0xFF18FFFF)),
  RankData('Emeraude IV', 6.20, const Color(0xFF00E676)),
  RankData('Emeraude III', 3.00, const Color(0xFF00E676)),
  RankData('Emeraude II', 2.00, const Color(0xFF00E676)),
  RankData('Emeraude I', 2.10, const Color(0xFF00E676)),
  RankData('Diamant IV', 1.90, const Color(0xFF40C4FF)),
  RankData('Diamant III', 0.83, const Color(0xFF40C4FF)),
  RankData('Diamant II', 0.60, const Color(0xFF40C4FF)),
  RankData('Diamant I', 0.47, const Color(0xFF40C4FF)),
  RankData('Maitre', 0.59, const Color(0xFFE040FB)),
  RankData('GrandMaitre', 0.056, const Color(0xFFFF1744)),
  RankData('Challenger', 0.024, const Color(0xFFFBC02D)),
];

List<RankData> rankDataKR = [
  RankData('Fer IV', 1.00, const Color(0xFFBDBDBD)),
  RankData('Fer III', 1.40, const Color(0xFFBDBDBD)),
  RankData('Fer II', 2.40, const Color(0xFFBDBDBD)),
  RankData('Fer I', 2.80, const Color(0xFFBDBDBD)),
  RankData('Bronze IV', 4.90, const Color(0xFF795548)),
  RankData('Bronze III', 4.30, const Color(0xFF795548)),
  RankData('Bronze II', 4.20, const Color(0xFF795548)),
  RankData('Bronze I', 3.50, const Color(0xFF795548)),
  RankData('Argent IV', 5.30, const Color(0xFFE0E0E0)),
  RankData('Argent III', 4.20, const Color(0xFFE0E0E0)),
  RankData('Argent II', 3.90, const Color(0xFFE0E0E0)),
  RankData('Argent I', 3.20, const Color(0xFFE0E0E0)),
  RankData('Or IV', 6.00, const Color(0xFFFBC02D)),
  RankData('Or III', 4.60, const Color(0xFFFBC02D)),
  RankData('Or II', 4.60, const Color(0xFFFBC02D)),
  RankData('Or I', 3.90, const Color(0xFFFBC02D)),
  RankData('Platine IV', 8.00, const Color(0xFF18FFFF)),
  RankData('Platine III', 5.20, const Color(0xFF18FFFF)),
  RankData('Platine II', 4.40, const Color(0xFF18FFFF)),
  RankData('Platine I', 3.10, const Color(0xFF18FFFF)),
  RankData('Emeraude IV', 6.30, const Color(0xFF00E676)),
  RankData('Emeraude III', 3.00, const Color(0xFF00E676)),
  RankData('Emeraude II', 2.00, const Color(0xFF00E676)),
  RankData('Emeraude I', 2.10, const Color(0xFF00E676)),
  RankData('Diamant IV', 2.00, const Color(0xFF40C4FF)),
  RankData('Diamant III', 0.85, const Color(0xFF40C4FF)),
  RankData('Diamant II', 0.59, const Color(0xFF40C4FF)),
  RankData('Diamant I', 0.45, const Color(0xFF40C4FF)),
  RankData('Maitre', 0.59, const Color(0xFFE040FB)),
  RankData('GrandMaitre', 0.024, const Color(0xFFFF1744)),
  RankData('Challenger', 0.010, const Color(0xFFFBC02D)),
];

List<RankData> rankDataAW = [
  RankData('Fer IV', 1.10, const Color(0xFFBDBDBD)),
  RankData('Fer III', 1.50, const Color(0xFFBDBDBD)),
  RankData('Fer II', 2.40, const Color(0xFFBDBDBD)),
  RankData('Fer I', 3.00, const Color(0xFFBDBDBD)),
  RankData('Bronze IV', 5.20, const Color(0xFF795548)),
  RankData('Bronze III', 4.60, const Color(0xFF795548)),
  RankData('Bronze II', 4.40, const Color(0xFF795548)),
  RankData('Bronze I', 3.70, const Color(0xFF795548)),
  RankData('Argent IV', 5.50, const Color(0xFFE0E0E0)),
  RankData('Argent III', 4.40, const Color(0xFFE0E0E0)),
  RankData('Argent II', 4.00, const Color(0xFFE0E0E0)),
  RankData('Argent I', 3.40, const Color(0xFFE0E0E0)),
  RankData('Or IV', 6.20, const Color(0xFFFBC02D)),
  RankData('Or III', 4.50, const Color(0xFFFBC02D)),
  RankData('Or II', 4.40, const Color(0xFFFBC02D)),
  RankData('Or I', 3.70, const Color(0xFFFBC02D)),
  RankData('Platine IV', 7.10, const Color(0xFF18FFFF)),
  RankData('Platine III', 4.60, const Color(0xFF18FFFF)),
  RankData('Platine II', 4.00, const Color(0xFF18FFFF)),
  RankData('Platine I', 2.90, const Color(0xFF18FFFF)),
  RankData('Emeraude IV', 6.10, const Color(0xFF00E676)),
  RankData('Emeraude III', 3.00, const Color(0xFF00E676)),
  RankData('Emeraude II', 2.00, const Color(0xFF00E676)),
  RankData('Emeraude I', 2.20, const Color(0xFF00E676)),
  RankData('Diamant IV', 2.00, const Color(0xFF40C4FF)),
  RankData('Diamant III', 0.87, const Color(0xFF40C4FF)),
  RankData('Diamant II', 0.63, const Color(0xFF40C4FF)),
  RankData('Diamant I', 0.50, const Color(0xFF40C4FF)),
  RankData('Maitre', 0.59, const Color(0xFFE040FB)),
  RankData('GrandMaitre', 0.064, const Color(0xFFFF1744)),
  RankData('Challenger', 0.052, const Color(0xFFFBC02D)),
];

Map<GameRegion, List<RankData>> regionRankData = {
  GameRegion.EUW: rankDataEUW,
  GameRegion.NA: rankDataNA,
  GameRegion.KR: rankDataKR,
  GameRegion.AW: rankDataAW,
};
