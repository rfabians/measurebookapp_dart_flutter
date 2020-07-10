import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:measurebookapp/clases/database.dart';
import 'package:measurebookapp/modelos/proyectos.dart';
import 'package:measurebookapp/modelos/puntosReferencia.dart';
import 'package:measurebookapp/pages/conversionCoordenadas.dart';
import 'package:measurebookapp/pages/gestorPuntos.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:measurebookapp/pages/menuPrincipal.dart';
import 'package:measurebookapp/pages/nivelaciones.dart';
import 'package:measurebookapp/pages/observacionesGNSS/observacionGNSSVertice.dart';
import 'package:measurebookapp/pages/poligonales/poligonalesMain.dart';

class ListadoPuntoRef extends StatefulWidget {
  proyectos datosProyecto;
  ListadoPuntoRef({Key key, this.datosProyecto}) : super(key: key);

  @override
  _ListadoPuntoRefState createState() => _ListadoPuntoRefState();
}

class _ListadoPuntoRefState extends State<ListadoPuntoRef> {
  int _index = 0;
  Widget _mostarFoto(String fotoString) {
    if (fotoString == null) {
      return Image.asset('assets/images/delta.png');
    } else {
      return Image.memory(base64Decode(fotoString));
    }
  }

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

    if (widget.datosProyecto.Tipo_Proyeccion == 'Gauss-Krüger') {
      //Planas Gauss
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
            child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: SingleChildScrollView(
            child: FutureBuilder(
                future: gestorMBDatabase.db.getPuntosReferenciaData(
                    widget.datosProyecto.Nombre_Proyecto),
                builder: (BuildContext context,
                    AsyncSnapshot<List<puntosReferencia>> snapshot) {
                  MediaQueryData mediaQueryData = MediaQuery.of(context);
                  if (snapshot.hasData) {
                    if (snapshot.data.length <= 0) {
                      return Center(
                        child: Container(
                          height: 550,
                          width: 320,
                          child: Center(
                            child: FlareActor(
                              'assets/images/forki.flr',
                              animation: 'forki',
                            ),
                          ),
                        ),
                      );
                    } else {
                      return MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: 10),
                            Image.asset(
                              'assets/images/puntos.png',
                              height: 80,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Listado Puntos de Referencia',
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 16.0,
                              ),
                            ),
                            Container(
                                height: mediaQueryData.size.height * .8,
                                child: ListView.builder(
                                  itemCount: snapshot.data.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    puntosReferencia listPuntsRef =
                                        snapshot.data[index];
                                    return Padding(
                                      padding: EdgeInsets.only(
                                          bottom: 3,
                                          top: 3,
                                          left: 15,
                                          right: 15),
                                      child: Container(
                                          child: Material(
                                        borderRadius: BorderRadius.circular(15),
                                        color: Colors.white,
                                        elevation: 5,
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              height: 150,
                                              width: 150,
                                              child: FittedBox(
                                                fit: BoxFit.cover,
                                                child: _mostarFoto(
                                                    listPuntsRef.Foto_Placa),
                                              ),
                                            ),
                                            Container(
                                              height: 150,
                                              width: 130,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: <Widget>[
                                                  Align(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      '${listPuntsRef.Nombre_Punto}',
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          color:
                                                              Colors.blueAccent,
                                                          fontSize: 14.0),
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Text(
                                                      'Norte',
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          color: Colors.black54,
                                                          fontSize: 12.0),
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Text(
                                                      '${listPuntsRef.Norte}',
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          color:
                                                              Colors.blueAccent,
                                                          fontSize: 12.0),
                                                    ),
                                                  ),
                                                  Divider(
                                                    height: 2,
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Text(
                                                      'Este',
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          color: Colors.black54,
                                                          fontSize: 12.0),
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Text(
                                                      '${listPuntsRef.Este}',
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          color:
                                                              Colors.blueAccent,
                                                          fontSize: 12.0),
                                                    ),
                                                  ),
                                                  Divider(
                                                    height: 2,
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Text(
                                                      'Altura',
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          color: Colors.black54,
                                                          fontSize: 12.0),
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Text(
                                                      '${listPuntsRef.Altura}',
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          color:
                                                              Colors.blueAccent,
                                                          fontSize: 12.0),
                                                    ),
                                                  ),
                                                  Divider(
                                                    height: 2,
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Text(
                                                      'Tipo Altura',
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          color: Colors.black54,
                                                          fontSize: 12.0),
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Text(
                                                      '${listPuntsRef.Tipo_Altura}',
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          color:
                                                              Colors.blueAccent,
                                                          fontSize: 12.0),
                                                    ),
                                                  ),
                                                  Divider(
                                                    height: 2,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              height: 150,
                                              width: 80,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Material(),
                                                  Material(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: Colors.black12,
                                                    child: GestureDetector(
                                                        onTap: () {
                                                          gestorMBDatabase.db
                                                              .InserDataSQL(
                                                                  'DELETE FROM PUNTOS_REFERENCIA WHERE ID_Punto = ${listPuntsRef.ID_Punto}');
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          GestosPuntos(
                                                                            datosProyecto:
                                                                                widget.datosProyecto,
                                                                          )));
                                                        },
                                                        child: Icon(
                                                            Icons.delete,
                                                            size: 40,
                                                            color: Colors
                                                                .blueAccent)),
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      )),
                                    );
                                  },
                                )),
                          ],
                        ),
                      );
                    }
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
          ),
        )),
      );
    } else if (widget.datosProyecto.Tipo_Proyeccion == 'Plano Cartesiano') {
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
            child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: SingleChildScrollView(
            child: FutureBuilder(
                future: gestorMBDatabase.db.getPuntosReferenciaData(
                    widget.datosProyecto.Nombre_Proyecto),
                builder: (BuildContext context,
                    AsyncSnapshot<List<puntosReferencia>> snapshot) {
                  MediaQueryData mediaQueryData = MediaQuery.of(context);
                  if (snapshot.hasData) {
                    if (snapshot.data.length <= 0) {
                      return Center(
                        child: Container(
                          height: 550,
                          width: 320,
                          child: Center(
                            child: FlareActor(
                              'assets/images/forki.flr',
                              animation: 'forki',
                            ),
                          ),
                        ),
                      );
                    } else {
                      return MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: 10),
                            Image.asset(
                              'assets/images/puntos.png',
                              height: 80,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Listado Puntos de Referencia',
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 16.0,
                              ),
                            ),
                            Container(
                                height: mediaQueryData.size.height * .8,
                                child: ListView.builder(
                                  itemCount: snapshot.data.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    puntosReferencia listPuntsRef =
                                        snapshot.data[index];
                                    return Padding(
                                      padding: EdgeInsets.only(
                                          bottom: 3,
                                          top: 3,
                                          left: 15,
                                          right: 15),
                                      child: Container(
                                          child: Material(
                                        borderRadius: BorderRadius.circular(15),
                                        color: Colors.white,
                                        elevation: 5,
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              height: 150,
                                              width: 150,
                                              child: FittedBox(
                                                fit: BoxFit.cover,
                                                child: _mostarFoto(
                                                    listPuntsRef.Foto_Placa),
                                              ),
                                            ),
                                            Container(
                                              height: 150,
                                              width: 130,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: <Widget>[
                                                  Align(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      '${listPuntsRef.Nombre_Punto}',
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          color:
                                                              Colors.blueAccent,
                                                          fontSize: 14.0),
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Text(
                                                      'Norte',
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          color: Colors.black54,
                                                          fontSize: 12.0),
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Text(
                                                      '${listPuntsRef.Norte}',
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          color:
                                                              Colors.blueAccent,
                                                          fontSize: 12.0),
                                                    ),
                                                  ),
                                                  Divider(
                                                    height: 2,
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Text(
                                                      'Este',
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          color: Colors.black54,
                                                          fontSize: 12.0),
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Text(
                                                      '${listPuntsRef.Este}',
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          color:
                                                              Colors.blueAccent,
                                                          fontSize: 12.0),
                                                    ),
                                                  ),
                                                  Divider(
                                                    height: 2,
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Text(
                                                      'Altura',
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          color: Colors.black54,
                                                          fontSize: 12.0),
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Text(
                                                      '${listPuntsRef.Altura}',
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          color:
                                                              Colors.blueAccent,
                                                          fontSize: 12.0),
                                                    ),
                                                  ),
                                                  Divider(
                                                    height: 2,
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Text(
                                                      'Tipo Altura',
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          color: Colors.black54,
                                                          fontSize: 12.0),
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Text(
                                                      '${listPuntsRef.Tipo_Altura}',
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          color:
                                                              Colors.blueAccent,
                                                          fontSize: 12.0),
                                                    ),
                                                  ),
                                                  Divider(
                                                    height: 2,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              height: 150,
                                              width: 80,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Material(),
                                                  Material(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: Colors.black12,
                                                    child: GestureDetector(
                                                        onTap: () {
                                                          gestorMBDatabase.db
                                                              .InserDataSQL(
                                                                  'DELETE FROM PUNTOS_REFERENCIA WHERE ID_Punto = ${listPuntsRef.ID_Punto}');
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          GestosPuntos(
                                                                            datosProyecto:
                                                                                widget.datosProyecto,
                                                                          )));
                                                        },
                                                        child: Icon(
                                                            Icons.delete,
                                                            size: 40,
                                                            color: Colors
                                                                .blueAccent)),
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      )),
                                    );
                                  },
                                )),
                          ],
                        ),
                      );
                    }
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
          ),
        )),
      );
    } else if (widget.datosProyecto.Tipo_Proyeccion ==
        'Transversal de Mercator') {
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
            child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: SingleChildScrollView(
            child: FutureBuilder(
                future: gestorMBDatabase.db.getPuntosReferenciaData(
                    widget.datosProyecto.Nombre_Proyecto),
                builder: (BuildContext context,
                    AsyncSnapshot<List<puntosReferencia>> snapshot) {
                  MediaQueryData mediaQueryData = MediaQuery.of(context);
                  if (snapshot.hasData) {
                    if (snapshot.data.length <= 0) {
                      return Center(
                        child: Container(
                          height: 550,
                          width: 320,
                          child: Center(
                            child: FlareActor(
                              'assets/images/forki.flr',
                              animation: 'forki',
                            ),
                          ),
                        ),
                      );
                    } else {
                      return MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: 10),
                            Image.asset(
                              'assets/images/puntos.png',
                              height: 80,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Listado Puntos de Referencia',
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 16.0,
                              ),
                            ),
                            Container(
                                height: mediaQueryData.size.height * .8,
                                child: ListView.builder(
                                  itemCount: snapshot.data.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    puntosReferencia listPuntsRef =
                                        snapshot.data[index];
                                    return Padding(
                                      padding: EdgeInsets.only(
                                          bottom: 3,
                                          top: 3,
                                          left: 15,
                                          right: 15),
                                      child: Container(
                                          child: Material(
                                        borderRadius: BorderRadius.circular(15),
                                        color: Colors.white,
                                        elevation: 5,
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              height: 150,
                                              width: 150,
                                              child: FittedBox(
                                                fit: BoxFit.cover,
                                                child: _mostarFoto(
                                                    listPuntsRef.Foto_Placa),
                                              ),
                                            ),
                                            Container(
                                              height: 150,
                                              width: 130,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: <Widget>[
                                                  Align(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      '${listPuntsRef.Nombre_Punto}',
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          color:
                                                              Colors.blueAccent,
                                                          fontSize: 14.0),
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Text(
                                                      'Norte',
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          color: Colors.black54,
                                                          fontSize: 12.0),
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Text(
                                                      '${listPuntsRef.Norte}',
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          color:
                                                              Colors.blueAccent,
                                                          fontSize: 12.0),
                                                    ),
                                                  ),
                                                  Divider(
                                                    height: 2,
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Text(
                                                      'Este',
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          color: Colors.black54,
                                                          fontSize: 12.0),
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Text(
                                                      '${listPuntsRef.Este}',
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          color:
                                                              Colors.blueAccent,
                                                          fontSize: 12.0),
                                                    ),
                                                  ),
                                                  Divider(
                                                    height: 2,
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Text(
                                                      'Altura',
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          color: Colors.black54,
                                                          fontSize: 12.0),
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Text(
                                                      '${listPuntsRef.Altura}',
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          color:
                                                              Colors.blueAccent,
                                                          fontSize: 12.0),
                                                    ),
                                                  ),
                                                  Divider(
                                                    height: 2,
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Text(
                                                      'Tipo Altura',
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          color: Colors.black54,
                                                          fontSize: 12.0),
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Text(
                                                      '${listPuntsRef.Tipo_Altura}',
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          color:
                                                              Colors.blueAccent,
                                                          fontSize: 12.0),
                                                    ),
                                                  ),
                                                  Divider(
                                                    height: 2,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              height: 150,
                                              width: 80,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Material(),
                                                  Material(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: Colors.black12,
                                                    child: GestureDetector(
                                                        onTap: () {
                                                          gestorMBDatabase.db
                                                              .InserDataSQL(
                                                                  'DELETE FROM PUNTOS_REFERENCIA WHERE ID_Punto = ${listPuntsRef.ID_Punto}');
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          GestosPuntos(
                                                                            datosProyecto:
                                                                                widget.datosProyecto,
                                                                          )));
                                                        },
                                                        child: Icon(
                                                            Icons.delete,
                                                            size: 40,
                                                            color: Colors
                                                                .blueAccent)),
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      )),
                                    );
                                  },
                                )),
                          ],
                        ),
                      );
                    }
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
          ),
        )),
      );
    } else {
      return Scaffold(
        body: SafeArea(
            child: Container(
          child: Center(
            child: Text('No Funciona'),
          ),
        )),
      );
    }
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
              child: Text('      Listado de Puntos',
                  style: TextStyle(fontSize: 12, color: Colors.white)),
            ),
          )
        ],
      ),
    );
  }
}
