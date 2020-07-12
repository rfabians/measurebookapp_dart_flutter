import 'package:flutter/material.dart';
import 'package:measurebookapp/modelos/poligonal.dart';
import 'package:measurebookapp/modelos/proyectos.dart';
import 'package:measurebookapp/pages/conversionCoordenadas.dart';
import 'package:measurebookapp/pages/gestorPuntos.dart';
import 'package:measurebookapp/pages/menuPrincipal.dart';
import 'package:measurebookapp/pages/nivelaciones.dart';
import 'package:measurebookapp/pages/observacionesGNSS/observacionGNSSVertice.dart';
import 'package:measurebookapp/pages/poligonales/poligonalesMain.dart';

class DetallePoligonalCerrada extends StatefulWidget {
  final proyectos datosProyecto;
  final Poligonal datosPoligonal;
  DetallePoligonalCerrada({Key key, this.datosProyecto, this.datosPoligonal})
      : super(key: key);

  @override
  _DetallePoligonalCerradaState createState() =>
      _DetallePoligonalCerradaState();
}

class _DetallePoligonalCerradaState extends State<DetallePoligonalCerrada> {
  @override
  Widget build(BuildContext context) {
    int _index = 0;
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
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  width: 70,
                  height: 70,
                  child: Image.asset('assets/images/poligonal_.png'),
                ),
                SizedBox(width: 20),
                Container(
                  width: 200,
                  height: 80,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 10),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: RichText(
                            textAlign: TextAlign.left,
                            text: TextSpan(children: <TextSpan>[
                              TextSpan(
                                  text: 'Poligonal: ',
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 12.0,
                                    color: Color(0xff007FFF),
                                  )),
                              TextSpan(
                                  text:
                                      '${widget.datosPoligonal.nombrePoligonal}',
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 12.0,
                                    color: Colors.black54,
                                  )),
                            ])),
                      ),
                      Divider(
                        height: 5,
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: RichText(
                            textAlign: TextAlign.left,
                            text: TextSpan(children: <TextSpan>[
                              TextSpan(
                                  text: 'Punto de Referencia I: ',
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 12.0,
                                    color: Color(0xff007FFF),
                                  )),
                              TextSpan(
                                  text:
                                      '${widget.datosPoligonal.nomPArmadoIni}',
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 12.0,
                                    color: Colors.black54,
                                  )),
                            ])),
                      ),
                      Divider(
                        height: 3,
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: RichText(
                            textAlign: TextAlign.left,
                            text: TextSpan(children: <TextSpan>[
                              TextSpan(
                                  text: 'Punto de Referencia II: ',
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 12.0,
                                    color: Color(0xff007FFF),
                                  )),
                              TextSpan(
                                  text:
                                      '${widget.datosPoligonal.nomPVIsadoIni}',
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 12.0,
                                    color: Colors.black54,
                                  )),
                            ])),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              height: 400,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 5.0,
                      spreadRadius: 5.0,
                      color: Colors.black12,
                    )
                  ]),
            )
          ],
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
              child: Text(
                  '      Poligonal ${widget.datosPoligonal.nombrePoligonal}',
                  style: TextStyle(fontSize: 12, color: Colors.white)),
            ),
          )
        ],
      ),
    );
  }
}
