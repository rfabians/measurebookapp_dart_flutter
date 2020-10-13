import 'package:flutter/material.dart';
import 'package:measurebookapp/modelos/proyectos.dart';
import 'package:measurebookapp/pages/conversionCoordenadas.dart';
import 'package:measurebookapp/pages/nivelaciones.dart';
import 'package:measurebookapp/pages/observacionesGNSS.dart';
import 'package:measurebookapp/pages/observacionesGNSS/observacionGNSSVertice.dart';
import 'package:measurebookapp/pages/poligonales/poligonalesMain.dart';
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
                            title: Text('Gestor de Puntos',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 13.0,
                                  color: Color(0xff007FFF),
                                )),
                            subtitle: Text(
                                'Crea y edita los puntos que utilizarás como control en tus mediciones',
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
                                      builder: (context) => GestosPuntos(
                                            datosProyecto: widget.datosProyecto,
                                          )));
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
                          Divider(),
                          ListTile(
                            leading: Image.asset(
                              'assets/images/gnss.png',
                              height: 50,
                            ),
                            title: Text('Observaciones GNSS',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 13.0,
                                  color: Color(0xff007FFF),
                                )),
                            subtitle: Text('Documenta tus observaciones GNSS',
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
                                          MenuObservacionesGNSS(
                                            datosProyecto: widget.datosProyecto,
                                          )));
                            },
                          ),
                          Divider(),
                          ListTile(
                            leading: Image.asset(
                              'assets/images/poligonal_.png',
                              height: 50,
                            ),
                            title: Text('Poligonales',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 13.0,
                                  color: Color(0xff007FFF),
                                )),
                            subtitle: Text(
                                'Crea, continúa y gestiona tus Poligonales',
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
                                      builder: (context) => PoligonalesMain(
                                            datosProyecto: widget.datosProyecto,
                                          )));
                            },
                          ),
                          Divider(),
                          ListTile(
                            leading: Image.asset(
                              'assets/images/nivelacion_.png',
                              height: 50,
                            ),
                            title: Text('Nivelaciones',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 13.0,
                                  color: Color(0xff007FFF),
                                )),
                            subtitle: Text(
                                'Crea, continúa y gestiona tus Nivelaciones Geométricas',
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
                                      builder: (context) => Nivelaciones(
                                            datosproyecto: widget.datosProyecto,
                                          )));
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
