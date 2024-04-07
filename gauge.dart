import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:google_fonts/google_fonts.dart';

class StatusBar extends StatelessWidget {
  final Map<String, String> statusData;

  const StatusBar({Key? key, required this.statusData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: AppColors.back.withOpacity(0.9),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 2, color: AppColors.front)),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GaugeWidget(
                percentage: double.parse(
                  statusData['Server Capacity']?.replaceAll('%', '') ?? '0',
                ),
              ),
            ],
          ),
        ]),
      ]),
    );
  }
}

class AppColors {
  static const Color back = Color(0xFF25232A);
  static const Color front = Color(0xFFd0bcff);
}

class GaugePainter extends CustomPainter {
  final double percentage;

  GaugePainter({required this.percentage});

  @override
  void paint(Canvas canvas, Size size) {
    // Centre et rayon pour l'arc
    final center = Offset(size.width / 2, size.height);
    final double radius = size.width / 2;

    Paint paint = Paint()
      ..color = Colors.grey[300]!
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;

    // Dessin de l'arc de fond
    canvas.drawArc(
      Rect.fromCenter(
          center: center, width: radius * 2, height: size.height * 2),
      math.pi, // Début à 180 degrés (à gauche)
      math.pi, // Longueur de l'arc à 180 degrés (demi-cercle)
      false,
      paint,
    );

    // Dessin de l'arc de progression
    paint.color = AppColors.front;
    double progressRadians = math.pi * (percentage / 100);
    canvas.drawArc(
      Rect.fromCenter(
          center: center, width: radius * 2, height: size.height * 2),
      math.pi, // Début à 180 degrés (à gauche)
      progressRadians, // Longueur de l'arc de progression
      false,
      paint,
    );

    // Calcul de la position de l'aiguille
    final needleAngle = math.pi * 2 - progressRadians;
    final needleLength = radius * 0.8; // Longueur de l'aiguille
    final needlePaint = Paint()
      ..color = AppColors.front
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    // Début et fin de l'aiguille
    final needleEnd = Offset(
      center.dx -
          needleLength * math.cos(needleAngle), // Inversion horizontale ici
      center.dy + needleLength * math.sin(needleAngle),
    );

    // Dessiner l'aiguille
    canvas.drawLine(center, needleEnd, needlePaint);

    // Ajout d'un cercle à la base de l'aiguille pour un meilleur effet visuel
    final needleBaseCirclePaint = Paint()..color = AppColors.front;
    canvas.drawCircle(center, radius * 0.05,
        needleBaseCirclePaint); // Ajusté pour l'esthétique
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class GaugeWidget extends StatefulWidget {
  final double percentage;

  const GaugeWidget({Key? key, required this.percentage}) : super(key: key);

  @override
  _GaugeWidgetState createState() => _GaugeWidgetState();
}

class _GaugeWidgetState extends State<GaugeWidget> {
  bool isHovered = false; // État pour suivre si le widget est survolé

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) => setState(() => isHovered = true), // Activer le survol
      onExit: (event) =>
          setState(() => isHovered = false), // Désactiver le survol
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomPaint(
            size: Size(200, 100), // Taille ajustée pour l'esthétique
            painter: GaugePainter(percentage: widget.percentage),
          ),
          Text(
            isHovered
                ? '\n${widget.percentage.toStringAsFixed(1)}%'
                : '\nServeur Capacity',
            style: GoogleFonts.tiroDevanagariHindi(
              fontSize: 30,
              color: AppColors.front,
            ),
          ),
          SizedBox(width: 240)
        ],
      ),
    );
  }
}
