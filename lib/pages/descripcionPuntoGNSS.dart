import 'package:flutter/material.dart';

class DescripcionPuntoGNSS extends StatefulWidget {
  DescripcionPuntoGNSS({Key key}) : super(key: key);

  @override
  _DescripcionPuntoGNSSState createState() => _DescripcionPuntoGNSSState();
}

class _DescripcionPuntoGNSSState extends State<DescripcionPuntoGNSS> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: SafeArea(
         child: Center(
           child: Text('DESCRIPCIÓN PUNTO'),
         )
         ),
    );
  }
}