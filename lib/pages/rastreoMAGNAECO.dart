import 'package:flutter/material.dart';

class RastreoRedMAGNAECO extends StatefulWidget {
  RastreoRedMAGNAECO({Key key}) : super(key: key);

  @override
  _RastreoRedMAGNAECOState createState() => _RastreoRedMAGNAECOState();
}

class _RastreoRedMAGNAECOState extends State<RastreoRedMAGNAECO> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: SafeArea(
         child: Center(
           child: Text('RED MAGNA ECO TIEMPOS RASTREO'),
         )
         ),
    );
  }
}