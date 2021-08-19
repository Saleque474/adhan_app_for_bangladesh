import 'package:azhan_app/classes/classes.dart';
import 'package:azhan_app/locations/locations.dart';
import 'package:azhan_app/main.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class SettingsButton extends StatefulWidget {
  final size;
  const SettingsButton({Key? key, required this.size}) : super(key: key);

  @override
  _SettingsButtonState createState() => _SettingsButtonState();
}

class _SettingsButtonState extends State<SettingsButton> {
  bool small = true;
  bool isSelector = false;
  Selection selection = Selection.location;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          small = false;
        });
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(
            Icons.settings,
            size: widget.size,
            color: Color(0xFF99cca6),
          ),
          AnimatedContainer(
            decoration: BoxDecoration(
                color: Color(0xFF99cca6),
                shape: small ? BoxShape.circle : BoxShape.rectangle),
            height: small ? widget.size / 2 : widget.size * 4,
            width: small ? widget.size / 2 : widget.size * 4,
            duration: Duration(milliseconds: 600),
            child: small
                ? SizedBox()
                : Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: (widget.size * 4) - 40,
                        child: isSelector
                            ? Selector(
                                selection: selection,
                              )
                            : Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  LocationSelector(
                                    widget: widget,
                                    state: this,
                                  ),
                                  MethodSelector(
                                    widget: widget,
                                    state: this,
                                  ),
                                  TimeZoneSelector(
                                    widget: widget,
                                    state: this,
                                  ),
                                ],
                              ),
                      ),
                      SizedBox(
                        height: 20,
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              small = true;
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => App()));
                            });
                          },
                          child: Text('Close'),
                        ),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}

enum Selection { location, method, timezone }

class Selector extends StatefulWidget {
  final Selection selection;
  const Selector({Key? key, required this.selection}) : super(key: key);

  @override
  _SelectorState createState() => _SelectorState();
}

class _SelectorState extends State<Selector> {
  @override
  Widget build(BuildContext context) {
    if (widget.selection == Selection.location) {
      return ZilaContainer();
    } else if (widget.selection == Selection.timezone) {
      return Text('TimeZone');
    } else if (widget.selection == Selection.method) {
      return Text('Method');
    }
    return Container();
  }
}

class ZilaContainer extends StatefulWidget {
  const ZilaContainer({
    Key? key,
  }) : super(key: key);

  @override
  _ZilaContainerState createState() => _ZilaContainerState();
}

class _ZilaContainerState extends State<ZilaContainer> {
  late Location location;
  bool isDistrict = false;
  int districtIndex = 0;
  bool isSubDistrict = false;
  int subDistrictIndex = 0;
  @override
  void initState() {
    location = Location.fromJson(locations);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: isDistrict
          ? location.districts[districtIndex].zilas
              .map((e) => TextButton(
                  onPressed: () {},
                  child: Text(
                    e.name,
                    style: TextStyle(color: Color(0xFF000000)),
                  )))
              .toList()
          : [
              ...location.districts
                  .map((e) => TextButton(
                      onPressed: () {
                        setState(() {
                          districtIndex = location.districts
                              .indexWhere((element) => element == e);
                          isDistrict = true;
                        });
                      },
                      child: Text(
                        e.name,
                        style: TextStyle(color: Color(0xFF000000)),
                      )))
                  .toList()
            ],
    ));
  }
}

class TimeZoneSelector extends StatefulWidget {
  const TimeZoneSelector({Key? key, required this.widget, required this.state})
      : super(key: key);

  final SettingsButton widget;
  final _SettingsButtonState state;

  @override
  _TimeZoneSelectorState createState() => _TimeZoneSelectorState();
}

class _TimeZoneSelectorState extends State<TimeZoneSelector> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.widget.size / 1.5,
      width: widget.widget.size * 2,
      color: Color(0xFFc2edcc),
      child: Center(
        child: TextButton(
            onPressed: () {
              setState(() {
                widget.state.selection = Selection.timezone;
                widget.state.isSelector = true;
              });
            },
            child: Text("TimeZone")),
      ),
    );
  }
}

class MethodSelector extends StatefulWidget {
  const MethodSelector({Key? key, required this.widget, required this.state})
      : super(key: key);

  final SettingsButton widget;
  final _SettingsButtonState state;

  @override
  _MethodSelectorState createState() => _MethodSelectorState();
}

class _MethodSelectorState extends State<MethodSelector> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.widget.size / 1.5,
      width: widget.widget.size * 2,
      color: Color(0xFFc2edcc),
      child: Center(
        child: TextButton(
            onPressed: () {
              setState(() {
                widget.state.selection = Selection.method;
                widget.state.isSelector = true;
              });
            },
            child: Text("Method")),
      ),
    );
  }
}

class LocationSelector extends StatefulWidget {
  const LocationSelector({Key? key, required this.widget, required this.state})
      : super(key: key);

  final SettingsButton widget;
  final _SettingsButtonState state;

  @override
  _LocationSelectorState createState() => _LocationSelectorState();
}

class _LocationSelectorState extends State<LocationSelector> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.widget.size / 1.5,
      width: widget.widget.size * 2,
      color: Color(0xFFc2edcc),
      child: Center(
        child: TextButton(
            onPressed: () {
              setState(() {
                widget.state.selection = Selection.location;
                widget.state.isSelector = true;
              });
            },
            child: Text("Location")),
      ),
    );
  }
}
