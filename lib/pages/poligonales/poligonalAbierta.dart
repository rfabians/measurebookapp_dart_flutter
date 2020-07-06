import 'package:flutter/material.dart';

class PoligonalAbierta extends StatefulWidget {
  PoligonalAbierta({Key key}) : super(key: key);

  @override
  _PoligonalAbiertaState createState() => _PoligonalAbiertaState();
}

class _PoligonalAbiertaState extends State<PoligonalAbierta> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[Text('Poligonales Abiertas')],
          ),
        ),
      )),
    );
  }
}
