import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dashboard Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildStatisticCard('Statistic 1', 0.75, Colors.blue),
            _buildStatisticCard('Statistic 2', 0.6, Colors.green),
          ],
        ),
      ),
    );
  }

  Widget _buildStatisticCard(String title, double completionRate, Color color) {
    return Card(
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            SizedBox(
              height: 100, // Control the size of the circle
              width: 100, // Control the size of the circle
              child: CircularProgressIndicator(
                strokeWidth: 10, // Control the stroke width
                value: completionRate, // Current value
                backgroundColor: Colors.grey[300], // Background color
                color: color, // Progress color
              ),
            ),
            SizedBox(height: 10),
            Text('${(completionRate * 100).toInt()}%', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
