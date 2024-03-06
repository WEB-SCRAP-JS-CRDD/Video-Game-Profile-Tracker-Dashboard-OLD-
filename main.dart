import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Health Dashboard',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HealthDashboard(),
    );
  }
}

class HealthData {
  final DateTime date;
  final int steps;
  final double hoursOfSleep;

  HealthData(this.date, this.steps, this.hoursOfSleep);
}

class HealthDashboard extends StatelessWidget {
  final List<HealthData> data = [
    HealthData(DateTime(2024, 3, 1), 8000, 7.5),
    HealthData(DateTime(2024, 3, 2), 9500, 8.0),
    HealthData(DateTime(2024, 3, 3), 7000, 7.0),
    HealthData(DateTime(2024, 3, 4), 10500, 8.5),
    HealthData(DateTime(2024, 3, 5), 6000, 6.5),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Health Dashboard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              'Steps and Sleep',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: charts.TimeSeriesChart(
                _createSeries(),
                animate: true,
                dateTimeFactory: const charts.LocalDateTimeFactory(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<charts.Series<HealthData, DateTime>> _createSeries() {
    return [
      charts.Series<HealthData, DateTime>(
        id: 'Steps',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (HealthData data, _) => data.date,
        measureFn: (HealthData data, _) => data.steps,
        data: data,
      ),
      charts.Series<HealthData, DateTime>(
        id: 'Sleep',
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        domainFn: (HealthData data, _) => data.date,
        measureFn: (HealthData data, _) => data.hoursOfSleep,
        data: data,
      ),
    ];
  }
}
