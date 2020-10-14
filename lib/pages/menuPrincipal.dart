import 'package:flutter/material.dart';
import 'package:measurebookapp/modelos/proyectos.dart';
import 'package:measurebookapp/pages/alturasNiveladas.dart';
import 'package:measurebookapp/pages/conversionCoordenadas.dart';
import 'package:measurebookapp/pages/nivelaciones.dart';
import 'package:measurebookapp/pages/observacionesGNSS.dart';
import 'package:measurebookapp/pages/observacionesGNSS/observacionGNSSVertice.dart';
import 'package:measurebookapp/pages/poligonales/poligonalesMain.dart';
import 'package:measurebookapp/pages/redPasivaIGAC.dart';
import 'gestorPuntos.dart';
import 'observacionesGNSS/menuObservacionesGNSS.dart';

class MenuPrincipalMB extends StatefulWidget {
  proyectos datosProyecto = proyectos();
  MenuPrincipalMB({
    Key key,
    this.datosProyecto,
  }) : super(key: key);

  @override
  _MenuPrincipalMBState createState() => _MenuPrincipalMBState();
}

class _MenuPrincipalMBState extends State<MenuPrincipalMB> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                SizedBox(height: 15.0),
                Center(
                  child: Image.asset(
                    'assets/images/measure.png',
                    height: 50.0,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                RichText(
                    text: TextSpan(children: <TextSpan>[
                  TextSpan(
                      text: 'Selecciona ',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 12.0,
                        color: Color(0xff007FFF),
                      )),
                  TextSpan(
                      text: 'el tipo de Actividad que deseas realizar ',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 12.0,
                        color: Colors.black54,
                      )),
                ])),
                SizedBox(height: 30),
                //Gestor de Puntos
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.all(10.0),
                  height: 500,
                  child: MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      child: ListView(
                        children: <Widget>[
                          ListTile(
                            leading: Image.asset(
                              'assets/images/puntos.png',
                              height: 50,
                            ),
                            title: Text('Red Pasiva IGAC',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 13.0,
                                  color: Color(0xff007FFF),
                                )),
                            subtitle: Text('Navega la Red Pasiva del IGAC',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 12.0,
                                  color: Colors.black54,
                                )),
                            trailing: Icon(
                              Icons.chevron_right,
                              size: 30.0,
                              color: Colors.blueAccent,
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RedPasivaIgac()));
                            },
                          ),
                          Divider(),
                          ListTile(
                            leading: Image.asset(
                              'assets/images/conversion.png',
                              height: 50,
                            ),
                            title: Text('Conversión de Coordenadas',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 13.0,
                                  color: Color(0xff007FFF),
                                )),
                            subtitle: Text(
                                'Importa y convierte coordenadas en otros sistemas diferentes al de tu proyecto',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 12.0,
                                  color: Colors.black54,
                                )),
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
                                          CoversionCoordenadas(
                                            datosProyecto: widget.datosProyecto,
                                          )));
                            },
                          ),
                          Divider(
                            height: 30,
                          ),
                          ListTile(
                            leading: Image.asset(
                              'assets/images/gnss.png',
                              height: 50,
                            ),
                            title: Text('Cálcular tiempos de Rastreo',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 13.0,
                                  color: Color(0xff007FFF),
                                )),
                            subtitle: Text(
                                'Cálcula los tiempos de rastres GNSS usandos las Estaciones de Rastreo Continuo',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 12.0,
                                  color: Colors.black54,
                                )),
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
                                          ObservacionGNSSVertice()));
                            },
                          ),
                          Divider(
                            height: 30,
                          ),
                          ListTile(
                            leading: Image.asset(
                              'assets/images/nivelacion_.png',
                              height: 50,
                            ),
                            title: Text('Alturas Niveladas',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 13.0,
                                  color: Color(0xff007FFF),
                                )),
                            subtitle: Text(
                                'Navega los puntos con alturas Niveladas de la red Pasiva del IGAC',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 12.0,
                                  color: Colors.black54,
                                )),
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
                                          AlturaNiveladasMap()));
                            },
                          )
                        ],
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
