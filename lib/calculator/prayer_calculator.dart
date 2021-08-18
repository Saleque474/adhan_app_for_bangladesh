import 'package:flutter/material.dart';

class PrayerTimeCalculator extends StatefulWidget {
  const PrayerTimeCalculator({Key? key}) : super(key: key);

  @override
  _PrayerTimeCalculatorState createState() => _PrayerTimeCalculatorState();
}

class _PrayerTimeCalculatorState extends State<PrayerTimeCalculator> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF4f955e),
        title: Text("Prayer Time Calculator"),
      ),
    );
  }
}
