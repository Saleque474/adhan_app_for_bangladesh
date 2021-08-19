import 'package:azhan_app/home/body.dart';
import 'package:flutter/material.dart';

class CountDown extends StatelessWidget {
  const CountDown({
    Key? key,
    required this.widget,
    required this.text,
  }) : super(key: key);

  final Body widget;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      height: (widget.constraints.maxHeight / 18) * 1.5,
      width: (widget.constraints.maxWidth / 343) * 280,
      decoration: BoxDecoration(
          color: Color(0xFF6fc881), borderRadius: BorderRadius.circular(10)),
      child: Container(
          decoration: BoxDecoration(
              color: Color(0xFF9deca6),
              borderRadius: BorderRadius.circular(10)),
          child: Center(child: Text(text))),
    );
  }
}
