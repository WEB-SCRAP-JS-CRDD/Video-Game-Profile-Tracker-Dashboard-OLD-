import 'package:flutter/material.dart';
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
          Image.asset(
            'assets/players.webp',
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
          _buildStatusItem('          PLAYERS   :   ', statusData['Players']!),
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Image.asset(
            'assets/viewers.png',
            width: 80,
            height: 80,
            fit: BoxFit.cover,
          ),
          _buildStatusItem(
              '           VIEWERS    :    ', statusData['LIVE VIEWERS']!),
        ]),
        _buildDivider(),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Image.asset(
            'assets/twitch.png',
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
          _buildStatusItem('    RANK ON TWITCH    :   ', statusData['RANK']!),
        ]),
      ]),
    );
  }

  Widget _buildStatusItem(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: GoogleFonts.tiroDevanagariHindi(
              color: AppColors.front,
              fontSize: 30,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.tiroDevanagariHindi(
              color: AppColors.front,
              fontSize: 30,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() => Divider(
        color: AppColors.front,
        height: 15,
      );
}

class AppColors {
  static const Color back = Color(0xFF25232A);
  static const Color front = Color(0xFFd0bcff);
}
