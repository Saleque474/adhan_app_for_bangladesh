import 'package:hijri_calculator/hijri_calculator.dart';
import 'package:prayer_times/prayer_times.dart';

void main() {
  var date = DateTime.now();
  var p = PrayerTimes(
    prayerTimeFormat: PrayerTimeFormat.h24,
  );
  String a = p.getTimes(date, 23, 90, 6, format: PrayerTimeFormat.h24).maghrib;
  var b = a.replaceAll('pm', '').replaceAll('am', '');
  print(b);
  // var l = Locations.fromJson(locations);
  // print(l.zilas[0].districts[0].subdistricts[0].lat);
  var c = HijriCalculator().gregorianToHijri(2024, date.month, date.day);
  print(c);
}
