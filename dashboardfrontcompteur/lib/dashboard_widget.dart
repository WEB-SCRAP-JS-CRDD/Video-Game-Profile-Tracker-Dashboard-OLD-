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
        GoogleFonts.tiroDevanagariHindi(color: AppColors.front, fontSize: 16);
    TextStyle textStyle3 =
        GoogleFonts.tiroDevanagariHindi(color: AppColors.front, fontSize: 40);
    TextStyle textStyle4 =
        GoogleFonts.tiroDevanagariHindi(color: Colors.green, fontSize: 16);
    TextStyle textStyle5 =
        GoogleFonts.tiroDevanagariHindi(color: Colors.red, fontSize: 16);
    TextStyle textStyle6 =
        GoogleFonts.tiroDevanagariHindi(color: Colors.orange, fontSize: 16);

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: AppColors.back.withOpacity(0.7),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 2, color: AppColors.front)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Bienvenue sur la faille de l\'invocateur !\n',
                style: textStyle2,
              ),
            ],
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Image.asset(
              imagePath2,
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
          ]),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                textContent3,
                style: textStyle3,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                imagePath,
                width: 150,
                height: 150,
                fit: BoxFit.cover,
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
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                decoration: BoxDecoration(
                  color: AppColors.back, // Replace with your desired color
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      color: Colors
                          .green), // Replace with your desired border color
                ),
                child: Text('Good Damage', style: textStyle4),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                decoration: BoxDecoration(
                  color: AppColors.back, // Replace with your desired color
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      color: Colors
                          .green), // Replace with your desired border color
                ),
                child: Text('Tower Destroyer', style: textStyle4),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                decoration: BoxDecoration(
                  color: AppColors.back, // Replace with your desired color
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      color: Colors
                          .orange), // Replace with your desired border color
                ),
                child: Text('Splitpusher', style: textStyle6),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                decoration: BoxDecoration(
                  color: AppColors.back, // Replace with your desired color
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      color:
                          Colors.red), // Replace with your desired border color
                ),
                child: Text('Bad Vision', style: textStyle5),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                decoration: BoxDecoration(
                  color: AppColors.back, // Replace with your desired color
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      color:
                          Colors.red), // Replace with your desired border color
                ),
                child: Text('Bad farming', style: textStyle5),
              ),
            ],
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}

class AppColors {
  static const Color back = Color(0xFF25232A);
  static const Color front = Color(0xFFd0bcff);
}
