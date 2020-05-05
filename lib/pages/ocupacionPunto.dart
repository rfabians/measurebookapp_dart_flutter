import 'package:flutter/material.dart';

class OcupacionPunto extends StatefulWidget {
  OcupacionPunto({Key key}) : super(key: key);

  @override
  _OcupacionPuntoState createState() => _OcupacionPuntoState();
}

class _OcupacionPuntoState extends State<OcupacionPunto> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: SafeArea(
         child: Center(
           child: Text('OCUPACIÓN PUNTO'),
         )
         ),
    );
  }
}