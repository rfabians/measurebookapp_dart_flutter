 import 'package:flutter/material.dart';

 class CoversionCoordenadas extends StatelessWidget {
   final String nombreProyecto, proyeccionMB, idUser, idProyeccion;
   const CoversionCoordenadas({Key key, this.nombreProyecto, this.proyeccionMB, this.idUser, this.idProyeccion}) : super(key: key);
 
   @override
   Widget build(BuildContext context) {
     return Scaffold(
       body: SafeArea(
         child:  Padding(
           padding: const EdgeInsets.all(18.0),
           child: Center(
             child: Column(
               children: <Widget>[
                 Image.asset('assets/images/conversion.png',height: 80.0),
                 SizedBox(height: 10),
                 RichText(text: TextSpan(
                  children: <TextSpan> [
                    TextSpan(text: 'Conversion de coordenadas ', style: TextStyle(
                    fontFamily: 'Roboto', 
                    fontSize: 13.0,
                    color: Color(0xff007FFF),
                    )),
                    TextSpan(text: 'Convierte tus coordenadas entre los sistemas de coordenadas Elipsoidales, Geocentricas, Gauss Krüger o Planas Cartesianas', style: TextStyle(
                    fontFamily: 'Roboto', 
                    fontSize: 13.0,
                    color: Colors.black54,
                    )),
                  ]
                )),
               ],
             ),
           ),
         ),
       ),
     );
   }
 }