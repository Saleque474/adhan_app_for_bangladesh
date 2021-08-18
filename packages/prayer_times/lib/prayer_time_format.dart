part of 'prayer_times.dart';

class PrayerTimeFormat {
  final String format;

  const PrayerTimeFormat(this.format);
  static const PrayerTimeFormat h12 = PrayerTimeFormat('12h');
  static const PrayerTimeFormat h24 = PrayerTimeFormat('24h');
}
