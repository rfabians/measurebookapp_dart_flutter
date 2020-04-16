import 'package:flutter/material.dart';
import 'package:measurebookapp/pages/importarPuntoOSCoor.dart';
import 'package:measurebookapp/pages/listadoPuntos.dart';
import 'package:measurebookapp/pages/mapaPuntosRefencia.dart';

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
                       padding: EdgeInsets.all(10.0),
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
                          TextSpan(text: 'Crea, elimina y visualiza los puntos de referencia que usaras dentro de tu proyecto', style: TextStyle(
                          fontFamily: 'Roboto', 
                          fontSize: 14.0,
                          color: Colors.black54,
                          )),
                        ]
                      )),
                      SizedBox(height: 15.0),
                      
                      Divider(height: 5.0,),
                      Container(
                        height: 450,
                        padding: EdgeInsets.all(5.0),
                        child: MediaQuery.removePadding(context: context,
                        removeTop: true,
                        child: ListView(
                        children: <Widget>[
                        ListTile(
                        leading: Icon(Icons.description, size: 50,color: Colors.blueGrey),
                        title: Text('Listado de Puntos',style: TextStyle(
                        fontFamily: 'Roboto', 
                        fontSize: 16.0,
                        color: Color(0xff007FFF),
                        )),
                        subtitle: Text('Visualiza y elimina el listado de tus puntos de referencia que se usaran en el proyecto'),
                        trailing: Icon(Icons.chevron_right, size: 30.0, color: Colors.blueAccent,),
                        onTap: (){
                        Navigator.push(context, MaterialPageRoute(
                        builder: (context) => ListadoPuntoRef(
                          idUsuario: widget.idUser,
                          idProyeccion: widget.idProyeccion,
                          proyeccion: widget.proyeccionMB,
                          nombreProyecto: widget.nombreProyecto,
                        )));
                        },
                        ),
                        Divider(),
                        ListTile(
                        leading: Image.asset('assets/images/nuevo.png', height: 45,),
                        title: Text('Crear Nuevo Punto',style: TextStyle(
                        fontFamily: 'Roboto', 
                        fontSize: 16.0,
                        color: Color(0xff007FFF),
                        )),
                        subtitle: Text('Crea nuevos puntos de referencia ingresando coordenadas y registro fotográfico'),
                        trailing: Icon(Icons.chevron_right, size: 30.0, color: Colors.blueAccent,),
                        onTap: (){
                        Navigator.push(context, MaterialPageRoute(
                        builder: (context) => PuntoNuevo(
                          idUserMB: widget.idUser,
                          nombreProyecto: widget.nombreProyecto,
                          id_sistemaCoor: widget.idProyeccion,
                          proyeccion: widget.proyeccionMB,
                        )));
                        },
                        ),
                        Divider(height: 5),
                        ListTile(
                        leading: Image.asset('assets/images/delta.png', height: 45),
                        title: Text('Importar Puntos de la Red Pasiva del IGAC',style: TextStyle(
                        fontFamily: 'Roboto', 
                        fontSize: 16.0,
                        color: Color(0xff007FFF),
                        )),
                        subtitle: Text('Usa dentro de tu proyecto Puntos de la Red Pasiva del IGAC'),
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
                        Divider(height: 5),
                        ListTile(
                        leading: Image.asset('assets/images/measure.png', height: 45,),
                        title: Text('Vizualizar en mapa todos los puntos',style: TextStyle(
                        fontFamily: 'Roboto', 
                        fontSize: 16.0,
                        color: Color(0xff007FFF),
                        )),
                        subtitle: Text('Genera un visor en el cual puedes ver la ubicación de tus puntos de referencia'),
                        trailing: Icon(Icons.chevron_right, size: 30.0, color: Colors.blueAccent,),
                        onTap: (){ 
                          Navigator.push(context, MaterialPageRoute(
                          builder: (context) => MapaPuntosReferencia(
                          idCoordenadas: widget.idProyeccion,
                          nombreProyecto: widget.nombreProyecto,
                          sistemaCoordenadas: widget.proyeccionMB,
                        )));
                        },
                        ),
                        Divider(height: 5),
                        ListTile(
                        leading: Image.asset('assets/images/conversion.png', height: 45),
                        title: Text('Importar Punto de otro sistema de Coordenadas',style: TextStyle(
                        fontFamily: 'Roboto', 
                        fontSize: 16.0,
                        color: Color(0xff007FFF),
                        )),
                        subtitle: Text('Crea puntos de referencia que se encuentran en otro sistema de Coordenadas'),
                        trailing: Icon(Icons.chevron_right, size: 30.0, color: Colors.blueAccent,),
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(
                          builder: (context) => ImportarPuntoOSCoor(
                              
                              idProyeccion: widget.idProyeccion,
                              idProyecto: widget.nombreProyecto,
                              idusuario: widget.idUser,
                              proyeccion: widget.proyeccionMB,
                        )));
                        },
                        ),
                        Divider(height: 5),
                      ],
                     )
                    ),
                    ),
                   ],
                 ),
               ),
             ),
           )),
    );
  }
}