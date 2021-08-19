import 'package:flutter/material.dart';
import 'package:hijri_calculator/hijri_calculator.dart';

import 'body.dart';

class HijriDateContainer extends StatefulWidget {
  const HijriDateContainer({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final Body widget;

  @override
  _HijriDateState createState() => _HijriDateState();
}

class _HijriDateState extends State<HijriDateContainer> {
  late DateTime date;
  late String hijriDate;
  @override
  void initState() {
    date = DateTime.now();
    hijriDate =
        HijriCalculator().gregorianToHijri(date.year, date.month, date.day);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      height: (widget.widget.constraints.maxHeight / 18) * 1.5,
      width: (widget.widget.constraints.maxWidth / 343) * 280,
      decoration: BoxDecoration(
          color: Color(0xFF6fc881), borderRadius: BorderRadius.circular(10)),
      child: Container(
          decoration: BoxDecoration(
              color: Color(0xFF9deca6),
              borderRadius: BorderRadius.circular(10)),
          child: Center(child: Text(hijriDate))),
    );
  }
}
