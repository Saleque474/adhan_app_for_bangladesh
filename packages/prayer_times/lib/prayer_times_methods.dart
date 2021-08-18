part of 'prayer_times.dart';

class PrayerTimeMethods {
  final String method;
  const PrayerTimeMethods(this.method);
  static const PrayerTimeMethods muslimWorldLeague = PrayerTimeMethods('MWL');
  static const PrayerTimeMethods islamicSocietyOfNorthAmerica =
      PrayerTimeMethods('ISNA');
  static const PrayerTimeMethods eyegyptianGeneralAuthorityOfSurvey =
      PrayerTimeMethods('Egypt');
  static const PrayerTimeMethods ummAlQuraUniversityMakkah =
      PrayerTimeMethods('Makkah');
  static const PrayerTimeMethods universityOfIslamicSciencesKarachi =
      PrayerTimeMethods('Karachi');
  static const PrayerTimeMethods instituteOfGeophysicsUniversityOfTehran =
      PrayerTimeMethods('Tehran');
  static const PrayerTimeMethods shiaIthnaAshariLevaInstituteQum =
      PrayerTimeMethods('Jafari');
}
