import 'package:flutter/material.dart';
import 'package:measurebookapp/modelos/proyectos.dart';
import 'package:measurebookapp/pages/poligonales/poligonalesMain.dart';

import '../conversionCoordenadas.dart';
import '../gestorPuntos.dart';
import '../menuPrincipal.dart';
import '../nivelaciones.dart';
import 'hojaDeCampo.dart';
import 'observacionGNSSVertice.dart';

class MenuObservacionesGNSS extends StatefulWidget {
  final proyectos datosProyecto;
  MenuObservacionesGNSS({Key key, this.datosProyecto}) : super(key: key);

  @override
  _MenuObservacionesGNSSState createState() => _MenuObservacionesGNSSState();
}

class _MenuObservacionesGNSSState extends State<MenuObservacionesGNSS> {
  int _index = 0;
  @override
  Widget build(BuildContext context) {
    List<Widget> listNavegacion = [
      //Menu Principal
      FlatButton(
          onPressed: () {},
          child: ListTile(
            dense: true,
            leading: Image.asset('assets/images/measure.png'),
            title: Text(
              'Menu de Principal',
              style: TextStyle(fontSize: 14, color: Colors.blueAccent),
            ),
            subtitle: Text(
              'Navega el menu principal',
              style: TextStyle(fontSize: 12, color: Colors.black54),
            ),
            trailing: Icon(
              Icons.navigate_next,
              color: Colors.blueAccent,
              size: 50,
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MenuPrincipalMB(
                            datosProyecto: widget.datosProyecto,
                          )));
            },
          )),
      //Gestor de Puntos
      FlatButton(
          onPressed: () {},
          child: ListTile(
            dense: true,
            leading: Image.asset('assets/images/puntos.png'),
            title: Text(
              'Gestor de Puntos',
              style: TextStyle(fontSize: 14, color: Colors.blueAccent),
            ),
            subtitle: Text(
              'Navega al gestor de Puntos',
              style: TextStyle(fontSize: 12, color: Colors.black54),
            ),
            trailing: Icon(
              Icons.navigate_next,
              color: Colors.blueAccent,
              size: 50,
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => GestosPuntos(
                            datosProyecto: widget.datosProyecto,
                          )));
            },
          )),
      //Conversión de Coordenadas
      FlatButton(
          onPressed: () {},
          child: ListTile(
            dense: true,
            leading: Image.asset('assets/images/conversion.png'),
            title: Text(
              'Conversión Coordenadas',
              style: TextStyle(fontSize: 14, color: Colors.blueAccent),
            ),
            subtitle: Text(
              'Navega a la conversion de coordenadas',
              style: TextStyle(fontSize: 12, color: Colors.black54),
            ),
            trailing: Icon(
              Icons.navigate_next,
              color: Colors.blueAccent,
              size: 50,
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CoversionCoordenadas(
                            datosProyecto: widget.datosProyecto,
                          )));
            },
          )),
      //Tiempos de Rastreo
      FlatButton(
          onPressed: () {},
          child: ListTile(
            dense: true,
            leading: Image.asset('assets/images/gnss.png'),
            title: Text(
              'Tiempos de Rastreo',
              style: TextStyle(fontSize: 14, color: Colors.blueAccent),
            ),
            subtitle: Text(
              'Calcular tiempos de rastreo',
              style: TextStyle(fontSize: 12, color: Colors.black54),
            ),
            trailing: Icon(
              Icons.navigate_next,
              color: Colors.blueAccent,
              size: 50,
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ObservacionGNSSVertice()));
            },
          )),
      //Poligonales
      FlatButton(
          onPressed: () {},
          child: ListTile(
            dense: true,
            leading: Image.asset('assets/images/poligonal_.png'),
            title: Text(
              'Poligonales',
              style: TextStyle(fontSize: 14, color: Colors.blueAccent),
            ),
            subtitle: Text(
              'Navega al menu principal de Poligonales',
              style: TextStyle(fontSize: 12, color: Colors.black54),
            ),
            trailing: Icon(
              Icons.navigate_next,
              color: Colors.blueAccent,
              size: 50,
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PoligonalesMain(
                            datosProyecto: widget.datosProyecto,
                          )));
            },
          )),
      //Nivelaciones
      FlatButton(
          onPressed: () {},
          child: ListTile(
            dense: true,
            leading: Image.asset('assets/images/nivelacion_.png'),
            title: Text(
              'Nivelaciones',
              style: TextStyle(fontSize: 14, color: Colors.blueAccent),
            ),
            subtitle: Text(
              'Navega al menu principal de Nivelaciones',
              style: TextStyle(fontSize: 12, color: Colors.black54),
            ),
            trailing: Icon(
              Icons.navigate_next,
              color: Colors.blueAccent,
              size: 50,
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Nivelaciones(
                            datosproyecto: widget.datosProyecto,
                          )));
            },
          )),
    ];

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        hoverColor: Colors.blueAccent,
        child: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () => showModalBottomSheet(
                context: context,
                backgroundColor: Colors.transparent,
                builder: (BuildContext context) => Container(
                    height: 100,
                    decoration: BoxDecoration(color: Colors.transparent),
                    child: PageView.builder(
                        itemCount: listNavegacion.length,
                        controller: PageController(viewportFraction: 0.75),
                        onPageChanged: (int index) =>
                            setState(() => _index = index),
                        itemBuilder: (_, i) {
                          return Transform.scale(
                              scale: 0.9,
                              child: Card(
                                elevation: 6,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: listNavegacion[i]),
                              ));
                        })))),
        mini: true,
        onPressed: () {
          print('Boton Navegación');
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: this._barraNavegacionMB(context),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Image.asset(
                    'assets/images/gnss.png',
                    height: 80,
                  ),
                  Divider(),
                  Text('Menu principal observaciones GNSS',
                      style: TextStyle(color: Colors.blueAccent, fontSize: 16)),
                  Divider(),
                  SizedBox(height: 10),
                  Divider(),
                  //Calcular Tiempos de Rastreo
                  ListTile(
                    leading: Image.asset(
                      'assets/images/gnss.png',
                      height: 50,
                    ),
                    title: Text('Cálcular Tiempos de Rastreo',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 13.0,
                          color: Color(0xff007FFF),
                        )),
                    subtitle: Text(
                        'Determina los tiempos de observaciones necesarios, usando las estaciones MAGNA ECO o GEORED',
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
                              builder: (context) => ObservacionGNSSVertice(
                                    datosProyecto: widget.datosProyecto,
                                  )));
                    },
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(
                      Icons.assignment,
                      size: 50,
                      color: Colors.blueAccent,
                    ),
                    title: Text('Crear Hoja de Campo',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 13.0,
                          color: Color(0xff007FFF),
                        )),
                    subtitle: Text(
                        'Crea una hoja de campo con los datos de las observaciones GNSS que estás realizando',
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
                              builder: (context) => HojaDeCampoGNSS(
                                    datosProyecto: widget.datosProyecto,
                                  )));
                    },
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(
                      Icons.assignment,
                      size: 50,
                      color: Colors.blueAccent,
                    ),
                    title: Text('Crear Formato de Ocupación de Punto',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 13.0,
                          color: Color(0xff007FFF),
                        )),
                    subtitle:
                        Text('Genera el formato de Ocupación de un punto GNSS',
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
                              builder: (context) => ObservacionGNSSVertice(
                                    datosProyecto: widget.datosProyecto,
                                  )));
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  BottomAppBar _barraNavegacionMB(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      color: Colors.black87,
      child: Row(
        children: <Widget>[
          Container(
            height: 40,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text('      Menu Principal Observaciones GNSS',
                  style: TextStyle(fontSize: 12, color: Colors.white)),
            ),
          )
        ],
      ),
    );
  }
}
