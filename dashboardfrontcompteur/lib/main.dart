import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dashboard avec Flutter',
      home: DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  Map<String, dynamic> data = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final jsonString = await rootBundle.loadString('assets/data_import.json');
    final jsonMap = json.decode(jsonString);

    setState(() {
      data = jsonMap;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Helldivers 2", style: GoogleFonts.spectralSc(
        fontSize: 30,
        color: AppColors.color2,
        ),
        ),
        backgroundColor: AppColors.color5,
        centerTitle: true,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : buildDashboardContent(),
      // Set the background image here
      backgroundColor: Colors.transparent,
    );
  }

  Widget buildDashboardContent() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/wall.webp'), // Ensure this path is correct
          fit: BoxFit.cover,
        ),
      ),
      child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery
                .of(context)
                .size
                .height - (AppBar().preferredSize.height + MediaQuery
                .of(context)
                .padding
                .top),
          ),
          child: Center(
            child: Wrap(
              alignment: WrapAlignment.center,
              runAlignment: WrapAlignment.center,
              spacing: 10.0,
              runSpacing: 10.0,
              children: data.entries.map((entry) {
                return CustomCounter(
                  title: entry.key,
                  value: entry.value.toString(),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomCounter extends StatelessWidget {
  final String title;
  final String value;

  CustomCounter({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (MediaQuery.of(context).size.width - 40) / 3 - 10, // Adjust the width accordingly
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.color5,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Use the minimum space necessary for the Column
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center, // Center align the text horizontally
        children: [
          Text(
            title.toUpperCase(),
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: AppColors.color1),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          Text(
            value,
            style: TextStyle(fontSize: 28, color: AppColors.color1),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class AppColors {
  static const Color color1 = Color(0xFFE6EED6);
  static const Color color2 = Color(0xFFDDE2C6);
  static const Color color3 = Color(0xFFBBC5AA);
  static const Color color4 = Color(0xFFA72608);
  static const Color color5 = Color(0xFF5A5353);
}