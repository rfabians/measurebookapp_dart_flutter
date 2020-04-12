import 'package:flutter/material.dart';

class ConversionPunto extends StatefulWidget {
  final String idusuario, idProyeccion, idProyecto, proyeccion, sistemaOrigen; 
  ConversionPunto({Key key, this.idProyeccion, this.idProyecto, this.idusuario, this.proyeccion, this.sistemaOrigen}) : super(key: key);

  @override
  _ConversionPuntoState createState() => _ConversionPuntoState();
}

class _ConversionPuntoState extends State<ConversionPunto> {
  @override
  Widget build(BuildContext context) {
    if (widget.sistemaOrigen == 'Coordenadas Elipsoidales') {

      if (widget.proyeccion == 'Plano Cartesiano') {
        return Scaffold(
          body: SafeArea(child:Center(
            child: Column(
              children: <Widget>[
                Text('Coordenadas Elispoidales'),
                Text('Plano Cartesiano')
              ],
            ),
          )),
        );}
        else {
          return Scaffold(
          body: SafeArea(child:Center(
            child: Column(
              children: <Widget>[
                Text('Coordenadas Elispoidales'),
                Text('Gauss Krüger')
              ],
            ),
          )),
        );
        }
    } else if(widget.sistemaOrigen == 'Coordenadas Geocentricas'){
      if (widget.proyeccion == 'Plano Cartesiano') {
        return Scaffold(
          body: SafeArea(child:Center(
            child: Column(
              children: <Widget>[
                Text('Coordenadas Geocentricas'),
                Text('Plano Cartesiano')
              ],
            ),
          )),
        );}
        else {
          return Scaffold(
          body: SafeArea(child:Center(
            child: Column(
              children: <Widget>[
                Text('Coordenadas Geocentricas'),
                Text('Gauss Krüger')
              ],
            ),
          )),
        );
        }
    } else if(widget.sistemaOrigen == 'Coordenadas Gauss - Krüger'){
      if (widget.proyeccion == 'Plano Cartesiano') {
        return Scaffold(
          body: SafeArea(child:Center(
            child: Column(
              children: <Widget>[
                Text('Coordenadas Gauss - Krüger'),
                Text('Plano Cartesiano')
              ],
            ),
          )),
        );}
        else {
          return Scaffold(
          body: SafeArea(child:Center(
            child: Column(
              children: <Widget>[
                Text('Coordenadas Gauss - Krüger'),
                Text('Gauss Krüger')
              ],
            ),
          )),
        );
        }
  } else {
    if (widget.proyeccion == 'Plano Cartesiano') {
        return Scaffold(
          body: SafeArea(child:Center(
            child: Column(
              children: <Widget>[
                Text('Plano Cartesiano'),
                Text('Plano Cartesiano')
              ],
            ),
          )),
        );}
        else {
          return Scaffold(
          body: SafeArea(child:Center(
            child: Column(
              children: <Widget>[
                Text('Plano Cartesiano'),
                Text('Gauss Krüger')
              ],
            ),
          )),
        );
        }
  }
  }
}