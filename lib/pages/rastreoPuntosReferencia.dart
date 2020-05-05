import 'package:flutter/material.dart';

class RastreoPuntosReferencia extends StatefulWidget {
  RastreoPuntosReferencia({Key key}) : super(key: key);

  @override
  _RastreoPuntosReferenciaState createState() => _RastreoPuntosReferenciaState();
}

class _RastreoPuntosReferenciaState extends State<RastreoPuntosReferencia> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: SafeArea(
         child: Center(
           child: Text('PUNTOS DE REFERENCIA TIEMPOS RASTREO'),
         )
         ),
    );
  }
}