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
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
          children: <Widget>[
            SizedBox(height: 75.0),
            Center(
              child: Image.asset('assets/images/measure.png', height: 80.0,),
            ),
            RichText(text: TextSpan(
              children: <TextSpa
            ))
          ],
        ),
        ),
      ),
    );
  }
}