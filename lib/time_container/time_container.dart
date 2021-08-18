import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TimeContainer extends StatefulWidget {
  final double height;
  final String timeName;

  final String time;
  final bool soundOn;
  const TimeContainer(
      {required this.height,
      required this.time,
      required this.timeName,
      required this.soundOn,
      Key? key})
      : super(key: key);

  @override
  _TimeContainerState createState() => _TimeContainerState();
}

class _TimeContainerState extends State<TimeContainer> {
  late double height;
  late double width;
  @override
  void initState() {
    height = (widget.height / 591) * 160;
    width = (widget.height / 591) * 160;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    height = (widget.height / 591) * 130;
    width = (widget.height / 591) * 130;
    return SizedBox(
      height: height,
      width: width,
      child: Stack(
        children: [
          SvgPicture.asset(
            'assets/icons/time_container.svg',
            cacheColorFilter: false,
            height: height,
            width: width,
          ),
          Center(
            child: Image.asset(
              widget.soundOn
                  ? 'assets/icons/sound_on_icon.png'
                  : 'assets/icons/sound_off_icon.png',
              height: (height / 160) * 50,
            ),
          ),
          Align(
            alignment: Alignment(0, -0.6),
            child: Text(
              widget.timeName,
              style: TextStyle(fontSize: (height / 160) * 20),
            ),
          ),
          Align(
            alignment: Alignment(0, .6),
            child: Text(
              widget.time,
              style: TextStyle(fontSize: (height / 160) * 20),
            ),
          )
        ],
      ),
    );
  }
}
