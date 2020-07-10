import 'package:flutter/material.dart';
import 'package:measurebookapp/main.dart';
import 'package:measurebookapp/modelos/proyectos.dart';
import 'package:measurebookapp/pages/alturasNiveladas.dart';
import 'package:measurebookapp/pages/conversionCoordenadas.dart';
import 'package:measurebookapp/pages/importarPuntoOSCoor.dart';
import 'package:measurebookapp/pages/listadoPuntos.dart';
import 'package:measurebookapp/pages/mapaPuntosRefencia.dart';
import 'package:measurebookapp/pages/menuPrincipal.dart';
import 'package:measurebookapp/pages/nivelaciones.dart';
import 'package:measurebookapp/pages/observacionesGNSS/observacionGNSSVertice.dart';
import 'package:measurebookapp/pages/poligonales/poligonalesMain.dart';
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
              child: Text('      Gestor de Puntos',
                  style: TextStyle(fontSize: 12, color: Colors.white)),
            ),
          )
        ],
      ),
    );
  }
}
