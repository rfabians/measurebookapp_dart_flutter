import 'package:flutter/material.dart';
import 'package:measurebookapp/clases/database.dart';
import 'package:measurebookapp/modelos/poligonal.dart';
import 'package:measurebookapp/modelos/proyectos.dart';
import 'package:measurebookapp/pages/conversionCoordenadas.dart';
import 'package:measurebookapp/pages/gestorPuntos.dart';
import 'package:measurebookapp/pages/menuPrincipal.dart';
import 'package:measurebookapp/pages/nivelaciones.dart';
import 'package:measurebookapp/pages/observacionesGNSS/observacionGNSSVertice.dart';
import 'package:measurebookapp/pages/poligonales/detallePoligonalCerrada.dart';
import 'package:measurebookapp/pages/poligonales/poligonalAbierta.dart';
import 'package:measurebookapp/pages/poligonales/poligonalCerrada.dart';

class PoligonalesMain extends StatefulWidget {
  final proyectos datosProyecto;
  PoligonalesMain({Key key, this.datosProyecto}) : super(key: key);

  @override
  _PoligonalesMainState createState() => _PoligonalesMainState();
}

class _PoligonalesMainState extends State<PoligonalesMain> {
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
          child: SingleChildScrollView(
            child: Container(
                child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Center(
                        child: Column(children: <Widget>[
                      Image.asset('assets/images/poligonal_.png', height: 70),
                      RichText(
                          text: TextSpan(children: <TextSpan>[
                        TextSpan(
                            text: 'Almacena y Cálcula',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 12.0,
                              color: Color(0xff007FFF),
                            )),
                        TextSpan(
                            text: ' tus poligonales abiertas y cerradas ',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 12.0,
                              color: Colors.black54,
                            )),
                      ])),
                      Divider(
                        height: 3,
                      ),
                      Divider(height: 20),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(blurRadius: 3.0, color: Colors.black12)
                            ]),
                        height: 400,
                        width: MediaQuery.of(context).size.width,
                        child: FutureBuilder(
                            future: gestorMBDatabase.db.getPoligonales(
                                widget.datosProyecto.ID_USUARIO,
                                widget.datosProyecto.Nombre_Proyecto),
                            builder: (BuildContext context,
                                AsyncSnapshot<List<Poligonal>> snapshot) {
                              if (snapshot.hasData) {
                                if (snapshot.data.length <= 0) {
                                  return Center(
                                    child: Text(
                                        'Aun no tienes Poligonales Creadas'),
                                  );
                                } else {
                                  return Container(
                                    child: ListView.builder(
                                        itemCount: snapshot.data.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          Poligonal listaPoligonales =
                                              snapshot.data[index];
                                          return Padding(
                                            padding: EdgeInsets.only(
                                                bottom: 3,
                                                top: 3,
                                                left: 15,
                                                right: 15),
                                            child: Container(
                                              child: Material(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Colors.white,
                                                elevation: 5,
                                                child: ListTile(
                                                  leading: Icon(
                                                    Icons.timeline,
                                                    size: 40,
                                                    color: Colors.black54,
                                                  ),
                                                  title: RichText(
                                                      text: TextSpan(children: <
                                                          TextSpan>[
                                                    TextSpan(
                                                        text:
                                                            'Nombre Poligonal: ',
                                                        style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          fontSize: 12.0,
                                                          color:
                                                              Color(0xff007FFF),
                                                        )),
                                                    TextSpan(
                                                        text:
                                                            '${listaPoligonales.nombrePoligonal}',
                                                        style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          fontSize: 12.0,
                                                          color: Colors.black54,
                                                        )),
                                                  ])),
                                                  subtitle: RichText(
                                                      text: TextSpan(children: <
                                                          TextSpan>[
                                                    TextSpan(
                                                        text:
                                                            'Tipo de Poligonal: ',
                                                        style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          fontSize: 12.0,
                                                          color:
                                                              Color(0xff007FFF),
                                                        )),
                                                    TextSpan(
                                                        text:
                                                            '${listaPoligonales.tipoPoligonal}\n',
                                                        style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          fontSize: 12.0,
                                                          color: Colors.black54,
                                                        )),
                                                  ])),
                                                  trailing: Icon(
                                                    Icons.navigate_next,
                                                    size: 40,
                                                    color: Colors.black,
                                                  ),
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                DetallePoligonalCerrada(
                                                                  datosPoligonal:
                                                                      listaPoligonales,
                                                                  datosProyecto:
                                                                      widget
                                                                          .datosProyecto,
                                                                )));
                                                  },
                                                ),
                                              ),
                                            ),
                                          );
                                        }),
                                  );
                                }
                              } else {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            }),
                      ),
                      SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          FlatButton(
                              shape: new RoundedRectangleBorder(
                                  borderRadius:
                                      new BorderRadius.circular(20.0)),
                              child: Text(
                                'Nueva Poligonal Cerrada',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 12.0,
                                  color: Colors.white,
                                ),
                              ),
                              color: Color(0xff007FFF),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PoligonalCerrada(
                                              datosProyecto:
                                                  widget.datosProyecto,
                                            )));
                              }),
                          SizedBox(width: 30.0),
                          FlatButton(
                              shape: new RoundedRectangleBorder(
                                  borderRadius:
                                      new BorderRadius.circular(20.0)),
                              child: Text(
                                'Nueva Poligonal Abierta',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 12.0,
                                  color: Colors.white,
                                ),
                              ),
                              color: Color(0xff007FFF),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            PoligonalAbierta()));
                              }),
                        ],
                      ),
                      FlatButton(
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(20.0)),
                          child: Text(
                            'Eliminar Poligonal',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 12.0,
                              color: Colors.white,
                            ),
                          ),
                          color: Color(0xff007FFF),
                          onPressed: () {}),
                    ])))),
          ),
        ));
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
              child: Text('      Menu Principal Poligonales',
                  style: TextStyle(fontSize: 12, color: Colors.white)),
            ),
          )
        ],
      ),
    );
  }
}
