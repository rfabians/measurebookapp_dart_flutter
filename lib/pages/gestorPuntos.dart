import 'package:flutter/material.dart';

import 'importarPuntosRedPasivaIGAC.dart';
import 'nuevoPunto.dart';

class GestosPuntos extends StatefulWidget {
  final String nombreProyecto, proyeccionMB, idUser, idProyeccion;
  GestosPuntos({Key key, this.nombreProyecto, this.proyeccionMB, this.idUser, this.idProyeccion}) : super(key: key);

  @override
  _GestosPuntosState createState() => _GestosPuntosState();
}

class _GestosPuntosState extends State<GestosPuntos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
         body: SafeArea(
           child: Container(
             child: SingleChildScrollView(
               child: Padding(
                 padding: const EdgeInsets.all(15.0),
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.start,
                   children: <Widget>[
                     SizedBox(height: 5.0),
                     Padding(
                       padding: EdgeInsets.all(20.0),
                       child: Center(
                         child: Image.asset('assets/images/puntos.png',height: 80.0),),
                     ),
                       RichText(text: TextSpan(
                        children: <TextSpan> [
                          TextSpan(text: 'Gestor de Puntos MeasureBook, ', style: TextStyle(
                          fontFamily: 'Roboto', 
                          fontSize: 16.0,
                          color: Color(0xff007FFF),
                          )),
                          TextSpan(text: 'Crea, elimina y visualiza los puntos de referencia que usaras dentro de tu proyecto ', style: TextStyle(
                          fontFamily: 'Roboto', 
                          fontSize: 16.0,
                          color: Colors.black54,
                          )),
                        ]
                      )),
                      SizedBox(height: 30.0),
                      Container(
                        height: 450,
                        padding: EdgeInsets.all(5.0),
                        child: MediaQuery.removePadding(context: context,
                        removeTop: true,
                        child: ListView(
                        children: <Widget>[
                        ListTile(
                        leading: Image.asset('assets/images/nuevo.png'),
                        title: Text('Crear Nuevo Punto',style: TextStyle(
                        fontFamily: 'Roboto', 
                        fontSize: 16.0,
                        color: Color(0xff007FFF),
                        )),
                        subtitle: Text('Ingresa las coordeandas, descripción y registro fotográfico de los puntos que utilizaras en este proyecto'),
                        trailing: Icon(Icons.chevron_right, size: 30.0, color: Colors.blueAccent,),
                        onTap: (){
                        Navigator.push(context, MaterialPageRoute(
                        builder: (context) => PuntoNuevo(
                          idUserMB: widget.idUser,
                          nombreProyecto: widget.nombreProyecto,
                        )));
                        },
                        ),
                        Divider(height: 20),
                        ListTile(
                        leading: Image.asset('assets/images/delta.png'),
                        title: Text('Importar Puntos de la Red Pasiva del IGAC',style: TextStyle(
                        fontFamily: 'Roboto', 
                        fontSize: 16.0,
                        color: Color(0xff007FFF),
                        )),
                        subtitle: Text('Ingresa las coordeandas, descripción y registro fotográfico de los puntos que utilizaras en este proyecto'),
                        trailing: Icon(Icons.chevron_right, size: 30.0, color: Colors.blueAccent,),
                        onTap: (){
                        Navigator.push(context, MaterialPageRoute(
                        builder: (context) => ImportPuntosRedPasivaIGAC(
                          idProyeccion: widget.idProyeccion,
                          idProyecto: widget.nombreProyecto,
                          idusuario: widget.idProyeccion,
                          proyeccion: widget.proyeccionMB,
                        )));
                        },
                        ),
                        Divider(height: 20),
                        ListTile(
                        leading: Image.asset('assets/images/measure.png'),
                        title: Text('Vizualizar en mapa todos los puntos',style: TextStyle(
                        fontFamily: 'Roboto', 
                        fontSize: 16.0,
                        color: Color(0xff007FFF),
                        )),
                        subtitle: Text('Ingresa las coordeandas, descripción y registro fotográfico de los puntos que utilizaras en este proyecto'),
                        trailing: Icon(Icons.chevron_right, size: 30.0, color: Colors.blueAccent,),
                        onTap: (){

                        },
                        ),
                        Divider(height: 20),
                        ListTile(
                        leading: Image.asset('assets/images/conversion.png'),
                        title: Text('Importar Punto de otro sistema de Coordenadas',style: TextStyle(
                        fontFamily: 'Roboto', 
                        fontSize: 16.0,
                        color: Color(0xff007FFF),
                        )),
                        subtitle: Text('Ingresa las coordeandas, descripción y registro fotográfico de los puntos que utilizaras en este proyecto'),
                        trailing: Icon(Icons.chevron_right, size: 30.0, color: Colors.blueAccent,),
                        onTap: (){},
                        ),
                        Divider(height: 20),
                      ],
                      
                     )
                    ),
                    ),
                    FlatButton(
                    shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                    child: Text('Eliminar Puntos', style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 14.0,
                    color: Colors.white,
                    ),),
                    color: Color(0xff007FFF),
                    onPressed: (){
                    }),
                   ],
                 ),
               ),
             ),
           )),
    );
  }
}