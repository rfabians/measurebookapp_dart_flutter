import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:measurebookapp/clases/conversionCoordenadasMB.dart';
import 'package:measurebookapp/clases/database.dart';
import 'package:measurebookapp/modelos/cPlanasGenerico.dart';
import 'package:measurebookapp/modelos/cartesianasCS.dart';
import 'package:measurebookapp/modelos/coordenadasCartesianas.dart';
import 'package:measurebookapp/modelos/coordenadasElipsoidales.dart';
import 'package:measurebookapp/modelos/coordenadasON.dart';
import 'package:measurebookapp/modelos/coordenadasPlanasGauss.dart';
import 'package:measurebookapp/modelos/departamentos.dart';
import 'package:measurebookapp/modelos/gaussCS.dart';
import 'package:measurebookapp/modelos/municipios.dart';
import 'package:measurebookapp/modelos/origenesCartesianos.dart';
import 'package:measurebookapp/modelos/origenesGauss.dart';
import 'package:measurebookapp/modelos/proyectos.dart';
import 'package:measurebookapp/pages/conversionCoordenadas.dart';
import 'package:measurebookapp/pages/conversionPunto.dart';
import 'package:measurebookapp/pages/descripcionSC.dart';
import 'package:measurebookapp/pages/gestorPuntos.dart';
import 'package:measurebookapp/pages/menuPrincipal.dart';
import 'dart:math' as m;

import 'package:measurebookapp/pages/nivelaciones.dart';
import 'package:measurebookapp/pages/observacionesGNSS/observacionGNSSVertice.dart';
import 'package:measurebookapp/pages/poligonales/poligonalesMain.dart';

class ImportarPuntoOSCoor extends StatefulWidget {
  final proyectos datosProyecto;
  ImportarPuntoOSCoor({Key key, this.datosProyecto}) : super(key: key);

  @override
  _ImportarPuntoOSCoorState createState() => _ImportarPuntoOSCoorState();
  List<DescripcionSistemCoor> sistemasCoordenadas =
      List<DescripcionSistemCoor>(5);
}

class _ImportarPuntoOSCoorState extends State<ImportarPuntoOSCoor> {
  Future<CPlanasGenerico> coordenadasInportadas(
      double latitud, double longitud, double alturaPunto) async {
    if (widget.datosProyecto.Tipo_Proyeccion == 'Gauss-Krüger') {
      GaussCS gaussCS = await gestorMBDatabase.db
          .getOrigenGaussData(widget.datosProyecto.ID_Proyeccion);
      CoordenadasElipsoidales coordenadasElipsoidales =
          CoordenadasElipsoidales();
      coordenadasElipsoidales.latitud = latitud;
      coordenadasElipsoidales.longitud = longitud;
      coordenadasElipsoidales.altitud = alturaPunto;
      ConversionCoordenadasMB conversionCoordenadasMB =
          ConversionCoordenadasMB();
      CoordenadasGauss coordenadasGauss = CoordenadasGauss();
      coordenadasGauss = conversionCoordenadasMB.elipsoidales2Gauss(
          coordenadasElipsoidales, gaussCS);
      CPlanasGenerico cPlanasGenerico = CPlanasGenerico();
      cPlanasGenerico.norte = coordenadasGauss.norte;
      cPlanasGenerico.este = coordenadasGauss.este;
      cPlanasGenerico.altura = alturaPunto;
      return cPlanasGenerico;
    } else if (widget.datosProyecto.Tipo_Proyeccion == 'Plano Cartesiano') {
      CartesianasCS cartesianasCS = await gestorMBDatabase.db
          .getOrigenCartesianoData(widget.datosProyecto.ID_Proyeccion);
      CoordenadasElipsoidales coordenadasElipsoidales =
          CoordenadasElipsoidales();
      coordenadasElipsoidales.latitud = latitud;
      coordenadasElipsoidales.longitud = longitud;
      coordenadasElipsoidales.altitud = alturaPunto;
      ConversionCoordenadasMB conversionCoordenadasMB =
          ConversionCoordenadasMB();
      CoordenadasCartesianas coordenadasCartesianas = conversionCoordenadasMB
          .elipsoidales2Cartesianas(cartesianasCS, coordenadasElipsoidales);
      CPlanasGenerico cPlanasGenerico = CPlanasGenerico();
      cPlanasGenerico.norte = coordenadasCartesianas.norte;
      cPlanasGenerico.este = coordenadasCartesianas.este;
      cPlanasGenerico.altura = alturaPunto;
      return cPlanasGenerico;
    } else if (widget.datosProyecto.Tipo_Proyeccion ==
        'Transversal de Mercator') {
      CoordenadasElipsoidales coordenadasElipsoidales =
          CoordenadasElipsoidales();
      coordenadasElipsoidales.latitud = latitud;
      coordenadasElipsoidales.longitud = longitud;
      coordenadasElipsoidales.altitud = alturaPunto;
      ConversionCoordenadasMB conversionCoordenadasMB =
          ConversionCoordenadasMB();
      CoordenadasON coordenadasON = conversionCoordenadasMB
          .elipsoidales2GaussNuevo(coordenadasElipsoidales);
      CPlanasGenerico cPlanasGenerico = CPlanasGenerico();
      cPlanasGenerico.norte = coordenadasON.norte;
      cPlanasGenerico.este = coordenadasON.este;
      cPlanasGenerico.altura = alturaPunto;
      return cPlanasGenerico;
    }

    double roundDouble(double value, int places) {
      double mod = m.pow(10.0, places);
      return ((value * mod).round().toDouble() / mod);
    }
  }

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

    if (widget.datosProyecto.Tipo_Proyeccion == 'Transversal de Mercator') {
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
            child: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child:
                    Image.asset('assets/images/conversion.png', height: 40.0),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: RichText(
                    text: TextSpan(children: <TextSpan>[
                  TextSpan(
                      text:
                          'Seleccione el sistema de Coordenadas del punto a Importar',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 12.0,
                        color: Color(0xff007FFF),
                      )),
                ])),
              ),
              Divider(height: 10.0),
              Container(
                height: 550,
                width: 350,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: [0.5, 0.9, 1],
                        colors: [Colors.white, Colors.white70, Colors.white38]),
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black45,
                          blurRadius: 10.0,
                          offset: Offset(10.0, 10.0))
                    ]),
                child: Swiper(
                  pagination: SwiperPagination(builder: SwiperPagination.dots),
                  itemCount: 4,
                  layout: SwiperLayout.DEFAULT,
                  itemHeight: 300.0,
                  itemWidth: 450.0,
                  itemBuilder: (BuildContext context, int index) {
                    DescripcionSistemCoor elipsoidal = DescripcionSistemCoor(
                        nombreProyeccion: 'Coordenadas Elipsoidales',
                        imagen: 'assets/images/elipsoidal.png');
                    DescripcionSistemCoor geocentrico = DescripcionSistemCoor(
                      nombreProyeccion: 'Coordenadas Geocéntricas',
                      imagen: 'assets/images/geocentrica.png',
                    );
                    DescripcionSistemCoor planas_Gauss = DescripcionSistemCoor(
                      nombreProyeccion: 'Coordenadas Gauss - Krüger',
                      imagen: 'assets/images/gauss.png',
                    );
                    DescripcionSistemCoor planas_Cartesianas =
                        DescripcionSistemCoor(
                            nombreProyeccion: 'Coordenadas Planas Cartesianas',
                            imagen: 'assets/images/cartesiana.png');
                    DescripcionSistemCoor tm = DescripcionSistemCoor(
                        nombreProyeccion: 'MAGNA Origen Nacional',
                        imagen: 'assets/images/nacional.png');
                    List<DescripcionSistemCoor> listSistemas =
                        List<DescripcionSistemCoor>(5);
                    listSistemas[0] = elipsoidal;
                    listSistemas[1] = geocentrico;
                    listSistemas[2] = planas_Gauss;
                    listSistemas[3] = planas_Cartesianas;
                    listSistemas[4] = tm;

                    DescripcionSistemCoor a = listSistemas[index];

                    if (a.nombreProyeccion == 'Coordenadas Elipsoidales') {
                      return Center(
                          child: Container(
                        width: 300.0,
                        height: 480.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Column(
                          children: <Widget>[
                            Center(
                              child: Text(
                                a.nombreProyeccion,
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.blueAccent,
                                ),
                              ),
                            ),
                            SizedBox(height: 60.0),
                            Image.asset(a.imagen, height: 160),
                            SizedBox(height: 50.0),
                            ListTile(
                              title: Text(
                                'Sistema Decimal',
                                style: TextStyle(color: Colors.blueAccent),
                              ),
                              trailing: Icon(
                                Icons.chevron_right,
                                color: Colors.blueAccent,
                                size: 30.0,
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ConversionPunto(
                                              datosProyecto:
                                                  widget.datosProyecto,
                                              sistemaOrigen: a.nombreProyeccion,
                                            )));
                              },
                            ),
                            ListTile(
                              title: Text(
                                'Sistema Sexadecimal',
                                style: TextStyle(color: Colors.blueAccent),
                              ),
                              trailing: Icon(
                                Icons.chevron_right,
                                color: Colors.blueAccent,
                                size: 30,
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ConversionPunto(
                                              datosProyecto:
                                                  widget.datosProyecto,
                                              sistemaOrigen: 'Hexa',
                                            )));
                              },
                            )
                          ],
                        ),
                      ));
                    } else {
                      return Center(
                          child: Container(
                        width: 300.0,
                        height: 480.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Column(
                          children: <Widget>[
                            Center(
                              child: Text(
                                a.nombreProyeccion,
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.blueAccent,
                                ),
                              ),
                            ),
                            SizedBox(height: 60.0),
                            Image.asset(a.imagen, height: 160),
                            SizedBox(height: 100.0),
                            FlatButton(
                                onPressed: () {
                                  if (a.nombreProyeccion ==
                                      'Coordenadas Planas Cartesianas') {
                                    _alertDialogoCartesianas(context);
                                  } else if (a.nombreProyeccion ==
                                      'Coordenadas Gauss - Krüger') {
                                    _sistemaGauss(context);
                                  } else {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ConversionPunto(
                                                  datosProyecto:
                                                      widget.datosProyecto,
                                                  sistemaOrigen:
                                                      a.nombreProyeccion,
                                                )));
                                  }
                                },
                                child: Icon(Icons.arrow_forward_ios,
                                    size: 30.0, color: Colors.blueAccent))
                          ],
                        ),
                      ));
                    }
                  },
                ),
              )
            ],
          ),
        )),
      );
    } else {
      return Scaffold(
        body: SafeArea(
            child: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child:
                    Image.asset('assets/images/conversion.png', height: 80.0),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: RichText(
                    text: TextSpan(children: <TextSpan>[
                  TextSpan(
                      text:
                          'Seleccione el sistema de Coordenadas del punto a Importar',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 14.0,
                        color: Color(0xff007FFF),
                      )),
                ])),
              ),
              Divider(height: 30.0),
              Container(
                height: 550,
                width: 350,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: [0.5, 0.9, 1],
                        colors: [Colors.white, Colors.white70, Colors.white38]),
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black45,
                          blurRadius: 10.0,
                          offset: Offset(10.0, 10.0))
                    ]),
                child: Swiper(
                  pagination: SwiperPagination(builder: SwiperPagination.dots),
                  itemCount: 5,
                  layout: SwiperLayout.DEFAULT,
                  itemHeight: 300.0,
                  itemWidth: 450.0,
                  itemBuilder: (BuildContext context, int index) {
                    DescripcionSistemCoor elipsoidal = DescripcionSistemCoor(
                        nombreProyeccion: 'Coordenadas Elipsoidales',
                        imagen: 'assets/images/elipsoidal.png');
                    DescripcionSistemCoor geocentrico = DescripcionSistemCoor(
                      nombreProyeccion: 'Coordenadas Geocéntricas',
                      imagen: 'assets/images/geocentrica.png',
                    );
                    DescripcionSistemCoor planas_Gauss = DescripcionSistemCoor(
                      nombreProyeccion: 'Coordenadas Gauss - Krüger',
                      imagen: 'assets/images/gauss.png',
                    );
                    DescripcionSistemCoor planas_Cartesianas =
                        DescripcionSistemCoor(
                            nombreProyeccion: 'Coordenadas Planas Cartesianas',
                            imagen: 'assets/images/cartesiana.png');
                    DescripcionSistemCoor tm = DescripcionSistemCoor(
                        nombreProyeccion: 'MAGNA Origen Nacional',
                        imagen: 'assets/images/nacional.png');
                    List<DescripcionSistemCoor> listSistemas =
                        List<DescripcionSistemCoor>(5);
                    listSistemas[0] = elipsoidal;
                    listSistemas[1] = geocentrico;
                    listSistemas[2] = planas_Gauss;
                    listSistemas[3] = planas_Cartesianas;
                    listSistemas[4] = tm;

                    DescripcionSistemCoor a = listSistemas[index];

                    if (a.nombreProyeccion == 'Coordenadas Elipsoidales') {
                      return Center(
                          child: Container(
                        width: 300.0,
                        height: 480.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Column(
                          children: <Widget>[
                            Center(
                              child: Text(
                                a.nombreProyeccion,
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.blueAccent,
                                ),
                              ),
                            ),
                            SizedBox(height: 60.0),
                            Image.asset(a.imagen, height: 160),
                            SizedBox(height: 50.0),
                            ListTile(
                              title: Text(
                                'Sistema Decimal',
                                style: TextStyle(color: Colors.blueAccent),
                              ),
                              trailing: Icon(
                                Icons.chevron_right,
                                color: Colors.blueAccent,
                                size: 30.0,
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ConversionPunto(
                                              datosProyecto:
                                                  widget.datosProyecto,
                                              sistemaOrigen: a.nombreProyeccion,
                                            )));
                              },
                            ),
                            ListTile(
                              title: Text(
                                'Sistema Sexadecimal',
                                style: TextStyle(color: Colors.blueAccent),
                              ),
                              trailing: Icon(
                                Icons.chevron_right,
                                color: Colors.blueAccent,
                                size: 30,
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ConversionPunto(
                                              datosProyecto:
                                                  widget.datosProyecto,
                                              sistemaOrigen: 'Hexa',
                                            )));
                              },
                            )
                          ],
                        ),
                      ));
                    } else {
                      return Center(
                          child: Container(
                        width: 300.0,
                        height: 480.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Column(
                          children: <Widget>[
                            Center(
                              child: Text(
                                a.nombreProyeccion,
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.blueAccent,
                                ),
                              ),
                            ),
                            SizedBox(height: 60.0),
                            Image.asset(a.imagen, height: 160),
                            SizedBox(height: 100.0),
                            FlatButton(
                                onPressed: () {
                                  if (a.nombreProyeccion ==
                                      'Coordenadas Planas Cartesianas') {
                                    _alertDialogoCartesianas(context);
                                  } else if (a.nombreProyeccion ==
                                      'Coordenadas Gauss - Krüger') {
                                    _sistemaGauss(context);
                                  } else {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ConversionPunto(
                                                  datosProyecto:
                                                      widget.datosProyecto,
                                                  sistemaOrigen:
                                                      a.nombreProyeccion,
                                                )));
                                  }
                                },
                                child: Icon(Icons.arrow_forward_ios,
                                    size: 30.0, color: Colors.blueAccent))
                          ],
                        ),
                      ));
                    }
                  },
                ),
              )
            ],
          ),
        )),
      );
    }
  }

  void _alertDialogoCartesianas(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => Container(
              height: 500,
              child: Scaffold(
                body: FutureBuilder<List<departamentos>>(
                    future: gestorMBDatabase.db.getDepartamentos(),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<departamentos>> listaDep) {
                      if (listaDep.hasData) {
                        return Container(
                            height: 700,
                            child: Column(
                              children: <Widget>[
                                SizedBox(height: 30),
                                Text(
                                  'Seleccione un Departamento',
                                  style: TextStyle(
                                      color: Color(0xff007FFF), fontSize: 16.0),
                                ),
                                SizedBox(
                                  height: 14.0,
                                ),
                                Flexible(
                                  child: ListView.builder(
                                      itemCount: listaDep.data.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        departamentos listaDepartamentos =
                                            listaDep.data[index];
                                        return Dismissible(
                                            onDismissed: (direction) {},
                                            key: UniqueKey(),
                                            child: Container(
                                                height: 50,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: ListTile(
                                                  title: Text(
                                                    listaDepartamentos.NOMBRE,
                                                    style: TextStyle(
                                                        color: Colors.black54,
                                                        fontSize: 16.0),
                                                  ),
                                                  trailing: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: <Widget>[
                                                      Icon(Icons.chevron_right,
                                                          color:
                                                              Colors.blueAccent)
                                                    ],
                                                  ),
                                                  onTap: () {
                                                    _alertDialogoCartesianasMunicipio(
                                                        context,
                                                        listaDepartamentos
                                                            .PK_DEPARTAMENTO);
                                                  },
                                                )));
                                      }),
                                )
                              ],
                            ));
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
              ),
            ));
  }

  void _alertDialogoCartesianasMunicipio(
      BuildContext context, int fk_Departamento) {
    showDialog(
        context: context,
        builder: (context) => Container(
              height: 500,
              child: Scaffold(
                body: FutureBuilder<List<municipios>>(
                    future: gestorMBDatabase.db.getMunicipios(fk_Departamento),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<municipios>> listaMunicipios) {
                      if (listaMunicipios.hasData) {
                        return Container(
                            height: 700,
                            child: Column(
                              children: <Widget>[
                                SizedBox(height: 30),
                                Text(
                                  'Seleccione un Municipio',
                                  style: TextStyle(
                                      color: Color(0xff007FFF), fontSize: 16.0),
                                ),
                                SizedBox(
                                  height: 14.0,
                                ),
                                Flexible(
                                  child: ListView.builder(
                                      itemCount: listaMunicipios.data.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        municipios listaMun =
                                            listaMunicipios.data[index];
                                        return Dismissible(
                                            key: UniqueKey(),
                                            child: Container(
                                                height: 50,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: ListTile(
                                                  title: Text(
                                                    listaMun.NOMBRE,
                                                    style: TextStyle(
                                                        color: Colors.black54,
                                                        fontSize: 14.0),
                                                  ),
                                                  trailing: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: <Widget>[
                                                      Icon(Icons.chevron_right,
                                                          color:
                                                              Colors.blueAccent)
                                                    ],
                                                  ),
                                                  onTap: () {
                                                    _sistemas2Cartesianos(
                                                        context,
                                                        listaMun.PK_MUNICIPIOS);
                                                  },
                                                )));
                                      }),
                                )
                              ],
                            ));
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
              ),
            ));
  }

// Importar Coordenadas Plano Cartesiano
  void _sistemas2Cartesianos(BuildContext context, int fk_Muninipio) {
    showDialog(
        context: context,
        builder: (context) => Scaffold(
              body: FutureBuilder<List<origenesCartesianos>>(
                future: gestorMBDatabase.db.getCartesianas(fk_Muninipio),
                builder: (BuildContext context,
                    AsyncSnapshot<List<origenesCartesianos>> snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data.length > 1) {
                      return Swiper(
                          layout: SwiperLayout.STACK,
                          itemWidth: MediaQuery.of(context).size.width * 0.8,
                          itemHeight: MediaQuery.of(context).size.height * 0.8,
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            origenesCartesianos listaOrigenes =
                                snapshot.data[index];
                            return Container(
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                ),
                                key: UniqueKey(),
                                child: Card(
                                  elevation: 14.0,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/fondo_sistemas.png'),
                                          fit: BoxFit.cover,
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0))),
                                    child: Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Column(
                                        children: <Widget>[
                                          SizedBox(height: 15.0),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: RichText(
                                                text: TextSpan(
                                                    children: <TextSpan>[
                                                  TextSpan(
                                                      text: 'Plano Cartesiano',
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          color: Colors.white,
                                                          fontSize: 16.0)),
                                                ])),
                                          ),
                                          Align(
                                            alignment: Alignment.bottomLeft,
                                            child: Text(
                                              '${listaOrigenes.NOMBRE}',
                                              style: TextStyle(
                                                  fontFamily: 'Roboto',
                                                  color: Colors.white,
                                                  fontSize: 16.0),
                                            ),
                                          ),
                                          SizedBox(height: 50.0),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: RichText(
                                                text: TextSpan(
                                                    children: <TextSpan>[
                                                  TextSpan(
                                                      text: 'DATUM \n',
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          color: Colors.black54,
                                                          fontSize: 12.0)),
                                                  TextSpan(
                                                      text: 'Magna Sirgas',
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          color:
                                                              Color(0xff007FFF),
                                                          fontSize: 14.0))
                                                ])),
                                          ),
                                          Divider(),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: RichText(
                                                text: TextSpan(
                                                    children: <TextSpan>[
                                                  TextSpan(
                                                      text: 'Elipsoide\n',
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          color: Colors.black54,
                                                          fontSize: 12.0)),
                                                  TextSpan(
                                                      text: 'GRS80',
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          color:
                                                              Color(0xff007FFF),
                                                          fontSize: 14.0))
                                                ])),
                                          ),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                          Align(
                                            alignment: Alignment.center,
                                            child: RichText(
                                                text: TextSpan(
                                                    children: <TextSpan>[
                                                  TextSpan(
                                                      text:
                                                          'Sistema de Proyección ',
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          color:
                                                              Color(0xff007FFF),
                                                          fontSize: 15.0)),
                                                ])),
                                          ),
                                          SizedBox(height: 5.0),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: RichText(
                                                text: TextSpan(
                                                    children: <TextSpan>[
                                                  TextSpan(
                                                      text: 'Proyección\n',
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          color: Colors.black54,
                                                          fontSize: 12.0)),
                                                  TextSpan(
                                                      text:
                                                          'Plano Cartesiano IGAC',
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          color:
                                                              Color(0xff007FFF),
                                                          fontSize: 14.0))
                                                ])),
                                          ),
                                          Divider(),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: RichText(
                                                text: TextSpan(
                                                    children: <TextSpan>[
                                                  TextSpan(
                                                      text:
                                                          'Latitud de Origen\n',
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          color: Colors.black54,
                                                          fontSize: 12.0)),
                                                  TextSpan(
                                                      text:
                                                          '${listaOrigenes.LATITUD.toString()}',
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          color:
                                                              Color(0xff007FFF),
                                                          fontSize: 14.0))
                                                ])),
                                          ),
                                          Divider(),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: RichText(
                                                text: TextSpan(
                                                    children: <TextSpan>[
                                                  TextSpan(
                                                      text:
                                                          'Longitud de Origen\n',
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          color: Colors.black54,
                                                          fontSize: 12.0)),
                                                  TextSpan(
                                                      text:
                                                          '${listaOrigenes.LONGITUD.toString()}',
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          color:
                                                              Color(0xff007FFF),
                                                          fontSize: 14.0))
                                                ])),
                                          ),
                                          Divider(),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: RichText(
                                                text: TextSpan(
                                                    children: <TextSpan>[
                                                  TextSpan(
                                                      text: 'Falso Norte\n',
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          color: Colors.black54,
                                                          fontSize: 12.0)),
                                                  TextSpan(
                                                      text:
                                                          '${listaOrigenes.NORTE.toString()} m',
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          color:
                                                              Color(0xff007FFF),
                                                          fontSize: 14.0))
                                                ])),
                                          ),
                                          Divider(),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: RichText(
                                                text: TextSpan(
                                                    children: <TextSpan>[
                                                  TextSpan(
                                                      text: 'Falso Este\n ',
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          color: Colors.black54,
                                                          fontSize: 12.0)),
                                                  TextSpan(
                                                      text:
                                                          '${listaOrigenes.ESTE.toString()} m',
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          color:
                                                              Color(0xff007FFF),
                                                          fontSize: 14.0))
                                                ])),
                                          ),
                                          Divider(),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: RichText(
                                                text: TextSpan(
                                                    children: <TextSpan>[
                                                  TextSpan(
                                                      text:
                                                          'Altura del Plano\n ',
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          color: Colors.black54,
                                                          fontSize: 12.0)),
                                                  TextSpan(
                                                      text:
                                                          '${listaOrigenes.PLANO_PROY} m',
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          color:
                                                              Color(0xff007FFF),
                                                          fontSize: 14.0))
                                                ])),
                                          ),
                                          Divider(),
                                          Align(
                                            alignment: Alignment.center,
                                            child: Center(
                                              child: Column(
                                                children: <Widget>[
                                                  FlatButton(
                                                      onPressed: () {
                                                        CartesianasCS
                                                            cartesianasCS =
                                                            CartesianasCS();
                                                        cartesianasCS.ESTE =
                                                            listaOrigenes.ESTE;
                                                        cartesianasCS.NORTE =
                                                            listaOrigenes.NORTE;
                                                        cartesianasCS
                                                                .PLANO_PROY =
                                                            listaOrigenes
                                                                .PLANO_PROY;
                                                        cartesianasCS.LATITUD =
                                                            listaOrigenes
                                                                .LATITUD;
                                                        cartesianasCS.LONGITUD =
                                                            listaOrigenes
                                                                .LONGITUD;
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        ConversionPunto(
                                                                          datosProyecto:
                                                                              widget.datosProyecto,
                                                                          sistemaOrigen:
                                                                              'Coordenadas Planas Cartesianas',
                                                                          cartesianasCS:
                                                                              cartesianasCS,
                                                                        )));
                                                      },
                                                      child: Icon(
                                                          Icons.chevron_right,
                                                          size: 50,
                                                          color: Color(
                                                              0xff007FFF))),
                                                  Text('Seleccionar',
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          color:
                                                              Color(0xff007FFF),
                                                          fontSize: 14.0))
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ));
                          });
                    } else {
                      return Swiper(
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            origenesCartesianos listaOrigenes =
                                snapshot.data[index];
                            return Scaffold(
                              body: Container(
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                  ),
                                  key: UniqueKey(),
                                  child: Center(
                                    child: Card(
                                      elevation: 14.0,
                                      child: Container(
                                        height: 600,
                                        width: 350,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/fondo_sistemas.png'),
                                              fit: BoxFit.cover,
                                            ),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10.0))),
                                        child: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Column(
                                            children: <Widget>[
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: RichText(
                                                    text: TextSpan(
                                                        children: <TextSpan>[
                                                      TextSpan(
                                                          text:
                                                              '    Plano Cartesiano',
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Roboto',
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 14.0)),
                                                    ])),
                                              ),
                                              Align(
                                                alignment: Alignment.bottomLeft,
                                                child: Text(
                                                  '    ${listaOrigenes.NOMBRE}',
                                                  style: TextStyle(
                                                      fontFamily: 'Roboto',
                                                      color: Colors.white,
                                                      fontSize: 14.0),
                                                ),
                                              ),
                                              SizedBox(height: 40.0),
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: RichText(
                                                    text: TextSpan(children: <
                                                        TextSpan>[
                                                  TextSpan(
                                                      text: 'DATUM \n',
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          color: Colors.black54,
                                                          fontSize: 12.0)),
                                                  TextSpan(
                                                      text:
                                                          'Magna Sirgas        ',
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          color:
                                                              Color(0xff007FFF),
                                                          fontSize: 14.0))
                                                ])),
                                              ),
                                              Divider(),
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: RichText(
                                                    text: TextSpan(children: <
                                                        TextSpan>[
                                                  TextSpan(
                                                      text: 'Elipsoide\n',
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          color: Colors.black54,
                                                          fontSize: 12.0)),
                                                  TextSpan(
                                                      text: 'GRS80        ',
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          color:
                                                              Color(0xff007FFF),
                                                          fontSize: 14.0))
                                                ])),
                                              ),
                                              SizedBox(
                                                height: 5.0,
                                              ),
                                              Align(
                                                alignment: Alignment.center,
                                                child: RichText(
                                                    text: TextSpan(children: <
                                                        TextSpan>[
                                                  TextSpan(
                                                      text:
                                                          '      Sistema de Proyección ',
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          color:
                                                              Color(0xff007FFF),
                                                          fontSize: 14.0)),
                                                ])),
                                              ),
                                              Divider(),
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: RichText(
                                                    text: TextSpan(children: <
                                                        TextSpan>[
                                                  TextSpan(
                                                      text: 'Proyección\n',
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          color: Colors.black54,
                                                          fontSize: 12.0)),
                                                  TextSpan(
                                                      text:
                                                          'Plano Cartesiano IGAC',
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          color:
                                                              Color(0xff007FFF),
                                                          fontSize: 14.0))
                                                ])),
                                              ),
                                              Divider(),
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: RichText(
                                                    text: TextSpan(children: <
                                                        TextSpan>[
                                                  TextSpan(
                                                      text:
                                                          'Latitud de Origen\n',
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          color: Colors.black54,
                                                          fontSize: 12.0)),
                                                  TextSpan(
                                                      text:
                                                          '${listaOrigenes.LATITUD.toString()}',
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          color:
                                                              Color(0xff007FFF),
                                                          fontSize: 14.0))
                                                ])),
                                              ),
                                              Divider(),
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: RichText(
                                                    text: TextSpan(children: <
                                                        TextSpan>[
                                                  TextSpan(
                                                      text:
                                                          'Longitud de Origen\n',
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          color: Colors.black54,
                                                          fontSize: 12.0)),
                                                  TextSpan(
                                                      text:
                                                          '${listaOrigenes.LONGITUD.toString()}',
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          color:
                                                              Color(0xff007FFF),
                                                          fontSize: 14.0))
                                                ])),
                                              ),
                                              Divider(),
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: RichText(
                                                    text: TextSpan(children: <
                                                        TextSpan>[
                                                  TextSpan(
                                                      text: 'Falso Norte\n',
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          color: Colors.black54,
                                                          fontSize: 12.0)),
                                                  TextSpan(
                                                      text:
                                                          '${listaOrigenes.NORTE.toString()} m',
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          color:
                                                              Color(0xff007FFF),
                                                          fontSize: 14.0))
                                                ])),
                                              ),
                                              Divider(),
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: RichText(
                                                    text: TextSpan(children: <
                                                        TextSpan>[
                                                  TextSpan(
                                                      text: 'Falso Este\n',
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          color: Colors.black54,
                                                          fontSize: 12.0)),
                                                  TextSpan(
                                                      text:
                                                          '${listaOrigenes.ESTE.toString()} m',
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          color:
                                                              Color(0xff007FFF),
                                                          fontSize: 14.0))
                                                ])),
                                              ),
                                              Divider(),
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: RichText(
                                                    text: TextSpan(children: <
                                                        TextSpan>[
                                                  TextSpan(
                                                      text:
                                                          'Altura del Plano\n',
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          color: Colors.black54,
                                                          fontSize: 12.0)),
                                                  TextSpan(
                                                      text:
                                                          '${listaOrigenes.PLANO_PROY} m',
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          color:
                                                              Color(0xff007FFF),
                                                          fontSize: 14.0))
                                                ])),
                                              ),
                                              Divider(),
                                              Align(
                                                alignment: Alignment.center,
                                                child: Center(
                                                  child: Column(
                                                    children: <Widget>[
                                                      FlatButton(
                                                        onPressed: () {
                                                          CartesianasCS
                                                              cartesianasCS =
                                                              CartesianasCS();
                                                          cartesianasCS.ESTE =
                                                              listaOrigenes
                                                                  .ESTE;
                                                          cartesianasCS.NORTE =
                                                              listaOrigenes
                                                                  .NORTE;
                                                          cartesianasCS
                                                                  .PLANO_PROY =
                                                              listaOrigenes
                                                                  .PLANO_PROY;
                                                          cartesianasCS
                                                                  .LATITUD =
                                                              listaOrigenes
                                                                  .LATITUD;
                                                          cartesianasCS
                                                                  .LONGITUD =
                                                              listaOrigenes
                                                                  .LONGITUD;
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          ConversionPunto(
                                                                            datosProyecto:
                                                                                widget.datosProyecto,
                                                                            cartesianasCS:
                                                                                cartesianasCS,
                                                                          )));
                                                        },
                                                        child: Icon(
                                                            Icons.chevron_right,
                                                            size: 50,
                                                            color: Color(
                                                                0xff007FFF)),
                                                      ),
                                                      Text('Seleccionar',
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Roboto',
                                                              color: Color(
                                                                  0xff007FFF),
                                                              fontSize: 14.0))
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  )),
                            );
                          });
                    }
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ));
  }

  void _sistemaGauss(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => Container(
            height: 500,
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Scaffold(
                  body: FutureBuilder<List<origenesGauss>>(
                    future: gestorMBDatabase.db.getGauss(),
                    builder:
                        (context, AsyncSnapshot<List<origenesGauss>> snapshot) {
                      if (snapshot.hasData) {
                        return Swiper(
                            layout: SwiperLayout.STACK,
                            itemWidth: MediaQuery.of(context).size.width * 0.8,
                            itemHeight:
                                MediaQuery.of(context).size.height * 0.8,
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, int index) {
                              origenesGauss listaOrigenes =
                                  snapshot.data[index];
                              return Container(
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                  ),
                                  key: UniqueKey(),
                                  child: Card(
                                    elevation: 14.0,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(
                                                'assets/images/fondo_sistemas.png'),
                                            fit: BoxFit.cover,
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0))),
                                      child: Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Column(
                                          children: <Widget>[
                                            SizedBox(height: 30.0),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: RichText(
                                                  text: TextSpan(
                                                      children: <TextSpan>[
                                                    TextSpan(
                                                        text: 'Gauss-Krüger',
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'Roboto',
                                                            color: Colors.white,
                                                            fontSize: 18.0)),
                                                  ])),
                                            ),
                                            Align(
                                              alignment: Alignment.bottomLeft,
                                              child: Text(
                                                '${listaOrigenes.NOMBRE}',
                                                style: TextStyle(
                                                    fontFamily: 'Roboto',
                                                    color: Colors.white,
                                                    fontSize: 18.0),
                                              ),
                                            ),
                                            SizedBox(height: 45.0),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: RichText(
                                                  text: TextSpan(children: <
                                                      TextSpan>[
                                                TextSpan(
                                                    text: 'DATUM: \n ',
                                                    style: TextStyle(
                                                        fontFamily: 'Roboto',
                                                        color: Colors.black54,
                                                        fontSize: 12.0)),
                                                TextSpan(
                                                    text: 'Magna Sirgas',
                                                    style: TextStyle(
                                                        fontFamily: 'Roboto',
                                                        color:
                                                            Color(0xff007FFF),
                                                        fontSize: 14.0))
                                              ])),
                                            ),
                                            Divider(),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: RichText(
                                                  text: TextSpan(children: <
                                                      TextSpan>[
                                                TextSpan(
                                                    text: 'Elipsoide: \n',
                                                    style: TextStyle(
                                                        fontFamily: 'Roboto',
                                                        color: Colors.black54,
                                                        fontSize: 12.0)),
                                                TextSpan(
                                                    text: 'GRS80',
                                                    style: TextStyle(
                                                        fontFamily: 'Roboto',
                                                        color:
                                                            Color(0xff007FFF),
                                                        fontSize: 14.0))
                                              ])),
                                            ),
                                            Divider(),
                                            Align(
                                              alignment: Alignment.center,
                                              child: RichText(
                                                  text: TextSpan(children: <
                                                      TextSpan>[
                                                TextSpan(
                                                    text:
                                                        'Sistema de Proyección',
                                                    style: TextStyle(
                                                        fontFamily: 'Roboto',
                                                        color:
                                                            Color(0xff007FFF),
                                                        fontSize: 15.0)),
                                              ])),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: RichText(
                                                  text: TextSpan(children: <
                                                      TextSpan>[
                                                TextSpan(
                                                    text: 'Proyección \n',
                                                    style: TextStyle(
                                                        fontFamily: 'Roboto',
                                                        color: Colors.black54,
                                                        fontSize: 12.0)),
                                                TextSpan(
                                                    text:
                                                        'Transversal de Mercator',
                                                    style: TextStyle(
                                                        fontFamily: 'Roboto',
                                                        color:
                                                            Color(0xff007FFF),
                                                        fontSize: 14.0))
                                              ])),
                                            ),
                                            Divider(),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: RichText(
                                                  text: TextSpan(children: <
                                                      TextSpan>[
                                                TextSpan(
                                                    text:
                                                        'Latitud de Origen \n',
                                                    style: TextStyle(
                                                        fontFamily: 'Roboto',
                                                        color: Colors.black54,
                                                        fontSize: 12.0)),
                                                TextSpan(
                                                    text:
                                                        '${listaOrigenes.LATITUD.toString()}',
                                                    style: TextStyle(
                                                        fontFamily: 'Roboto',
                                                        color:
                                                            Color(0xff007FFF),
                                                        fontSize: 14.0))
                                              ])),
                                            ),
                                            Divider(),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: RichText(
                                                  text: TextSpan(children: <
                                                      TextSpan>[
                                                TextSpan(
                                                    text:
                                                        'Longitud de Origen \n',
                                                    style: TextStyle(
                                                        fontFamily: 'Roboto',
                                                        color: Colors.black54,
                                                        fontSize: 12.0)),
                                                TextSpan(
                                                    text:
                                                        '${listaOrigenes.LONGITUD.toString()}',
                                                    style: TextStyle(
                                                        fontFamily: 'Roboto',
                                                        color:
                                                            Color(0xff007FFF),
                                                        fontSize: 14.0))
                                              ])),
                                            ),
                                            Divider(),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: RichText(
                                                  text: TextSpan(children: <
                                                      TextSpan>[
                                                TextSpan(
                                                    text: 'Falso Norte \n',
                                                    style: TextStyle(
                                                        fontFamily: 'Roboto',
                                                        color: Colors.black54,
                                                        fontSize: 12.0)),
                                                TextSpan(
                                                    text:
                                                        '${listaOrigenes.NORTE.toString()}00 m',
                                                    style: TextStyle(
                                                        fontFamily: 'Roboto',
                                                        color:
                                                            Color(0xff007FFF),
                                                        fontSize: 14.0))
                                              ])),
                                            ),
                                            Divider(),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: RichText(
                                                  text: TextSpan(children: <
                                                      TextSpan>[
                                                TextSpan(
                                                    text: 'Falso Este \n',
                                                    style: TextStyle(
                                                        fontFamily: 'Roboto',
                                                        color: Colors.black54,
                                                        fontSize: 12.0)),
                                                TextSpan(
                                                    text:
                                                        '${listaOrigenes.ESTE.toString()} m',
                                                    style: TextStyle(
                                                        fontFamily: 'Roboto',
                                                        color:
                                                            Color(0xff007FFF),
                                                        fontSize: 14.0))
                                              ])),
                                            ),
                                            Divider(),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: RichText(
                                                  text: TextSpan(children: <
                                                      TextSpan>[
                                                TextSpan(
                                                    text: 'Factor de Escala\n ',
                                                    style: TextStyle(
                                                        fontFamily: 'Roboto',
                                                        color: Colors.black54,
                                                        fontSize: 12.0)),
                                                TextSpan(
                                                    text: '1.000000000',
                                                    style: TextStyle(
                                                        fontFamily: 'Roboto',
                                                        color:
                                                            Color(0xff007FFF),
                                                        fontSize: 14.0))
                                              ])),
                                            ),
                                            Divider(),
                                            Align(
                                              alignment: Alignment.center,
                                              child: Center(
                                                child: Column(
                                                  children: <Widget>[
                                                    FlatButton(
                                                        onPressed: () {
                                                          GaussCS gaussC =
                                                              GaussCS();
                                                          gaussC.NORTE =
                                                              listaOrigenes
                                                                  .NORTE;
                                                          gaussC.ESTE =
                                                              listaOrigenes
                                                                  .ESTE;
                                                          gaussC.LATITUD =
                                                              listaOrigenes
                                                                  .LATITUD;
                                                          gaussC.LONGITUD =
                                                              listaOrigenes
                                                                  .LONGITUD;
                                                          gaussC.NOMBRE =
                                                              listaOrigenes
                                                                  .NOMBRE;
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          ConversionPunto(
                                                                            datosProyecto:
                                                                                widget.datosProyecto,
                                                                            sistemaOrigen:
                                                                                'Coordenadas Gauss - Krüger',
                                                                            gaussCS:
                                                                                gaussC,
                                                                          )));
                                                        },
                                                        child: Icon(
                                                            Icons.chevron_right,
                                                            size: 50,
                                                            color: Color(
                                                                0xff007FFF))),
                                                    Text('Seleccionar',
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'Roboto',
                                                            color: Color(
                                                                0xff007FFF),
                                                            fontSize: 14.0))
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ));
                            });
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ))));
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
              child: Text('      Importar Coordenadas otro proyección',
                  style: TextStyle(fontSize: 12, color: Colors.white)),
            ),
          )
        ],
      ),
    );
  }
}
