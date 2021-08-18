import 'package:flutter/material.dart';
import 'calculator/prayer_calculator.dart';
import 'home/home.dart';
import 'kiblah/kiblah.dart';

void main() {
  runApp(PrayerTimerApp());
}

class PrayerTimerApp extends StatelessWidget {
  const PrayerTimerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: App(),
    );
  }
}

var screens = [PrayerTimeCalculator(), Home(), Kiblah()];

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  int _currentIndex = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
              label: 'Calculator', icon: Icon(Icons.calculate)),
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(label: 'Kibla', icon: Icon(Icons.directions))
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      body: screens[_currentIndex],
    );
  }
}
