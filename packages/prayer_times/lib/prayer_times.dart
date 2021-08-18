import 'dart:math' as math;
import 'package:angles/angles.dart';
import 'package:prayer_times/generated_prayer_times.dart';
part 'prayer_time_format.dart';
part 'prayer_times_methods.dart';

class PrayerTimes {
  ///this is [PrayerTimes] class help you to get prayer time
  /// currect way to use this class is
  ///[            var p=PrayerTimes(prayerTimeMethods: PrayerTimeMethods.muslimWorldLeague,prayerTimeFormat: PrayerTimeFormat.h24);             ]
  ///
  ///to get
  var timeNames = {
    'imsak': 'Imsak',
    'fajr': 'Fajr',
    'sunrise': 'Sunrise',
    'dhuhr': 'Dhuhr',
    'asr': 'Asr',
    'sunset': 'Sunset',
    'maghrib': 'Maghrib',
    'isha': 'Isha',
    'midnight': 'Midnight'
  };

//Calcu_lation Methods
  Map methods = {
    'MWL': {
      'name': 'Muslim World League',
      'params': {
        'fajr': 18,
        'isha': 17,
        'maghrib': '0 min',
        'midnight': 'Standard'
      }
    },
    'ISNA': {
      'name': 'Islamic Society of North America (ISNA)',
      'params': {
        'fajr': 15,
        'isha': 15,
        'maghrib': '0 min',
        'midnight': 'Standard'
      }
    },
    'Egypt': {
      'name': 'Egyptian General Authority of Survey',
      'params': {
        'fajr': 19.5,
        'isha': 17.5,
        'maghrib': '0 min',
        'midnight': 'Standard'
      }
    },
    'Makkah': {
      'name': 'Umm Al-Qura University, Makkah',
      'params': {
        'fajr': 18.5,
        'isha': '90 min after the sunset',
        'maghrib': '0 min',
        'midnight': 'Standard'
      }
    },
    'Karachi': {
      'name': 'University of Islamic Sciences, Karachi',
      'params': {
        'fajr': 18,
        'isha': 18,
        'maghrib': '0 min',
        'midnight': 'Standard'
      }
    },
    'Tehran': {
      'name': 'Institute of Geophysics, University of Tehran',
      'params': {'fajr': 17.7, 'isha': 14, 'maghrib': 4.5, 'midnight': 'Jafari'}
    },
    'Jafari': {
      'name': 'Shia Ithna-Ashari, Leva Institute, Qum',
      'params': {'fajr': 16, 'isha': 14, 'maghrib': 4, 'midnight': 'Jafari'}
    }
  };

// Default Parameters in Clcu_lation Methods
  final defaultParams = {'maghrib': '0 min', 'midnight': 'Standard'};

//DateTime
  var date = DateTime.now();
// Default Settings
  var calcMethod = 'Jafari';
// do not change anything here; use _adjust method instead
  Map settings = {
    'imsak': '10 min',
    'dhuhr': '0 min',
    'asr': 'Standard',
    'high_Lats': 'NightMiddle',
    'fajr': 16.0,
    'isha': 14.0,
    'maghrib': '0 min',
    'midnight': 'Standard',
  };
  int timeZone = 6;
  String _timeFormat = '24h';
  final _timeSuffixes = ['am', 'pm'];
  final _invalidTime = '-----';
  PrayerTimeFormat prayerTimeFormat;
  var _numIterations = 1;
  var _offset = {};
  var _offsets = {};
  var _lat;
  var _lng;
  var _elv;
  var _jDate;
//Initialization

  PrayerTimeMethods prayerTimeMethods;
  String method = 'MWL';
  PrayerTimes({
    this.prayerTimeFormat = PrayerTimeFormat.h12,
    this.prayerTimeMethods = PrayerTimeMethods.muslimWorldLeague,
  }) {
    this._timeFormat = prayerTimeFormat.format;
    this.method = prayerTimeMethods.method;
    methods.forEach((method, config) {
      defaultParams.forEach((name, value) {
        if (config['params']![name] == null) {
          methods[method]!['params'][name] = value;
        }
      });
    });
    // initialize settings

    methods.containsKey(method) ? calcMethod = method : calcMethod = 'MWL';

    Map params = methods[calcMethod]!['params'];

    params.forEach((name, value) {
      settings[name] = value;
    });
    // init time _offsets
    timeNames.forEach((name, value) {
      _offset[name] = 0;
    });
  }
// instance completed Ok

  // .......Interface Functions..........
  void _setMethod(PrayerTimeMethods prayerTimeMethods) {
    method = prayerTimeMethods.method;
    if (methods[method] != null) {
      _adjust(methods[method]!['params']);
      calcMethod = method;
    }
  }

  void _adjust(Map params) {
    params.forEach((key, value) {
      settings[key] = value;
    });
  }

  void _tune(Map timeOffset) {
    timeOffset.forEach((key, value) {
      _offsets[key] = value;
    });
  }

  String getMethod() => calcMethod;

  Map getSettings() => settings;

  Map getOffsets() => _offset;

  Map getDefaults() => methods;

// return prayer times for given date
  GeneratedPrayerTimes getTimes(
      DateTime date, double _latitude, double longitude, timezone,
      {elevation,
      dst = false,
      PrayerTimeFormat format = PrayerTimeFormat.h24}) {
    _lat = _latitude;
    _lng = longitude;
    _elv = elevation != null ? elevation : 0;

    _timeFormat = format.format;

    timeZone = timezone + (dst ? 1 : 0);
    _jDate = julian(date.year, date.month, date.day) - (_lng / (15 * 24.0));
    print(_computeTimes());
    return GeneratedPrayerTimes.fromTimes(_computeTimes());
  }

// convert float time to the given format (see timeFormats)
  dynamic _getFormatttedTime(double time, format, {suffixes}) {
    if (time is! num) {
      return _invalidTime;
    }
    if (format == 'double') {
      return time;
    }
    suffixes ??= _timeSuffixes;
    time = _fixhour(time + 0.5 / 60); // add 0.5 minutes to round
    var hours = time.floorToDouble();
    var minutes = ((time - hours) * 60).floorToDouble();
    String suffix = format == '12h' ? suffixes[hours < 12 ? 0 : 1] : '';
    var a = hours;
    var formattedTime = format == '24h'
        ? '${hours.toInt()}:${minutes.toInt()}'
        : '${(((hours + 11).toInt() % 12) + 1).toInt()}:${minutes.toInt()}';
    return formattedTime + suffix;
  }
// ...........Calcu_lation Functions..........

//   compute mid-day time
  dynamic _midDay(time) {
    var eqt = _sunPosition(_jDate + time)[1];
    return _fixhour(12 - eqt);
  }

//compute the time at which sun reaches a specific angle below horizon
  dynamic _sunAngleTime(angle, time, {direction}) {
    try {
      var decl = _sunPosition(_jDate + time)[0];

      var noon = _midDay(time);
      var t = (1 / 15.0) *
          _arccos((-_sin(angle) - _sin(decl) * _sin(_lat)) /
              (_cos(decl) * _cos(_lat)));

      return noon + (direction == 'ccw' ? -t : t);
    } catch (e) {
      print(e);
      return 0;
    }
  }

// computing asr time
  dynamic _asrTime(factor, time) {
    var decl = _sunPosition(_jDate + time)[0];
    var angle = -_arccot(factor + _tan((_lat - decl).abs()));
    return _sunAngleTime(angle, time);
  }

// compute declination angle of sun and equation of time
// Ref: http://aa.usno.navy.mil/faq/docs/SunApprox.php
  List _sunPosition(jd) {
    var D = jd - 2451545;

    var g = _fixangle(357 + 0.98560028 * D); //g Ok

    var q = _fixangle(280.459 + 0.98564736 * D); // ok

    var L = _fixangle(q + 1.912 * _sin(g) + 0.020 * _sin(2 * g));

    // ignore: unused_local_variable
    var R = 1.00014 - 0.01671 * _cos(g) - 0.00014 * _cos(2 * g);

    var e = 23.439 - 0.00000036 * D;

    var RA = _arctan2(_cos(e) * _sin(L), _cos(L)) / 15.0;

    var eqt = q / 15.0 - _fixhour(RA);
    var decl = _arcsin(_sin(e) * _sin(L));
    return [decl, eqt];
  }

//convert Gregorian date to Julian day
  // Ref: Astronomical Algorithms by Jean Meeus
  double julian(year, month, day) {
    if (month <= 2) {
      year -= 1;
      month += 12;
    }
    var A = (year ~/ 100);
    var B = 2 - A + (A ~/ 4);
    var julianDate =
        (365.25 * (year + 4716)) + 30.6001 * (month + 1) + (day + B - 1524.5);

    return julianDate;
  }

//.............compute prayer times
//compute prayer times at given julian date

  Map<String, double> _computePrayerTimes(Map times) {
    var portiontimes = _dayPortion(times); // _dayPortion right

    var params = settings;
    double imsak = _sunAngleTime(_eval(params['imsak']), portiontimes['imsak'],
        direction: 'ccw');
    //ok here

    double fajr = _sunAngleTime(_eval(params['fajr']), portiontimes['fajr'],
        direction: 'ccw');

    double sunrise = _sunAngleTime(
        _eval(_riseSetAngle(elevation: _elv)), portiontimes['sunrise'],
        direction: 'ccw');

    double dhuhr = _midDay(portiontimes['dhuhr']);
    double asr = _asrTime(_asrFactor(params['asr']), portiontimes['asr']);

    double sunset = _sunAngleTime(
      _riseSetAngle(elevation: _elv),
      portiontimes['sunset'],
    );
    double maghrib;
    if (method == 'Tehran' || method == 'Jafari') {
      maghrib = _sunAngleTime(
        _eval(params['maghrib']),
        portiontimes['maghrib'],
      );
    } else {
      maghrib = sunset + _eval(params['maghrib']);
    }

    double isha;
    if (method == 'Makkah') {
      isha = sunset + _eval(params['isha']) / 60;
    } else {
      isha = _sunAngleTime(
        _eval(params['isha']),
        portiontimes['isha'],
      );
    }

    return {
      'imsak': imsak,
      'fajr': fajr,
      'sunrise': sunrise,
      'dhuhr': dhuhr,
      'asr': asr,
      'sunset': sunset,
      'maghrib': maghrib,
      'isha': isha
    };
  }

// _computeTimes
  Map _computeTimes() {
    var times = {
      'imsak': 5.0,
      'fajr': 5.0,
      'sunrise': 6.0,
      'dhuhr': 12.0,
      'asr': 13.0,
      'sunset': 18.0,
      'maghrib': 18.0,
      'isha': 18.0
    };
    //main iterations
    for (var i = 0; i < _numIterations; i++) {
      times = _computePrayerTimes(times); //

    }
    times = _adjustTimes(times) as Map<String, double>;
    if (settings['midnight'] == 'Jafari') {
      times['midnight'] =
          times['sunset']! + _timeDiff(times['sunset'], times['fajr']) / 2;
    } else {
      times['midnight'] =
          times['sunset']! + _timeDiff(times['sunset'], times['sunrise']) / 2;
    }
    times = tuneTimes(times);

    return _modifyFormats(times);
  }

//_adjust times in a prayer time array
  Map _adjustTimes(Map times) {
    var params = settings;
    var tzAdjust = timeZone - _lng / 15;
    times.forEach((name, value) {
      times[name] += tzAdjust;
    });
//    if (params['high_Lats'] != 'None') times = _adjustHigh_Lats(times);
    if (_isMin(params['imsak'])) {
      times['imsak'] = times['fajr'] - _eval(params['imsak']) / 60.0;
    }
    // need to ask about 'min' in settings
    if (_isMin(params['maghrib'])) {
      times['maghrib'] = times['sunset'] - _eval(params['maghrib']) / 60.0;
    }
    if (_isMin(params['isha'])) {
      print(times['maghrib']);
      print(_eval(params['isha']) / 60.0);
      times['isha'] = times['maghrib'] - _eval(params['isha']) / 60.0;
    }
    times['dhuhr'] += _eval(params['dhuhr']) / 60.0;
    return times;
  }

// get asr factor
  dynamic _asrFactor(String asrParam) {
    var methodss = {'Standard': 1, 'Hamafi': 2};
    return methodss[asrParam] ?? _eval(asrParam);
  }

//return sun angle for sunset/sunrise
  double _riseSetAngle({elevation = 0}) {
    elevation == null ? elevation = 0 : elevation = elevation;
    return 0.833 + 0.0347 * math.sqrt(elevation);
  }

// apply _offsets to the times
  Map<String, double> tuneTimes(Map<String, double> times) {
    times.forEach((name, value) {
      times[name] = times[name]! + _offset[name] / 60;
    });
    return times;
  }

//convert times to given time format
  Map _modifyFormats(Map times) {
    var utimes = {};
    times.forEach((name, value) {
      utimes[name] = _getFormatttedTime(times[name], _timeFormat);
    });
    return utimes;
  }
  // _adjust times for locations in highter _latitudes

  Map _adjustHigh_Lats(Map times) {
    var params = settings;
    var nightTime = _timeDiff(times['sunset'], times['sunrise']);
    times['imsak'] = _adjustHLTime(times['imsak'], times['sunrise'],
        _eval(params['imsak'] as String), nightTime,
        direction: 'ccw');
    times['fajr'] = _adjustHLTime(times['fajr'], times['sunrise'],
        _eval(params['fajr'] as String), nightTime,
        direction: 'ccw');
    times['isha'] = _adjustHLTime(times['isha'], times['sunset'],
        _eval(params['isha'] as String), nightTime);
    times['maghrib'] = _adjustHLTime(times['maghrib'], times['sunset'],
        _eval(params['imsak'] as String), nightTime);
    return times;
  }

// _adjust a time for highter _latitudes
  dynamic _adjustHLTime(time, base, angle, night, {direction}) {
    var portion = _nightPortion(angle, night);
    var diff =
        direction == 'ccw' ? _timeDiff(time, base) : _timeDiff(base, time);
    if (time is! num || diff > portion) {
      time = base + (direction == 'ccw' ? -portion : portion);
      return time;
    }
  }

//the night portion used for adjusting times in
  double _nightPortion(angle, night) {
    method = settings['hight_Lats'];
    var portion = 1 / 2; // midnight
    if (method == 'AngleBased') {
      portion = 1 / 60 * angle;
    }
    if (method == 'OneSeventh') {
      portion = 1 / 7;
    }
    return portion * night;
  }

  //_dayPortion convert hour to day portion
  Map _dayPortion(Map times) {
    times.forEach((key, value) {
      times[key] = value / 24;
    });

    return times;
  }

  //.............Misc functions......................
  //compute the difference between two times
  dynamic _timeDiff(time1, time2) => _fixhour(time2 - time1);
//# convert given string into a number
  double _eval(st) {
    if (st is String) {
      var val = st.split(RegExp('[^0-9.+-]'));
      val.removeWhere((element) => element == '');
      var result = double.parse(val[0]);

      return result;
    } else {
      var result = st.toDouble();

      return result;
    }
  }

//detect if input contains 'min'
  bool _isMin(arg) {
    if (arg is String) return arg.contains('min');
    return false;
  }

//...............Degree-Based Math Function...........
  double _sin(d) => math.sin(Angle.degrees(d.toDouble()).radians);
  double _cos(d) => math.cos(Angle.degrees(d.toDouble()).radians);
  double _tan(d) => math.tan(Angle.degrees(d).radians);

  double _arcsin(x) => Angle.degrees(Angle.asin(x.toDouble()).degrees).degrees;
  double _arccos(x) => Angle.degrees(Angle.acos(x.toDouble()).degrees).degrees;
  double _arctan(x) => Angle.degrees(Angle.atan(x.toDouble()).degrees).degrees;
  double _arccot(x) =>
      Angle.degrees(Angle.atan(1.0 / x.toDouble()).degrees).degrees;
  double _arctan2(y, x) =>
      Angle.degrees(Angle.atan2(y.toDouble(), x.toDouble()).degrees).degrees;

  dynamic _fixangle(angle) => _fix(angle.toDouble(), 360);
  dynamic _fixhour(hour) => _fix(hour.toDouble(), 24);

  dynamic _fix(a, mode) {
    if (a is! num) {
      return a;
    }
    a = a - mode * (a ~/ mode);
    return a < 0 ? a + mode : a;
  }
}
