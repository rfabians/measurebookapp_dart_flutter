import 'package:flutter/material.dart';

class SeleccionSistemaCoordendas  extends StatefulWidget {
final String nombreProyectoMB,ubicacionMB, clienteMB, empresaMB, proyeccionMB, decripcionMB;
final bool gauss;
SeleccionSistemaCoordendas({Key key, this.nombreProyectoMB, this.ubicacionMB, this.decripcionMB, this.clienteMB, this.empresaMB, this.proyeccionMB, this.gauss}) : super (key: key);

  @override
  _SeleccionSistemaCoordendasState createState() => _SeleccionSistemaCoordendasState();

}

bool _gauss;

class _SeleccionSistemaCoordendasState extends State<SeleccionSistemaCoordendas> {

  discriminadorProyeccion() {
String proyeccion = widget.proyeccionMB;
if(proyeccion == 'Gauss'){
_gauss = true;
}else {
_gauss= false;
}
return _gauss;
  }
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.white,
body: Center(
  child: SingleChildScrollView(
    child: widget.gauss
    ? Center(
child: Text('gauss'),
    )
    )
  )

),
      
    );
  }
}