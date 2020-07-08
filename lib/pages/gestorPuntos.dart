import 'package:flutter/material.dart';
import 'package:measurebookapp/main.dart';
import 'package:measurebookapp/modelos/proyectos.dart';
import 'package:measurebookapp/pages/alturasNiveladas.dart';
import 'package:measurebookapp/pages/importarPuntoOSCoor.dart';
import 'package:measurebookapp/pages/listadoPuntos.dart';
import 'package:measurebookapp/pages/mapaPuntosRefencia.dart';

import 'importarPuntosRedPasivaIGAC.dart';
import 'nuevoPunto.dart';

class GestosPuntos extends StatefulWidget {
  proyectos datosProyecto;
  GestosPuntos({
    Key key,
    this.datosProyecto,
  }) : super(key: key);

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
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Center(
                    child:
                        Image.asset('assets/images/puntos.png', height: 50.0),
                  ),
                ),
                RichText(
                    text: TextSpan(children: <TextSpan>[
                  TextSpan(
                      text: 'Gestor de Puntos MeasureBook, ',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 13.0,
                        color: Color(0xff007FFF),
                      )),
                  TextSpan(
                      text:
                          'Crea, elimina y visualiza los puntos de referencia que usarás dentro de tu proyecto',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 13.0,
                        color: Colors.black54,
                      )),
                ])),
                SizedBox(height: 15.0),
                Divider(
                  height: 5.0,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 5.0,
                            color: Colors.black38,
                            offset: Offset(0, 5))
                      ]),
                  height: 500,
                  padding: EdgeInsets.all(5.0),
                  child: MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      child: ListView(
                        children: <Widget>[
                          ListTile(
                            leading: Icon(Icons.description,
                                size: 45, color: Colors.blueGrey),
                            title: Text('Listado de Puntos',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 14.0,
                                  color: Color(0xff007FFF),
                                )),
                            subtitle: Text(
                                'Visualiza y elimina el listado de tus puntos de referencia que se usarán en el proyecto'),
                            trailing: Icon(
                              Icons.chevron_right,
                              size: 30.0,
                              color: Colors.blueAccent,
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ListadoPuntoRef(
                                            datosProyecto: widget.datosProyecto,
                                          )));
                            },
                          ),
                          Divider(),
                          ListTile(
                            leading: Image.asset(
                              'assets/images/nuevo.png',
                              height: 40,
                            ),
                            title: Text('Crear Nuevo Punto',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 14.0,
                                  color: Color(0xff007FFF),
                                )),
                            subtitle: Text(
                                'Crea nuevos puntos de referencia ingresando coordenadas y registro fotográfico'),
                            trailing: Icon(
                              Icons.chevron_right,
                              size: 30.0,
                              color: Colors.blueAccent,
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PuntoNuevo(
                                            datosProyecto: widget.datosProyecto,
                                          )));
                            },
                          ),
                          Divider(),
                          ListTile(
                            leading: Image.asset('assets/images/delta.png',
                                height: 40),
                            title: Text(
                                'Importar Puntos de la Red Pasiva del IGAC',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 14.0,
                                  color: Color(0xff007FFF),
                                )),
                            subtitle: Text(
                                'Usa dentro de tu proyecto Puntos de la Red Pasiva del IGAC (Coordenadas)'),
                            trailing: Icon(
                              Icons.chevron_right,
                              size: 30.0,
                              color: Colors.blueAccent,
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ImportPuntosRedPasivaIGAC(
                                            datosProyecto: widget.datosProyecto,
                                          )));
                            },
                          ),
                          Divider(),
                          ListTile(
                            leading: Image.asset(
                                'assets/images/nivelacion_.png',
                                height: 45),
                            title: Text(
                                'Importar Puntos de la Red Pasiva del IGAC',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 14.0,
                                  color: Color(0xff007FFF),
                                )),
                            subtitle: Text(
                                'Usa dentro de tu proyecto Puntos de la Red Pasiva del IGAC (Alturas Niveladas)'),
                            trailing: Icon(
                              Icons.chevron_right,
                              size: 30.0,
                              color: Colors.blueAccent,
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AlturaNiveladasMap(
                                            datosProyecto: widget.datosProyecto,
                                          )));
                            },
                          ),
                          Divider(),
                          ListTile(
                            leading: Image.asset(
                              'assets/images/measure.png',
                              height: 40,
                            ),
                            title:
                                Text('Visualizar en el mapa todos los puntos',
                                    style: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize: 14.0,
                                      color: Color(0xff007FFF),
                                    )),
                            subtitle: Text(
                                'Genera un visor en el cual puedes ver la ubicación de tus puntos de referencia'),
                            trailing: Icon(
                              Icons.chevron_right,
                              size: 30.0,
                              color: Colors.blueAccent,
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          MapaPuntosReferencia(
                                            datosProyecto: widget.datosProyecto,
                                          )));
                            },
                          ),
                          Divider(),
                          ListTile(
                            leading: Image.asset('assets/images/conversion.png',
                                height: 45),
                            title: Text(
                                'Importar Punto de otro Sistema de Coordenadas',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 14.0,
                                  color: Color(0xff007FFF),
                                )),
                            subtitle: Text(
                                'Crea puntos de referencia que se encuentran en otro Sistema de Coordenadas'),
                            trailing: Icon(
                              Icons.chevron_right,
                              size: 30.0,
                              color: Colors.blueAccent,
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ImportarPuntoOSCoor(
                                            datosProyecto: widget.datosProyecto,
                                          )));
                            },
                          ),
                          Divider(),
                          ListTile(
                            leading: Image.asset('assets/images/nuevo.png',
                                height: 45),
                            title: Text('Reporte de Puntos de Referencia',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 14.0,
                                  color: Color(0xff007FFF),
                                )),
                            subtitle: Text(
                                'Crea un reporte en PDF de los puntos de referencia que tienes dentro del Proyecto Actual'),
                            trailing: Icon(
                              Icons.chevron_right,
                              size: 30.0,
                              color: Colors.blueAccent,
                            ),
                            onTap: () {
                              /*
                          Navigator.push(context, MaterialPageRoute(
                          builder: (context) => ImportarPuntoOSCoor(
                              idProyeccion: widget.idProyeccion,
                              idProyecto: widget.nombreProyecto,
                              idusuario: widget.idUser,
                              proyeccion: widget.proyeccionMB,
                        )));*/
                            },
                          ),
                        ],
                      )),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
