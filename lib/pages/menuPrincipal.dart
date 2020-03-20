import 'package:flutter/material.dart';

class MenuPrincipalMB extends StatefulWidget {

final String nombreProyectoMB,ubicacionMB, clienteMB, empresaMB, proyeccionMB, decripcionMB, id_usuario;
final int id_proyeccion;

MenuPrincipalMB({Key key, this.id_usuario, this.nombreProyectoMB, this.proyeccionMB,
this.id_proyeccion, this.ubicacionMB, this.empresaMB, this.clienteMB, this.decripcionMB}) : super (key: key);

  @override
  _MenuPrincipalMBState createState() => _MenuPrincipalMBState();
  }

class _MenuPrincipalMBState extends State<MenuPrincipalMB> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Column(
         children: <Widget>[
           Text(widget.id_usuario),
           Text(widget.nombreProyectoMB),
           Text(widget.proyeccionMB),
           Text(widget.id_proyeccion.toString()),
           Text(widget.ubicacionMB),
           Text(widget.empresaMB),
           Text(widget.clienteMB),
           Text(widget.decripcionMB),
         ],
       ),
    );
  }
}