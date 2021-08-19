import 'dart:async';

import 'package:azhan_app/home/hijri_calculator.dart';
import 'package:azhan_app/home/settings_button.dart';
import 'package:azhan_app/time_container/time_container.dart';
import 'package:flutter/material.dart';
import 'package:prayer_times/generated_prayer_times.dart';

import 'count_down.dart';

class Body extends StatefulWidget {
  const Body(
      {Key? key,
      required this.positions,
      required this.times,
      required this.constraints})
      : super(key: key);
  final BoxConstraints constraints;
  final List<List<double>> positions;
  final GeneratedPrayerTimes times;

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late List<List<double>> positions;
  late String remains;
  late DateTime date;
  @override
  void initState() {
    update();
    periodicUpdate();
    positions = widget.positions;
    super.initState();
  }

  void update() {
    date = DateTime.now();
    int now = date.hour * 3600 + date.minute * 60 + date.second;
    int dhuhr = _converter(widget.times.dhuhr);
    int asr = _converter(widget.times.asr);
    int maghrib = _converter(widget.times.maghrib);
    int isha = _converter(widget.times.isha);
    int fajr = _converter(widget.times.fajr);
    if (isha > now) remains = remainsMaker(isha, now, 'Isha');
    if (maghrib > now) remains = remainsMaker(maghrib, now, 'Maghrib');
    if (asr > now) remains = remainsMaker(asr, now, 'Asr');
    if (dhuhr > now) remains = remainsMaker(dhuhr, now, 'Dhuhr');
    if (fajr > now) {
      remains = remainsMaker(fajr, now, 'Fajr');
    } else if (now > isha) {
      var allRemains = 24 * 3600 + fajr - now;
      var hour = allRemains ~/ 3600;
      var minute = (allRemains - hour * 3600) ~/ 60;
      var second = (allRemains - hour * 3600 - minute * 60);

      String convertintotwo(int t) {
        return t.toString().length > 1 ? '$t' : '0$t';
      }

      String convertedTime =
          '${convertintotwo(hour)}:${convertintotwo(minute)}:${convertintotwo(second)}';
      remains = 'Fajr $convertedTime';
    }
  }

  int _converter(String time) {
    int converted;
    if (time.contains('pm')) {
      var t = time.replaceAll('pm', '');

      converted = (int.parse((t.split(':'))[0]) == 12
                  ? int.parse((t.split(':'))[0])
                  : int.parse((t.split(':'))[0]) + 12) *
              3600 +
          int.parse((t.split(':'))[1]) * 60;
    } else {
      var t = time.replaceAll('am', '');

      converted = int.parse((t.split(':'))[0]) * 3600 +
          int.parse((t.split(':'))[1]) * 60;
    }

    return converted;
  }

  String remainsMaker(int wakto, int now, String waktoName) {
    var allRemains = wakto - now;
    var hour = allRemains ~/ 3600;
    var minute = (allRemains - hour * 3600) ~/ 60;
    var second = (allRemains - hour * 3600 - minute * 60);
    String convertintotwo(int t) {
      return t.toString().length > 1 ? '$t' : '0$t';
    }

    String convertedTime =
        '${convertintotwo(hour)}:${convertintotwo(minute)}:${convertintotwo(second)}';
    return '$waktoName $convertedTime';
  }

  void periodicUpdate() {
    Timer.periodic(Duration(seconds: 1), (t) {
      if (mounted) setState(() {});
      update();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (u) {
        setState(() {
          positions.shuffle();
        });
      },
      child: Stack(
        children: [
          Positioned(
            top: (widget.constraints.maxHeight / 18) * .4,
            left: (widget.constraints.maxWidth / 343) * 30,
            child: HijriDateContainer(widget: widget),
          ),
          Positioned(
            top: (widget.constraints.maxHeight / 18) * 2.1,
            left: (widget.constraints.maxWidth / 343) * 30,
            child: CountDown(widget: widget, text: remains),
          ),
          AnimatedPositioned(
            duration: Duration(seconds: 1),
            top: positions[0][0],
            left: positions[0][1],
            child: TimeContainer(
              timeName: 'ফজর',
              height: widget.constraints.maxHeight,
              time: timeTider(widget.times.fajr),
              soundOn: false,
            ),
          ),
          AnimatedPositioned(
            duration: Duration(seconds: 1),
            top: positions[1][0],
            left: positions[1][1],
            child: TimeContainer(
              timeName: 'যোহর',
              height: widget.constraints.maxHeight,
              time: timeTider(widget.times.dhuhr),
              soundOn: false,
            ),
          ),
          AnimatedPositioned(
            duration: Duration(seconds: 1),
            top: positions[2][0],
            left: positions[2][1],
            child: TimeContainer(
              timeName: 'আছর',
              height: widget.constraints.maxHeight,
              time: timeTider(widget.times.asr),
              soundOn: false,
            ),
          ),
          AnimatedPositioned(
            duration: Duration(seconds: 1),
            top: positions[3][0],
            left: positions[3][1],
            child: TimeContainer(
              timeName: 'মাগরিব',
              height: widget.constraints.maxHeight,
              time: timeTider(widget.times.maghrib),
              soundOn: false,
            ),
          ),
          AnimatedPositioned(
            duration: Duration(seconds: 1),
            top: positions[4][0],
            left: positions[4][1],
            child: TimeContainer(
              timeName: 'ইশা',
              height: widget.constraints.maxHeight,
              time: timeTider(widget.times.isha),
              soundOn: false,
            ),
          ),
          AnimatedPositioned(
            duration: Duration(seconds: 1),
            top: positions[5][0],
            left: positions[5][1],
            child: TimeContainer(
              timeName: 'ইশরাক',
              height: widget.constraints.maxHeight,
              time: timeTider(widget.times.sunrise),
              soundOn: false,
            ),
          ),
          AnimatedPositioned(
            duration: Duration(seconds: 1),
            top: positions[6][0],
            left: positions[6][1],
            child: TimeContainer(
              timeName: 'মধ্যরাত',
              height: widget.constraints.maxHeight,
              time: timeTider(widget.times.midnight),
              soundOn: false,
            ),
          ),
          AnimatedPositioned(
            duration: Duration(seconds: 1),
            top: positions[7][0],
            left: positions[7][1],
            child: TimeContainer(
              timeName: 'ইমসাক',
              height: widget.constraints.maxHeight,
              time: timeTider(widget.times.imsak),
              soundOn: false,
            ),
          ),
          Center(
              child: SettingsButton(
            size: widget.constraints.maxWidth / 5,
          ))
        ],
      ),
    );
  }

  String timeTider(String unTideTime) {
    String tideTime;
    if (unTideTime.contains('pm')) {
      unTideTime = unTideTime.replaceAll('pm', '');
      List parts = unTideTime.split(':');
      parts[0] = parts[0].toString().length > 1 ? parts[0] : '0' + parts[0];
      parts[1] = parts[1].toString().length > 1 ? parts[1] : '0' + parts[1];
      tideTime = '${parts[0]}:${parts[1]} pm';
    } else {
      unTideTime = unTideTime.replaceAll('am', '');

      List parts = unTideTime.split(':');
      parts[0] = parts[0].toString().length > 1 ? parts[0] : '0' + parts[0];
      parts[1] = parts[1].toString().length > 1 ? parts[1] : '0' + parts[1];
      tideTime = '${parts[0]}:${parts[1]} am';
    }

    return tideTime;
  }
}
