import 'package:flutter/material.dart';

class Kiblah extends StatefulWidget {
  const Kiblah({Key? key}) : super(key: key);

  @override
  _KiblahState createState() => _KiblahState();
}

class _KiblahState extends State<Kiblah> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF4f955e),
        title: Text(" Kiblah"),
      ),
    );
  }
}
