import 'package:azhan_app/home/body.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:prayer_times/generated_prayer_times.dart';
import 'package:prayer_times/prayer_times.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late PrayerTimes prayerTimes = PrayerTimes(
      prayerTimeFormat: PrayerTimeFormat.h12,
      prayerTimeMethods: PrayerTimeMethods.muslimWorldLeague);
  late DateTime date;
  late GeneratedPrayerTimes times;

  @override
  void initState() {
    date = DateTime.now();
    var latitude = 23.8479;
    var longitude = 90.2576;
    var timezone = 6;
    times = prayerTimes.getTimes(date, latitude, longitude, timezone,
        format: PrayerTimeFormat.h12);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFF333e52),
        appBar: AppBar(
          backgroundColor: Color(0xFF4f955e),
          centerTitle: true,
          title: Text("Prayer Time"),
        ),
        body: LayoutBuilder(builder: (context, constraints) {
          print(constraints.maxWidth);
          List<List<double>> positions = [
            [
              (constraints.maxHeight / 26) * 5,
              (constraints.maxWidth / 343) * 20
            ],
            [
              (constraints.maxHeight / 26) * 5.5,
              (constraints.maxWidth / 343) * 349 -
                  (constraints.maxHeight / 591) * 160
            ],
            [
              (constraints.maxHeight / 26) * 10,
              (constraints.maxWidth / 343) * 20
            ],
            [
              (constraints.maxHeight / 26) * 10.5,
              (constraints.maxWidth / 343) * 349 -
                  (constraints.maxHeight / 591) * 160
            ],
            [
              (constraints.maxHeight / 26) * 15,
              (constraints.maxWidth / 343) * 20
            ],
            [
              (constraints.maxHeight / 26) * 15.5,
              (constraints.maxWidth / 343) * 349 -
                  (constraints.maxHeight / 591) * 160
            ],
            [
              (constraints.maxHeight / 26) * 20,
              (constraints.maxWidth / 343) * 20
            ],
            [
              (constraints.maxHeight / 26) * 20.5,
              (constraints.maxWidth / 343) * 349 -
                  (constraints.maxHeight / 591) * 160
            ],
          ];

          return Body(
            positions: positions,
            times: times,
            constraints: constraints,
          );
        }),
      ),
    );
  }
}
