import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

// Assuming you have a model class for your champion data
class Champion {
  final String name;
  final String winRate;
  final String matches;
  final String role;

  Champion({
    required this.name,
    required this.winRate,
    required this.matches,
    required this.role,
  });
}

class DashboardWidget extends StatelessWidget {
  final String textContent;
  final String textContent2;
  final String textContent3;
  final String textContent4;
  final Champion champion;
  final String imagePath;
  final String imagePath2;

  DashboardWidget({
    required this.textContent,
    required this.textContent2,
    required this.textContent3,
    required this.textContent4,
    required this.champion,
    required this.imagePath,
    required this.imagePath2,
  });

  @override
  Widget build(BuildContext context) {
    // Define the text style just once
    TextStyle textStyle =
        GoogleFonts.tiroDevanagariHindi(color: AppColors.front, fontSize: 30);
    TextStyle textStyle2 =
        GoogleFonts.tiroDevanagariHindi(color: AppColors.front, fontSize: 20);
    TextStyle textStyle3 =
        GoogleFonts.tiroDevanagariHindi(color: AppColors.front, fontSize: 40);

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: AppColors.back.withOpacity(0.9),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 2, color: AppColors.front)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                imagePath2,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
              Text(
                textContent3,
                style: textStyle3,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                textContent,
                style: textStyle,
              ),
              Image.asset(
                imagePath,
                width: 140,
                height: 140,
                fit: BoxFit.cover,
              ),
              Text(
                textContent4,
                style: textStyle2,
              ),
            ],
          ),
          Text(
            textContent2,
            style: textStyle,
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset('assets/champ/${champion.name}.webp',
                  width: 40, height: 40),
              SizedBox(
                  width: 30), // horizontal space between the image and the text
              Text(champion.winRate, style: textStyle2),
              SizedBox(width: 30), // horizontal space between texts
              Text(champion.matches, style: textStyle2),
              SizedBox(width: 30), // horizontal space between texts
              SvgPicture.asset('assets/icons/${champion.role}.svg',
                  width: 30, height: 30),
            ],
          ),
          SizedBox(height: 25),
        ],
      ),
    );
  }
}

class AppColors {
  static const Color back = Color(0xFF25232A);
  static const Color front = Color(0xFFd0bcff);
}
