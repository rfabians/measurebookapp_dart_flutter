import 'package:flutter/material.dart';

class RastreoRedPasiva extends StatefulWidget {
  RastreoRedPasiva({Key key}) : super(key: key);

  @override
  _RastreoRedPasivaState createState() => _RastreoRedPasivaState();
}

class _RastreoRedPasivaState extends State<RastreoRedPasiva> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: SafeArea(
         child: Center(
           child: Text('RED PASIVA TIEMPOS RASTREO'),
         )
         ),
    );
  }
}