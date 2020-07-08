import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:measurebookapp/clases/database.dart';
import 'package:measurebookapp/modelos/proyectos.dart';
import 'package:measurebookapp/modelos/puntosReferencia.dart';
import 'package:measurebookapp/pages/gestorPuntos.dart';
import 'package:flare_flutter/flare_actor.dart';

class ListadoPuntoRef extends StatefulWidget {
  proyectos datosProyecto;
  ListadoPuntoRef({Key key, this.datosProyecto}) : super(key: key);

  @override
  _ListadoPuntoRefState createState() => _ListadoPuntoRefState();
}

class _ListadoPuntoRefState extends State<ListadoPuntoRef> {
  Widget _mostarFoto(String fotoString) {
    if (fotoString == null) {
      return Image.asset('assets/images/delta.png');
    } else {
      return Image.memory(base64Decode(fotoString));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.datosProyecto.Tipo_Proyeccion == 'Gauss-Krüger') {
      //Planas Gauss
      return Scaffold(
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
}
