import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StatusBar extends StatelessWidget {
  final Map<String, String> buffNerfData;

  StatusBar({Key? key, required this.buffNerfData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 2,
          color: AppColors.front,
        ),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.back.withOpacity(0.7),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 2, color: AppColors.front),
          ),
          child: Column(
            children: [
              Text(
                'Next Buff / Nerf',
                style: GoogleFonts.tiroDevanagariHindi(
                  color: AppColors.front,
                  fontSize: 30,
                ),
              ),
              SizedBox(height: 10), // Spacing between title and icons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: buffNerfData.entries.map((entry) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      children: [
                        Image.asset(entry.key, width: 50, height: 50),
                        SizedBox(height: 10),
                        Image.asset(entry.value, width: 20, height: 20),
                      ],
                    ),
                  );
                }).toList(),
              ),
              SizedBox(width: 240)
            ],
          ),
        ),
      ],
    );
  }
}

class AppColors {
  static const Color back = Color(0xFF25232A);
  static const Color front = Color(0xFFd0bcff);
}
