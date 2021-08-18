class GeneratedPrayerTimes {
  final String fajr;
  final String dhuhr;
  final String asr;
  final String maghrib;
  final String isha;
  final String sunset;
  final String sunrise;
  final String midnight;
  final String imsak;
  const GeneratedPrayerTimes(this.imsak, this.fajr, this.dhuhr, this.asr,
      this.maghrib, this.isha, this.sunset, this.sunrise, this.midnight);
  factory GeneratedPrayerTimes.fromTimes(Map times) {
    return GeneratedPrayerTimes(
        times['imsak'],
        times['fajr'],
        times['dhuhr'],
        times['asr'],
        times['maghrib'],
        times['isha'],
        times['sunset'],
        times['sunrise'],
        times['midnight']);
  }
}
