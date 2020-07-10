import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:measurebookapp/clases/conversionCoordenadasMB.dart';
import 'package:measurebookapp/clases/database.dart';
import 'package:measurebookapp/main.dart';
import 'package:measurebookapp/modelos/cPlanasGenerico.dart';
import 'package:measurebookapp/modelos/cartesianasCS.dart';
import 'package:measurebookapp/modelos/coordenadasCartesianas.dart';
import 'package:measurebookapp/modelos/coordenadasElipsoidales.dart';
import 'package:measurebookapp/modelos/coordenadasGeocenticas.dart';
import 'package:measurebookapp/modelos/coordenadasON.dart';
import 'package:measurebookapp/modelos/coordenadasPlanasGauss.dart';
import 'package:measurebookapp/modelos/gaussCS.dart';
import 'package:measurebookapp/modelos/proyectos.dart';
import 'package:measurebookapp/pages/conversionCoordenadas.dart';
import 'package:measurebookapp/pages/gestorPuntos.dart';
import 'package:measurebookapp/pages/menuPrincipal.dart';
import 'package:measurebookapp/pages/nivelaciones.dart';
import 'package:measurebookapp/pages/observacionesGNSS/observacionGNSSVertice.dart';
import 'package:measurebookapp/pages/poligonales/poligonalesMain.dart';
import 'package:measurebookapp/pages/puntoIgacImportado.dart';
import 'dart:math' as m;

class ConversionPunto extends StatefulWidget {
  final proyectos datosProyecto;
  final String sistemaOrigen;
  final CartesianasCS cartesianasCS;
  final GaussCS gaussCS;
  ConversionPunto(
      {Key key,
      this.datosProyecto,
      this.sistemaOrigen,
      this.cartesianasCS,
      this.gaussCS})
      : super(key: key);
  @override
  _ConversionPuntoState createState() => _ConversionPuntoState();
}

final GlobalKey<FormState> _formElipsoidales = GlobalKey<FormState>();
final GlobalKey<FormState> _formElipsoidalesHexa = GlobalKey<FormState>();
final GlobalKey<FormState> _formGeocentricas = GlobalKey<FormState>();
final GlobalKey<FormState> _formCartesianas = GlobalKey<FormState>();
String valorNS = 'Norte';
String valorEO = 'Oeste';
double latitudepunto, longitudPunto, alturaPunto;
double gradosLatitudF, minutosLatitudF, segundosLatitudF;
double gradosLongitudF, minutosLongitudF, segundosLongitudF;
double altura;
double xGeocentricaF, yGeocentricaF, zGeocentricaF;
double norteCartesianas, esteCartesianas, alturaCartesianas;
double norteGauss, esteGauss, alturaGauss;

class _ConversionPuntoState extends State<ConversionPunto> {
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
      CoordenadasON coordenadasON = CoordenadasON();
      coordenadasON = conversionCoordenadasMB
          .elipsoidales2GaussNuevo(coordenadasElipsoidales);
      CPlanasGenerico cPlanasGenerico = CPlanasGenerico();
      cPlanasGenerico.norte = coordenadasON.norte;
      cPlanasGenerico.este = coordenadasON.este;
      cPlanasGenerico.altura = alturaPunto;
      return cPlanasGenerico;
    }
  }

  double roundDouble(double value, int places) {
    double mod = m.pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
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

    // Importar Coordenadas Elipsoidales en formato decimal
    if (widget.sistemaOrigen == 'Coordenadas Elipsoidales') {
      if (widget.datosProyecto.Tipo_Proyeccion == 'Plano Cartesiano') {
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
                                        borderRadius:
                                            BorderRadius.circular(10)),
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
            child: Form(
              key: _formElipsoidales,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      'Coordenadas Elipsoidales',
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 16.0,
                      ),
                    ),
                    Image.asset('assets/images/elipsoidal.png'),
                    TextFormField(
                      decoration: InputDecoration(
                        icon: Icon(Icons.add_location),
                        labelText: 'Latitud',
                      ),
                      keyboardType: TextInputType.numberWithOptions(
                          signed: true, decimal: true),
                      validator: (String latitude) {
                        double latitudPuntoII = double.tryParse(latitude);
                        if (latitudPuntoII == null) {
                          return 'Ingrese la Latitud en formato Decimal';
                        } else {
                          if (double.parse(latitude) > -90 &&
                              double.parse(latitude) < 90) {
                            double latitudepuntoII = double.parse(latitude);
                            latitudepunto = latitudepuntoII;
                            return null;
                          } else {
                            return 'El valor Ingresado está por fuera del rango  (-90° a 90°)';
                          }
                        }
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        icon: Icon(Icons.add_location),
                        labelText: 'Longitud',
                      ),
                      keyboardType: TextInputType.number,
                      //inputFormatters: [WhitelistingTextInputFormatter(RegExp(r'^(-?[0-9]+([.][0-9]*)?|[.][0-9]+)$'))],
                      validator: (String longitud) {
                        double longitudPuntoII = double.tryParse(longitud);
                        if (longitudPuntoII == null) {
                          return 'Ingrese la Longitud en formato Decimal';
                        } else {
                          if (double.parse(longitud) > -90 &&
                              double.parse(longitud) < 90) {
                            longitudPuntoII = double.parse(longitud);
                            longitudPunto = longitudPuntoII;
                            return null;
                          } else {
                            return 'El valor Ingresado está por fuera del rango  (-180° a 180°)';
                          }
                        }
                      },
                    ),
                    TextFormField(
                        decoration: InputDecoration(
                          icon: Icon(Icons.add_location),
                          labelText: 'Altura',
                        ),
                        keyboardType: TextInputType.numberWithOptions(
                          signed: true,
                        ),
                        inputFormatters: [
                          WhitelistingTextInputFormatter(new RegExp(
                              r'^[+-]?([0-9]+([.][0-9]*)?|[.][0-9]+)$'))
                        ],
                        validator: (String altura) {
                          double heigh = double.tryParse(altura);
                          if (heigh == null) {
                            return 'Valor de Altura no valido';
                          } else {
                            alturaPunto = heigh;
                            return null;
                          }
                        }),
                    FlatButton(
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(20.0)),
                        child: Text(
                          'Importar',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 12.0,
                            color: Colors.white,
                          ),
                        ),
                        color: Color(0xff007FFF),
                        onPressed: () async {
                          if (_formElipsoidales.currentState.validate()) {
                            CPlanasGenerico planasGenerico =
                                await coordenadasInportadas(
                                    latitudepunto, longitudPunto, alturaPunto);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PuntoIgacImportado(
                                    altura: planasGenerico.altura,
                                    este: roundDouble(planasGenerico.este, 3),
                                    nombrePunto: 'SIN NOMBRAR',
                                    ondulacion: 0,
                                    norte: roundDouble(planasGenerico.norte, 3),
                                    datosProyecto: widget.datosProyecto,
                                  ),
                                ));
                          }
                        })
                  ],
                ),
              ),
            ),
          )),
        );
      } else if (widget.datosProyecto.Tipo_Proyeccion == 'Gauss-Krüger') {
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
                                        borderRadius:
                                            BorderRadius.circular(10)),
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
            child: Form(
              key: _formElipsoidales,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      'Coordenadas Elipsoidales',
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 16.0,
                      ),
                    ),
                    Image.asset('assets/images/elipsoidal.png'),
                    TextFormField(
                      decoration: InputDecoration(
                        icon: Icon(Icons.add_location),
                        labelText: 'Latitud',
                      ),
                      keyboardType: TextInputType.numberWithOptions(
                          signed: true, decimal: true),
                      //inputFormatters: [WhitelistingTextInputFormatter(RegExp(r'^[+-]?:-?([0-9]+([.][0-9]*)?|[.][0-9]+)$'))],
                      validator: (String latitude) {
                        double latitudPuntoII = double.tryParse(latitude);
                        if (latitudPuntoII == null) {
                          return 'Ingrese la Latitud en formato Decimal';
                        } else {
                          if (double.parse(latitude) > -90 &&
                              double.parse(latitude) < 90) {
                            double latitudepuntoII = double.parse(latitude);
                            latitudepunto = latitudepuntoII;
                            return null;
                          } else {
                            return 'El valor Ingresado está por fuera del rango  (-90° a 90°)';
                          }
                        }
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        icon: Icon(Icons.add_location),
                        labelText: 'Longitud',
                      ),
                      keyboardType: TextInputType.number,
                      //inputFormatters: [WhitelistingTextInputFormatter(RegExp(r'^(-?[0-9]+([.][0-9]*)?|[.][0-9]+)$'))],
                      validator: (String longitud) {
                        double longitudPuntoII = double.tryParse(longitud);
                        if (longitudPuntoII == null) {
                          return 'Ingrese la Longitud en formato Decimal';
                        } else {
                          if (double.parse(longitud) > -90 &&
                              double.parse(longitud) < 90) {
                            longitudPuntoII = double.parse(longitud);
                            longitudPunto = longitudPuntoII;
                            return null;
                          } else {
                            return 'El valor Ingresado está por fuera del rango  (-180° a 180°)';
                          }
                        }
                      },
                    ),
                    TextFormField(
                        decoration: InputDecoration(
                          icon: Icon(Icons.add_location),
                          labelText: 'Altura',
                        ),
                        keyboardType: TextInputType.numberWithOptions(
                          signed: true,
                        ),
                        inputFormatters: [
                          WhitelistingTextInputFormatter(new RegExp(
                              r'^[+-]?([0-9]+([.][0-9]*)?|[.][0-9]+)$'))
                        ],
                        validator: (String altura) {
                          double heigh = double.tryParse(altura);
                          if (heigh == null) {
                            return 'Valor de Altura no valido';
                          } else {
                            alturaPunto = heigh;
                            return null;
                          }
                        }),
                    FlatButton(
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(20.0)),
                        child: Text(
                          'Importar',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 12.0,
                            color: Colors.white,
                          ),
                        ),
                        color: Color(0xff007FFF),
                        onPressed: () async {
                          if (_formElipsoidales.currentState.validate()) {
                            CPlanasGenerico planasGenerico =
                                await coordenadasInportadas(
                                    latitudepunto, longitudPunto, alturaPunto);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PuntoIgacImportado(
                                    altura: planasGenerico.altura,
                                    este: roundDouble(planasGenerico.este, 3),
                                    nombrePunto: 'SIN NOMBRAR',
                                    ondulacion: 0,
                                    norte: roundDouble(planasGenerico.norte, 3),
                                    datosProyecto: widget.datosProyecto,
                                  ),
                                ));
                          }
                        })
                  ],
                ),
              ),
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
                                        borderRadius:
                                            BorderRadius.circular(10)),
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
            child: Form(
              key: _formElipsoidales,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      'Coordenadas Elipsoidales',
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 16.0,
                      ),
                    ),
                    Image.asset('assets/images/elipsoidal.png'),
                    TextFormField(
                      decoration: InputDecoration(
                        icon: Icon(Icons.add_location),
                        labelText: 'Latitud',
                      ),
                      keyboardType: TextInputType.numberWithOptions(
                          signed: true, decimal: true),
                      //inputFormatters: [WhitelistingTextInputFormatter(RegExp(r'^[+-]?:-?([0-9]+([.][0-9]*)?|[.][0-9]+)$'))],
                      validator: (String latitude) {
                        double latitudPuntoII = double.tryParse(latitude);
                        if (latitudPuntoII == null) {
                          return 'Ingrese la Latitud en formato Decimal';
                        } else {
                          if (double.parse(latitude) > -90 &&
                              double.parse(latitude) < 90) {
                            double latitudepuntoII = double.parse(latitude);
                            latitudepunto = latitudepuntoII;
                            return null;
                          } else {
                            return 'El valor Ingresado está por fuera del rango  (-90° a 90°)';
                          }
                        }
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        icon: Icon(Icons.add_location),
                        labelText: 'Longitud',
                      ),
                      keyboardType: TextInputType.number,
                      //inputFormatters: [WhitelistingTextInputFormatter(RegExp(r'^(-?[0-9]+([.][0-9]*)?|[.][0-9]+)$'))],
                      validator: (String longitud) {
                        double longitudPuntoII = double.tryParse(longitud);
                        if (longitudPuntoII == null) {
                          return 'Ingrese la Longitud en formato Decimal';
                        } else {
                          if (double.parse(longitud) > -90 &&
                              double.parse(longitud) < 90) {
                            longitudPuntoII = double.parse(longitud);
                            longitudPunto = longitudPuntoII;
                            return null;
                          } else {
                            return 'El valor Ingresado está por fuera del rango  (-180° a 180°)';
                          }
                        }
                      },
                    ),
                    TextFormField(
                        decoration: InputDecoration(
                          icon: Icon(Icons.add_location),
                          labelText: 'Altura',
                        ),
                        keyboardType: TextInputType.numberWithOptions(
                          signed: true,
                        ),
                        inputFormatters: [
                          WhitelistingTextInputFormatter(new RegExp(
                              r'^[+-]?([0-9]+([.][0-9]*)?|[.][0-9]+)$'))
                        ],
                        validator: (String altura) {
                          double heigh = double.tryParse(altura);
                          if (heigh == null) {
                            return 'Valor de Altura no valido';
                          } else {
                            alturaPunto = heigh;
                            return null;
                          }
                        }),
                    FlatButton(
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(20.0)),
                        child: Text(
                          'Importar',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 12.0,
                            color: Colors.white,
                          ),
                        ),
                        color: Color(0xff007FFF),
                        onPressed: () async {
                          if (_formElipsoidales.currentState.validate()) {
                            CPlanasGenerico planasGenerico =
                                await coordenadasInportadas(
                                    latitudepunto, longitudPunto, alturaPunto);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PuntoIgacImportado(
                                    altura: planasGenerico.altura,
                                    este: roundDouble(planasGenerico.este, 3),
                                    nombrePunto: 'SIN NOMBRAR',
                                    ondulacion: 0,
                                    norte: roundDouble(planasGenerico.norte, 3),
                                    datosProyecto: widget.datosProyecto,
                                  ),
                                ));
                          }
                        })
                  ],
                ),
              ),
            ),
          )),
        );
      }
    } else if (widget.sistemaOrigen == 'Coordenadas Geocéntricas') {
      if (widget.datosProyecto.Tipo_Proyeccion == 'Plano Cartesiano') {
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
                                        borderRadius:
                                            BorderRadius.circular(10)),
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
            child: Center(
              child: Column(
                children: <Widget>[
                  Form(
                    key: _formGeocentricas,
                    child: Padding(
                      padding: const EdgeInsets.all(30),
                      child: Column(
                        children: <Widget>[
                          Center(
                            child: Column(
                              children: <Widget>[
                                Text(
                                  'Coordenadas Geocéntricas',
                                  style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontSize: 16.0,
                                  ),
                                ),
                                Divider(
                                  height: 20,
                                ),
                                Image.asset(
                                  'assets/images/geocentrica.png',
                                  height: 300,
                                  alignment: Alignment.center,
                                ),
                                Divider(),
                                TextFormField(
                                  decoration: InputDecoration(
                                    icon: Icon(Icons.add_location),
                                    labelText: 'Coordenada X Geocéntrica',
                                  ),
                                  keyboardType: TextInputType.number,
                                  validator: (String xGeo) {
                                    double xGeocentrica = double.tryParse(xGeo);
                                    if (xGeocentrica == null) {
                                      return 'La Coordenada X, está en un formato no valido';
                                    } else {
                                      setState(() {
                                        xGeocentricaF = xGeocentrica;
                                      });
                                      return null;
                                    }
                                  },
                                ),
                                TextFormField(
                                  decoration: InputDecoration(
                                    icon: Icon(Icons.add_location),
                                    labelText: 'Coordenada Y Geocéntrica',
                                  ),
                                  keyboardType: TextInputType.number,
                                  validator: (String yGeo) {
                                    double yGeocentrica = double.tryParse(yGeo);
                                    if (yGeocentrica == null) {
                                      return 'La Coordenada Y, está en un formato no valido';
                                    } else {
                                      setState(() {
                                        yGeocentricaF = yGeocentrica;
                                      });
                                      return null;
                                    }
                                  },
                                ),
                                TextFormField(
                                  decoration: InputDecoration(
                                    icon: Icon(Icons.add_location),
                                    labelText: 'Coordenada Z Geocéntrica',
                                  ),
                                  keyboardType: TextInputType.number,
                                  validator: (String zGeo) {
                                    double zGeocentrica = double.tryParse(zGeo);
                                    if (zGeocentrica == null) {
                                      return 'La Coordenada Z, está en un formato no valido';
                                    } else {
                                      setState(() {
                                        zGeocentricaF = zGeocentrica;
                                      });
                                      return null;
                                    }
                                  },
                                ),
                                Divider(height: 30.0),
                              ],
                            ),
                          ),
                          FlatButton(
                              shape: new RoundedRectangleBorder(
                                  borderRadius:
                                      new BorderRadius.circular(20.0)),
                              child: Text(
                                'Importar',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 12.0,
                                  color: Colors.white,
                                ),
                              ),
                              color: Color(0xff007FFF),
                              onPressed: () async {
                                if (_formGeocentricas.currentState.validate()) {
                                  ConversionCoordenadasMB
                                      conversionCoordenadasMB =
                                      ConversionCoordenadasMB();
                                  CoordenadasGeocentricas
                                      coordenadasGeocentricas =
                                      CoordenadasGeocentricas();
                                  coordenadasGeocentricas.x = xGeocentricaF;
                                  coordenadasGeocentricas.y = yGeocentricaF;
                                  coordenadasGeocentricas.z = zGeocentricaF;
                                  CoordenadasElipsoidales
                                      coordenadasElipsoidales =
                                      conversionCoordenadasMB
                                          .geocentricas2Elipsoidales(
                                              coordenadasGeocentricas);
                                  CPlanasGenerico planasGenerico =
                                      await coordenadasInportadas(
                                          coordenadasElipsoidales.latitud,
                                          coordenadasElipsoidales.longitud,
                                          coordenadasElipsoidales.altitud);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            PuntoIgacImportado(
                                          altura: planasGenerico.altura,
                                          este: roundDouble(
                                              planasGenerico.este, 3),
                                          nombrePunto: 'SIN NOMBRAR',
                                          ondulacion: 0,
                                          norte: roundDouble(
                                              planasGenerico.norte, 3),
                                          datosProyecto: widget.datosProyecto,
                                        ),
                                      ));
                                }
                              })
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
        );
      } else if (widget.datosProyecto.Tipo_Proyeccion == 'Gauss-Krüger') {
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
                                        borderRadius:
                                            BorderRadius.circular(10)),
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
            child: Center(
              child: Column(
                children: <Widget>[
                  Form(
                    key: _formGeocentricas,
                    child: Padding(
                      padding: const EdgeInsets.all(30),
                      child: Column(
                        children: <Widget>[
                          Center(
                            child: Column(
                              children: <Widget>[
                                Text(
                                  'Coordenadas Geocéntricas',
                                  style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontSize: 16.0,
                                  ),
                                ),
                                Divider(
                                  height: 20,
                                ),
                                Image.asset(
                                  'assets/images/geocentrica.png',
                                  height: 300,
                                  alignment: Alignment.center,
                                ),
                                Divider(),
                                TextFormField(
                                  decoration: InputDecoration(
                                    icon: Icon(Icons.add_location),
                                    labelText: 'Coordenada X Geocéntrica',
                                  ),
                                  keyboardType: TextInputType.number,
                                  validator: (String xGeo) {
                                    double xGeocentrica = double.tryParse(xGeo);
                                    if (xGeocentrica == null) {
                                      return 'La Coordenada X, está en un formato no valido';
                                    } else {
                                      setState(() {
                                        xGeocentricaF = xGeocentrica;
                                      });
                                      return null;
                                    }
                                  },
                                ),
                                TextFormField(
                                  decoration: InputDecoration(
                                    icon: Icon(Icons.add_location),
                                    labelText: 'Coordenada Y Geocéntrica',
                                  ),
                                  keyboardType: TextInputType.number,
                                  validator: (String yGeo) {
                                    double yGeocentrica = double.tryParse(yGeo);
                                    if (yGeocentrica == null) {
                                      return 'La Coordenada Y, está en un formato no valido';
                                    } else {
                                      setState(() {
                                        yGeocentricaF = yGeocentrica;
                                      });
                                      return null;
                                    }
                                  },
                                ),
                                TextFormField(
                                  decoration: InputDecoration(
                                    icon: Icon(Icons.add_location),
                                    labelText: 'Coordenada Z Geocéntrica',
                                  ),
                                  keyboardType: TextInputType.number,
                                  validator: (String zGeo) {
                                    double zGeocentrica = double.tryParse(zGeo);
                                    if (zGeocentrica == null) {
                                      return 'La Coordenada Z, está en un formato no valido';
                                    } else {
                                      setState(() {
                                        zGeocentricaF = zGeocentrica;
                                      });
                                      return null;
                                    }
                                  },
                                ),
                                Divider(height: 30.0),
                              ],
                            ),
                          ),
                          FlatButton(
                              shape: new RoundedRectangleBorder(
                                  borderRadius:
                                      new BorderRadius.circular(20.0)),
                              child: Text(
                                'Importar',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 12.0,
                                  color: Colors.white,
                                ),
                              ),
                              color: Color(0xff007FFF),
                              onPressed: () async {
                                if (_formGeocentricas.currentState.validate()) {
                                  ConversionCoordenadasMB
                                      conversionCoordenadasMB =
                                      ConversionCoordenadasMB();
                                  CoordenadasGeocentricas
                                      coordenadasGeocentricas =
                                      CoordenadasGeocentricas();
                                  coordenadasGeocentricas.x = xGeocentricaF;
                                  coordenadasGeocentricas.y = yGeocentricaF;
                                  coordenadasGeocentricas.z = zGeocentricaF;
                                  CoordenadasElipsoidales
                                      coordenadasElipsoidales =
                                      conversionCoordenadasMB
                                          .geocentricas2Elipsoidales(
                                              coordenadasGeocentricas);
                                  CPlanasGenerico planasGenerico =
                                      await coordenadasInportadas(
                                          coordenadasElipsoidales.latitud,
                                          coordenadasElipsoidales.longitud,
                                          coordenadasElipsoidales.altitud);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            PuntoIgacImportado(
                                          altura: planasGenerico.altura,
                                          este: roundDouble(
                                              planasGenerico.este, 3),
                                          nombrePunto: 'SIN NOMBRAR',
                                          ondulacion: 0,
                                          norte: roundDouble(
                                              planasGenerico.norte, 3),
                                          datosProyecto: widget.datosProyecto,
                                        ),
                                      ));
                                }
                              })
                        ],
                      ),
                    ),
                  ),
                ],
              ),
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
                                        borderRadius:
                                            BorderRadius.circular(10)),
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
            child: Center(
              child: Column(
                children: <Widget>[
                  Form(
                    key: _formGeocentricas,
                    child: Padding(
                      padding: const EdgeInsets.all(30),
                      child: Column(
                        children: <Widget>[
                          Center(
                            child: Column(
                              children: <Widget>[
                                Text(
                                  'Coordenadas Geocéntricas',
                                  style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontSize: 16.0,
                                  ),
                                ),
                                Divider(
                                  height: 20,
                                ),
                                Image.asset(
                                  'assets/images/geocentrica.png',
                                  height: 300,
                                  alignment: Alignment.center,
                                ),
                                Divider(),
                                TextFormField(
                                  decoration: InputDecoration(
                                    icon: Icon(Icons.add_location),
                                    labelText: 'Coordenada X Geocéntrica',
                                  ),
                                  keyboardType: TextInputType.number,
                                  validator: (String xGeo) {
                                    double xGeocentrica = double.tryParse(xGeo);
                                    if (xGeocentrica == null) {
                                      return 'La Coordenada X, está en un formato no valido';
                                    } else {
                                      setState(() {
                                        xGeocentricaF = xGeocentrica;
                                      });
                                      return null;
                                    }
                                  },
                                ),
                                TextFormField(
                                  decoration: InputDecoration(
                                    icon: Icon(Icons.add_location),
                                    labelText: 'Coordenada Y Geocéntrica',
                                  ),
                                  keyboardType: TextInputType.number,
                                  validator: (String yGeo) {
                                    double yGeocentrica = double.tryParse(yGeo);
                                    if (yGeocentrica == null) {
                                      return 'La Coordenada Y, está en un formato no valido';
                                    } else {
                                      setState(() {
                                        yGeocentricaF = yGeocentrica;
                                      });
                                      return null;
                                    }
                                  },
                                ),
                                TextFormField(
                                  decoration: InputDecoration(
                                    icon: Icon(Icons.add_location),
                                    labelText: 'Coordenada Z Geocéntrica',
                                  ),
                                  keyboardType: TextInputType.number,
                                  validator: (String zGeo) {
                                    double zGeocentrica = double.tryParse(zGeo);
                                    if (zGeocentrica == null) {
                                      return 'La Coordenada Z, está en un formato no valido';
                                    } else {
                                      setState(() {
                                        zGeocentricaF = zGeocentrica;
                                      });
                                      return null;
                                    }
                                  },
                                ),
                                Divider(height: 30.0),
                              ],
                            ),
                          ),
                          FlatButton(
                              shape: new RoundedRectangleBorder(
                                  borderRadius:
                                      new BorderRadius.circular(20.0)),
                              child: Text(
                                'Importar',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 12.0,
                                  color: Colors.white,
                                ),
                              ),
                              color: Color(0xff007FFF),
                              onPressed: () async {
                                if (_formGeocentricas.currentState.validate()) {
                                  ConversionCoordenadasMB
                                      conversionCoordenadasMB =
                                      ConversionCoordenadasMB();
                                  CoordenadasGeocentricas
                                      coordenadasGeocentricas =
                                      CoordenadasGeocentricas();
                                  coordenadasGeocentricas.x = xGeocentricaF;
                                  coordenadasGeocentricas.y = yGeocentricaF;
                                  coordenadasGeocentricas.z = zGeocentricaF;
                                  CoordenadasElipsoidales
                                      coordenadasElipsoidales =
                                      conversionCoordenadasMB
                                          .geocentricas2Elipsoidales(
                                              coordenadasGeocentricas);
                                  CPlanasGenerico planasGenerico =
                                      await coordenadasInportadas(
                                          coordenadasElipsoidales.latitud,
                                          coordenadasElipsoidales.longitud,
                                          coordenadasElipsoidales.altitud);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            PuntoIgacImportado(
                                          altura: planasGenerico.altura,
                                          este: roundDouble(
                                              planasGenerico.este, 3),
                                          nombrePunto: 'SIN NOMBRAR',
                                          ondulacion: 0,
                                          norte: roundDouble(
                                              planasGenerico.norte, 3),
                                          datosProyecto: widget.datosProyecto,
                                        ),
                                      ));
                                }
                              })
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
        );
      }
    } else if (widget.sistemaOrigen == 'Coordenadas Gauss - Krüger') {
      if (widget.datosProyecto.Tipo_Proyeccion == 'Plano Cartesiano') {
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
                                        borderRadius:
                                            BorderRadius.circular(10)),
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
            child: Center(
              child: Column(
                children: <Widget>[
                  Form(
                    key: _formCartesianas,
                    child: Padding(
                      padding: const EdgeInsets.all(30),
                      child: Column(
                        children: <Widget>[
                          Center(
                            child: Column(
                              children: <Widget>[
                                Text(
                                  'Coordenadas Gauss Krüger',
                                  style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontSize: 16.0,
                                  ),
                                ),
                                Divider(
                                  height: 20,
                                ),
                                Image.asset(
                                  'assets/images/geocentrica.png',
                                  height: 300,
                                  alignment: Alignment.center,
                                ),
                                Divider(),
                                TextFormField(
                                  decoration: InputDecoration(
                                    icon: Icon(Icons.add_location),
                                    labelText: 'Coordenada Norte',
                                  ),
                                  keyboardType: TextInputType.number,
                                  validator: (String nGa) {
                                    double nGauss = double.tryParse(nGa);
                                    if (nGauss == null) {
                                      return 'La Coordenada Norte, está en un formato no valido';
                                    } else {
                                      setState(() {
                                        norteGauss = nGauss;
                                      });
                                      return null;
                                    }
                                  },
                                ),
                                TextFormField(
                                  decoration: InputDecoration(
                                    icon: Icon(Icons.add_location),
                                    labelText: 'Coordenada Este',
                                  ),
                                  keyboardType: TextInputType.number,
                                  validator: (String eGa) {
                                    double eGauss = double.tryParse(eGa);
                                    if (eGauss == null) {
                                      return 'La Coordenada Este, está en un formato no valido';
                                    } else {
                                      setState(() {
                                        esteGauss = eGauss;
                                      });
                                      return null;
                                    }
                                  },
                                ),
                                TextFormField(
                                  decoration: InputDecoration(
                                    icon: Icon(Icons.add_location),
                                    labelText: 'Altura',
                                  ),
                                  keyboardType: TextInputType.number,
                                  validator: (String aGa) {
                                    double aGausss = double.tryParse(aGa);
                                    if (aGausss == null) {
                                      return 'La Altura, está en un formato no valido';
                                    } else {
                                      setState(() {
                                        alturaGauss = aGausss;
                                      });
                                      return null;
                                    }
                                  },
                                ),
                                Divider(height: 30.0),
                              ],
                            ),
                          ),
                          FlatButton(
                              shape: new RoundedRectangleBorder(
                                  borderRadius:
                                      new BorderRadius.circular(20.0)),
                              child: Text(
                                'Importar',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 12.0,
                                  color: Colors.white,
                                ),
                              ),
                              color: Color(0xff007FFF),
                              onPressed: () async {
                                if (_formCartesianas.currentState.validate()) {
                                  ConversionCoordenadasMB
                                      conversionCoordenadasMB =
                                      ConversionCoordenadasMB();
                                  CoordenadasGauss coordenadasGauss =
                                      CoordenadasGauss();
                                  coordenadasGauss.este = esteGauss;
                                  coordenadasGauss.norte = norteGauss;
                                  coordenadasGauss.altura = alturaGauss;
                                  CoordenadasElipsoidales
                                      coordenadasElipsoidales =
                                      conversionCoordenadasMB
                                          .gauss2Elipsoidales(
                                              widget.gaussCS, coordenadasGauss);
                                  CPlanasGenerico planasGenerico =
                                      await coordenadasInportadas(
                                          coordenadasElipsoidales.latitud,
                                          coordenadasElipsoidales.longitud,
                                          coordenadasElipsoidales.altitud);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            PuntoIgacImportado(
                                          altura: planasGenerico.altura,
                                          este: roundDouble(
                                              planasGenerico.este, 3),
                                          nombrePunto: 'SIN NOMBRAR',
                                          ondulacion: 0,
                                          norte: roundDouble(
                                              planasGenerico.norte, 3),
                                          datosProyecto: widget.datosProyecto,
                                        ),
                                      ));
                                }
                              })
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
        );
      } else if (widget.datosProyecto.Tipo_Proyeccion == 'Gauss-Krüger') {
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
                                        borderRadius:
                                            BorderRadius.circular(10)),
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
            child: Center(
              child: Column(
                children: <Widget>[
                  Form(
                    key: _formCartesianas,
                    child: Padding(
                      padding: const EdgeInsets.all(30),
                      child: Column(
                        children: <Widget>[
                          Center(
                            child: Column(
                              children: <Widget>[
                                Text(
                                  'Coordenadas Gauss Krüger',
                                  style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontSize: 16.0,
                                  ),
                                ),
                                Divider(
                                  height: 20,
                                ),
                                Image.asset(
                                  'assets/images/geocentrica.png',
                                  height: 300,
                                  alignment: Alignment.center,
                                ),
                                Divider(),
                                TextFormField(
                                  decoration: InputDecoration(
                                    icon: Icon(Icons.add_location),
                                    labelText: 'Coordenada Norte',
                                  ),
                                  keyboardType: TextInputType.number,
                                  validator: (String nGa) {
                                    double nGauss = double.tryParse(nGa);
                                    if (nGauss == null) {
                                      return 'La Coordenada Norte, está en un formato no valido';
                                    } else {
                                      setState(() {
                                        norteGauss = nGauss;
                                      });
                                      return null;
                                    }
                                  },
                                ),
                                TextFormField(
                                  decoration: InputDecoration(
                                    icon: Icon(Icons.add_location),
                                    labelText: 'Coordenada Este',
                                  ),
                                  keyboardType: TextInputType.number,
                                  validator: (String eGa) {
                                    double eGauss = double.tryParse(eGa);
                                    if (eGauss == null) {
                                      return 'La Coordenada Este, está en un formato no valido';
                                    } else {
                                      setState(() {
                                        esteGauss = eGauss;
                                      });
                                      return null;
                                    }
                                  },
                                ),
                                TextFormField(
                                  decoration: InputDecoration(
                                    icon: Icon(Icons.add_location),
                                    labelText: 'Altura',
                                  ),
                                  keyboardType: TextInputType.number,
                                  validator: (String aGa) {
                                    double aGausss = double.tryParse(aGa);
                                    if (aGausss == null) {
                                      return 'La Altura, está en un formato no valido';
                                    } else {
                                      setState(() {
                                        alturaGauss = aGausss;
                                      });
                                      return null;
                                    }
                                  },
                                ),
                                Divider(height: 30.0),
                              ],
                            ),
                          ),
                          FlatButton(
                              shape: new RoundedRectangleBorder(
                                  borderRadius:
                                      new BorderRadius.circular(20.0)),
                              child: Text(
                                'Importar',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 12.0,
                                  color: Colors.white,
                                ),
                              ),
                              color: Color(0xff007FFF),
                              onPressed: () async {
                                if (_formCartesianas.currentState.validate()) {
                                  ConversionCoordenadasMB
                                      conversionCoordenadasMB =
                                      ConversionCoordenadasMB();
                                  CoordenadasGauss coordenadasGauss =
                                      CoordenadasGauss();
                                  coordenadasGauss.este = esteGauss;
                                  coordenadasGauss.norte = norteGauss;
                                  coordenadasGauss.altura = alturaGauss;
                                  CoordenadasElipsoidales
                                      coordenadasElipsoidales =
                                      conversionCoordenadasMB
                                          .gauss2Elipsoidales(
                                              widget.gaussCS, coordenadasGauss);
                                  CPlanasGenerico planasGenerico =
                                      await coordenadasInportadas(
                                          coordenadasElipsoidales.latitud,
                                          coordenadasElipsoidales.longitud,
                                          coordenadasElipsoidales.altitud);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            PuntoIgacImportado(
                                          altura: planasGenerico.altura,
                                          este: roundDouble(
                                              planasGenerico.este, 3),
                                          nombrePunto: 'SIN NOMBRAR',
                                          ondulacion: 0,
                                          norte: roundDouble(
                                              planasGenerico.norte, 3),
                                          datosProyecto: widget.datosProyecto,
                                        ),
                                      ));
                                }
                              })
                        ],
                      ),
                    ),
                  ),
                ],
              ),
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
                                        borderRadius:
                                            BorderRadius.circular(10)),
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
            child: Center(
              child: Column(
                children: <Widget>[
                  Form(
                    key: _formCartesianas,
                    child: Padding(
                      padding: const EdgeInsets.all(30),
                      child: Column(
                        children: <Widget>[
                          Center(
                            child: Column(
                              children: <Widget>[
                                Text(
                                  'Coordenadas Gauss Krüger',
                                  style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontSize: 16.0,
                                  ),
                                ),
                                Divider(
                                  height: 20,
                                ),
                                Image.asset(
                                  'assets/images/geocentrica.png',
                                  height: 300,
                                  alignment: Alignment.center,
                                ),
                                Divider(),
                                TextFormField(
                                  decoration: InputDecoration(
                                    icon: Icon(Icons.add_location),
                                    labelText: 'Coordenada Norte',
                                  ),
                                  keyboardType: TextInputType.number,
                                  validator: (String nGa) {
                                    double nGauss = double.tryParse(nGa);
                                    if (nGauss == null) {
                                      return 'La Coordenada Norte, está en un formato no valido';
                                    } else {
                                      setState(() {
                                        norteGauss = nGauss;
                                      });
                                      return null;
                                    }
                                  },
                                ),
                                TextFormField(
                                  decoration: InputDecoration(
                                    icon: Icon(Icons.add_location),
                                    labelText: 'Coordenada Este',
                                  ),
                                  keyboardType: TextInputType.number,
                                  validator: (String eGa) {
                                    double eGauss = double.tryParse(eGa);
                                    if (eGauss == null) {
                                      return 'La Coordenada Este, está en un formato no valido';
                                    } else {
                                      setState(() {
                                        esteGauss = eGauss;
                                      });
                                      return null;
                                    }
                                  },
                                ),
                                TextFormField(
                                  decoration: InputDecoration(
                                    icon: Icon(Icons.add_location),
                                    labelText: 'Altura',
                                  ),
                                  keyboardType: TextInputType.number,
                                  validator: (String aGa) {
                                    double aGausss = double.tryParse(aGa);
                                    if (aGausss == null) {
                                      return 'La Altura, está en un formato no valido';
                                    } else {
                                      setState(() {
                                        alturaGauss = aGausss;
                                      });
                                      return null;
                                    }
                                  },
                                ),
                                Divider(height: 30.0),
                              ],
                            ),
                          ),
                          FlatButton(
                              shape: new RoundedRectangleBorder(
                                  borderRadius:
                                      new BorderRadius.circular(20.0)),
                              child: Text(
                                'Importar',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 12.0,
                                  color: Colors.white,
                                ),
                              ),
                              color: Color(0xff007FFF),
                              onPressed: () async {
                                if (_formCartesianas.currentState.validate()) {
                                  ConversionCoordenadasMB
                                      conversionCoordenadasMB =
                                      ConversionCoordenadasMB();
                                  CoordenadasGauss coordenadasGauss =
                                      CoordenadasGauss();
                                  coordenadasGauss.este = esteGauss;
                                  coordenadasGauss.norte = norteGauss;
                                  coordenadasGauss.altura = alturaGauss;
                                  CoordenadasElipsoidales
                                      coordenadasElipsoidales =
                                      conversionCoordenadasMB
                                          .gauss2Elipsoidales(
                                              widget.gaussCS, coordenadasGauss);
                                  CPlanasGenerico planasGenerico =
                                      await coordenadasInportadas(
                                          coordenadasElipsoidales.latitud,
                                          coordenadasElipsoidales.longitud,
                                          coordenadasElipsoidales.altitud);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            PuntoIgacImportado(
                                                altura: planasGenerico.altura,
                                                este: roundDouble(
                                                    planasGenerico.este, 3),
                                                nombrePunto: 'SIN NOMBRAR',
                                                ondulacion: 0,
                                                norte: roundDouble(
                                                    planasGenerico.norte, 3),
                                                datosProyecto:
                                                    widget.datosProyecto),
                                      ));
                                }
                              })
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
        );
      }
      // Importar Coordenadas Elipsoidales en sistema Hexadecimal
    } else if (widget.sistemaOrigen == 'Hexa') {
      if (widget.datosProyecto.Tipo_Proyeccion == 'Plano Cartesiano') {
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
                                        borderRadius:
                                            BorderRadius.circular(10)),
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
              child: Form(
                key: _formElipsoidalesHexa,
                child: Column(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Center(
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height: 20.0,
                              ),
                              Text(
                                'Coordenadas Elipsoidales',
                                style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontSize: 16.0,
                                ),
                              ),
                              Divider(
                                height: 20,
                              ),
                              Image.asset(
                                'assets/images/elipsoidal.png',
                                height: 300,
                                alignment: Alignment.center,
                              ),
                              Divider(),
                              Text(
                                'Latitud',
                                style: TextStyle(
                                    color: Colors.blueAccent, fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                              width: 45,
                              child: Column(
                                children: <Widget>[
                                  TextFormField(
                                    textAlign: TextAlign.center,
                                    inputFormatters: [
                                      WhitelistingTextInputFormatter(RegExp(
                                          r'^(-?[0-9]+([0-9]*)?|0-9]+)$'))
                                    ],
                                    keyboardType:
                                        TextInputType.numberWithOptions(
                                            decimal: false),
                                    validator: (String graLatitud) {
                                      double gradosLatitud =
                                          double.tryParse(graLatitud);
                                      if (gradosLatitud == null) {
                                        return ' ';
                                      } else {
                                        if (gradosLatitud > -90 &&
                                            gradosLatitud < 90) {
                                          setState(() {
                                            gradosLatitudF = gradosLatitud;
                                          });
                                          return null;
                                        } else {
                                          return ' ';
                                        }
                                      }
                                    },
                                  ),
                                  Text('Grados',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.blueAccent))
                                ],
                              )),
                          SizedBox(
                            width: 15,
                          ),
                          Container(
                              width: 45,
                              child: Column(
                                children: <Widget>[
                                  TextFormField(
                                    textAlign: TextAlign.center,
                                    keyboardType:
                                        TextInputType.numberWithOptions(
                                            decimal: false),
                                    inputFormatters: [
                                      WhitelistingTextInputFormatter(RegExp(
                                          r'^(-?[0-9]+([0-9]*)?|0-9]+)$'))
                                    ],
                                    validator: (String minLatitud) {
                                      double minutosLatitud =
                                          double.tryParse(minLatitud);
                                      if (minutosLatitud == null) {
                                        return ' ';
                                      } else {
                                        if (minutosLatitud >= 0 &&
                                            minutosLatitud < 60) {
                                          setState(() {
                                            minutosLatitudF = minutosLatitud;
                                          });
                                          return null;
                                        } else {
                                          return ' ';
                                        }
                                      }
                                    },
                                  ),
                                  Text("Minutos",
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.blueAccent))
                                ],
                              )),
                          SizedBox(
                            width: 15,
                          ),
                          Container(
                              width: 100,
                              child: Column(
                                children: <Widget>[
                                  TextFormField(
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    inputFormatters: [
                                      WhitelistingTextInputFormatter(RegExp(
                                          r'^(-?[0-9]+([.][0-9]*)?|[.][0-9]+)$'))
                                    ],
                                    validator: (String segLatitud) {
                                      double segundosLatitud =
                                          double.tryParse(segLatitud);
                                      if (segundosLatitud == null) {
                                        return ' ';
                                      } else {
                                        if (segundosLatitud >= 0 &&
                                            segundosLatitud < 60) {
                                          setState(() {
                                            segundosLatitudF = segundosLatitud;
                                          });
                                          return null;
                                        } else {
                                          return ' ';
                                        }
                                      }
                                    },
                                  ),
                                  Text('Segundos',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.blueAccent)),
                                ],
                              )),
                          SizedBox(
                            width: 15,
                          ),
                          Container(
                              width: 75,
                              child: Column(
                                children: <Widget>[
                                  DropdownButton<String>(
                                    hint: Text('Norte'),
                                    value: valorNS,
                                    elevation: 16,
                                    items: <String>['Norte', 'Sur']
                                        .map((String valorNS) {
                                      return DropdownMenuItem<String>(
                                        value: valorNS,
                                        child: Text(
                                          valorNS,
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (String newValue) {
                                      setState(() {
                                        valorNS = newValue;
                                      });
                                    },
                                  ),
                                  Text('Hemisferio',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.blueAccent)),
                                ],
                              )),
                        ],
                      ),
                    ),
                    Divider(
                      height: 10,
                    ),
                    Text(
                      'Longitud',
                      style: TextStyle(color: Colors.blueAccent, fontSize: 16),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                              width: 45,
                              child: Column(
                                children: <Widget>[
                                  TextFormField(
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      WhitelistingTextInputFormatter(RegExp(
                                          r'^(-?[0-9]+([0-9]*)?|0-9]+)$'))
                                    ],
                                    validator: (String graLongitud) {
                                      double gradosLongitud =
                                          double.tryParse(graLongitud);
                                      if (gradosLongitud == null) {
                                        return ' ';
                                      } else {
                                        if (gradosLongitud > -180 &&
                                            gradosLongitud < 180) {
                                          setState(() {
                                            gradosLongitudF = gradosLongitud;
                                          });
                                          return null;
                                        } else {
                                          return ' ';
                                        }
                                      }
                                    },
                                  ),
                                  Text('Grados',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.blueAccent))
                                ],
                              )),
                          SizedBox(
                            width: 15,
                          ),
                          Container(
                              width: 45,
                              child: Column(
                                children: <Widget>[
                                  TextFormField(
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      WhitelistingTextInputFormatter(RegExp(
                                          r'^(-?[0-9]+([0-9]*)?|0-9]+)$'))
                                    ],
                                    validator: (String minLatitud) {
                                      double minutosLongitud =
                                          double.tryParse(minLatitud);
                                      if (minutosLongitud == null) {
                                        return ' ';
                                      } else {
                                        if (minutosLongitud >= 0 &&
                                            minutosLongitud < 60) {
                                          setState(() {
                                            minutosLongitudF = minutosLongitud;
                                          });
                                          return null;
                                        } else {
                                          return ' ';
                                        }
                                      }
                                    },
                                  ),
                                  Text("Minutos",
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.blueAccent))
                                ],
                              )),
                          SizedBox(
                            width: 15,
                          ),
                          Container(
                              width: 100,
                              child: Column(
                                children: <Widget>[
                                  TextFormField(
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      WhitelistingTextInputFormatter(RegExp(
                                          r'^(-?[0-9]+([.][0-9]*)?|[.][0-9]+)$'))
                                    ],
                                    validator: (String segLongitud) {
                                      double segundoLongitud =
                                          double.tryParse(segLongitud);
                                      if (segundoLongitud == null) {
                                        return ' ';
                                      } else {
                                        if (segundoLongitud >= 0 &&
                                            segundoLongitud < 60) {
                                          setState(() {
                                            segundosLongitudF = segundoLongitud;
                                          });
                                          return null;
                                        } else {
                                          return ' ';
                                        }
                                      }
                                    },
                                  ),
                                  Text('Segundos',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.blueAccent)),
                                ],
                              )),
                          SizedBox(
                            width: 15,
                          ),
                          Container(
                              width: 75,
                              child: Column(
                                children: <Widget>[
                                  DropdownButton<String>(
                                    hint: Text('Oeste'),
                                    value: valorEO,
                                    elevation: 16,
                                    items: <String>['Oeste', 'Este']
                                        .map((String valorEO) {
                                      return DropdownMenuItem<String>(
                                        value: valorEO,
                                        child: Text(
                                          valorEO,
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (String newValue) {
                                      setState(() {
                                        valorEO = newValue;
                                      });
                                    },
                                  ),
                                  Text('Hemisferio',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.blueAccent)),
                                ],
                              )),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text('Altura',
                        style: TextStyle(
                            color: Colors.blueAccent, fontSize: 16.0)),
                    Container(
                      width: 100,
                      child: TextFormField(
                        inputFormatters: [
                          WhitelistingTextInputFormatter(
                              RegExp(r'^(-?[0-9]+([.][0-9]*)?|[.][0-9]+)$'))
                        ],
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        validator: (String alturaPunto) {
                          double altPunto = double.tryParse(alturaPunto);
                          if (altPunto == null) {
                            return ' ';
                          } else {
                            setState(() {
                              altura = altPunto;
                            });
                            return null;
                          }
                        },
                      ),
                    ),
                    SizedBox(height: 20.0),
                    FlatButton(
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(20.0)),
                        child: Text(
                          'Importar',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 12.0,
                            color: Colors.white,
                          ),
                        ),
                        color: Color(0xff007FFF),
                        onPressed: () async {
                          if (_formElipsoidalesHexa.currentState.validate()) {
                            CoordenadasElipsoidales coordenadasElipsoidales =
                                CoordenadasElipsoidales();
                            double hNS(String hemisferioNS) {
                              if (hemisferioNS == 'Norte') {
                                return 1;
                              } else {
                                return -1;
                              }
                            }

                            double hEO(String hemisferioNS) {
                              if (hemisferioNS == 'Este') {
                                return 1;
                              } else {
                                return -1;
                              }
                            }

                            coordenadasElipsoidales.latitud = (gradosLatitudF +
                                    (minutosLatitudF / 60) +
                                    (segundosLatitudF / 3600)) *
                                hNS(valorNS);
                            coordenadasElipsoidales.longitud =
                                (gradosLongitudF +
                                        (minutosLongitudF / 60) +
                                        (segundosLongitudF / 3600)) *
                                    hEO(valorEO);
                            CPlanasGenerico planasGenerico =
                                await coordenadasInportadas(
                                    coordenadasElipsoidales.latitud,
                                    coordenadasElipsoidales.longitud,
                                    altura);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PuntoIgacImportado(
                                    altura: planasGenerico.altura,
                                    este: roundDouble(planasGenerico.este, 3),
                                    nombrePunto: 'SIN NOMBRAR',
                                    ondulacion: 0,
                                    norte: roundDouble(planasGenerico.norte, 3),
                                    datosProyecto: widget.datosProyecto,
                                  ),
                                ));
                          }
                        })
                  ],
                ),
              ),
            ),
          )),
        );
      } else if (widget.datosProyecto.Tipo_Proyeccion == 'Gauss-Krüger') {
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
                                        borderRadius:
                                            BorderRadius.circular(10)),
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
              child: Form(
                key: _formElipsoidalesHexa,
                child: Column(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Center(
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height: 20.0,
                              ),
                              Text(
                                'Coordenadas Elipsoidales',
                                style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontSize: 16.0,
                                ),
                              ),
                              Divider(
                                height: 20,
                              ),
                              Image.asset(
                                'assets/images/elipsoidal.png',
                                height: 300,
                                alignment: Alignment.center,
                              ),
                              Divider(),
                              Text(
                                'Latitud',
                                style: TextStyle(
                                    color: Colors.blueAccent, fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                              width: 45,
                              child: Column(
                                children: <Widget>[
                                  TextFormField(
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      WhitelistingTextInputFormatter(RegExp(
                                          r'^(-?[0-9]+([0-9]*)?|0-9]+)$'))
                                    ],
                                    validator: (String graLatitud) {
                                      double gradosLatitud =
                                          double.tryParse(graLatitud);
                                      if (gradosLatitud == null) {
                                        return ' ';
                                      } else {
                                        if (gradosLatitud > -90 &&
                                            gradosLatitud < 90) {
                                          setState(() {
                                            gradosLatitudF = gradosLatitud;
                                          });
                                          return null;
                                        } else {
                                          return ' ';
                                        }
                                      }
                                    },
                                  ),
                                  Text('Grados',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.blueAccent))
                                ],
                              )),
                          SizedBox(
                            width: 15,
                          ),
                          Container(
                              width: 45,
                              child: Column(
                                children: <Widget>[
                                  TextFormField(
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      WhitelistingTextInputFormatter(RegExp(
                                          r'^(-?[0-9]+([0-9]*)?|0-9]+)$'))
                                    ],
                                    validator: (String minLatitud) {
                                      double minutosLatitud =
                                          double.tryParse(minLatitud);
                                      if (minutosLatitud == null) {
                                        return ' ';
                                      } else {
                                        if (minutosLatitud >= 0 &&
                                            minutosLatitud < 60) {
                                          setState(() {
                                            minutosLatitudF = minutosLatitud;
                                          });
                                          return null;
                                        } else {
                                          return ' ';
                                        }
                                      }
                                    },
                                  ),
                                  Text("Minutos",
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.blueAccent))
                                ],
                              )),
                          SizedBox(
                            width: 15,
                          ),
                          Container(
                              width: 100,
                              child: Column(
                                children: <Widget>[
                                  TextFormField(
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      WhitelistingTextInputFormatter(RegExp(
                                          r'^(-?[0-9]+([.][0-9]*)?|[.][0-9]+)$'))
                                    ],
                                    validator: (String segLatitud) {
                                      double segundosLatitud =
                                          double.tryParse(segLatitud);
                                      if (segundosLatitud == null) {
                                        return ' ';
                                      } else {
                                        if (segundosLatitud >= 0 &&
                                            segundosLatitud < 60) {
                                          setState(() {
                                            segundosLatitudF = segundosLatitud;
                                          });
                                          return null;
                                        } else {
                                          return ' ';
                                        }
                                      }
                                    },
                                  ),
                                  Text('Segundos',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.blueAccent)),
                                ],
                              )),
                          SizedBox(
                            width: 15,
                          ),
                          Container(
                              width: 75,
                              child: Column(
                                children: <Widget>[
                                  DropdownButton<String>(
                                    hint: Text('Norte'),
                                    value: valorNS,
                                    elevation: 16,
                                    items: <String>['Norte', 'Sur']
                                        .map((String valorNS) {
                                      return DropdownMenuItem<String>(
                                        value: valorNS,
                                        child: Text(
                                          valorNS,
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (String newValue) {
                                      setState(() {
                                        valorNS = newValue;
                                      });
                                    },
                                  ),
                                  Text('Hemisferio',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.blueAccent)),
                                ],
                              )),
                        ],
                      ),
                    ),
                    Divider(
                      height: 10,
                    ),
                    Text(
                      'Longitud',
                      style: TextStyle(color: Colors.blueAccent, fontSize: 16),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                              width: 45,
                              child: Column(
                                children: <Widget>[
                                  TextFormField(
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      WhitelistingTextInputFormatter(RegExp(
                                          r'^(-?[0-9]+([0-9]*)?|0-9]+)$'))
                                    ],
                                    validator: (String graLongitud) {
                                      double gradosLongitud =
                                          double.tryParse(graLongitud);
                                      if (gradosLongitud == null) {
                                        return ' ';
                                      } else {
                                        if (gradosLongitud > -180 &&
                                            gradosLongitud < 180) {
                                          setState(() {
                                            gradosLongitudF = gradosLongitud;
                                          });
                                          return null;
                                        } else {
                                          return ' ';
                                        }
                                      }
                                    },
                                  ),
                                  Text('Grados',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.blueAccent))
                                ],
                              )),
                          SizedBox(
                            width: 15,
                          ),
                          Container(
                              width: 45,
                              child: Column(
                                children: <Widget>[
                                  TextFormField(
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      WhitelistingTextInputFormatter(RegExp(
                                          r'^(-?[0-9]+([0-9]*)?|0-9]+)$'))
                                    ],
                                    validator: (String minLatitud) {
                                      double minutosLongitud =
                                          double.tryParse(minLatitud);
                                      if (minutosLongitud == null) {
                                        return ' ';
                                      } else {
                                        if (minutosLongitud >= 0 &&
                                            minutosLongitud < 60) {
                                          minutosLongitudF = minutosLongitud;
                                          return null;
                                        } else {
                                          return ' ';
                                        }
                                      }
                                    },
                                  ),
                                  Text("Minutos",
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.blueAccent))
                                ],
                              )),
                          SizedBox(
                            width: 15,
                          ),
                          Container(
                              width: 100,
                              child: Column(
                                children: <Widget>[
                                  TextFormField(
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      WhitelistingTextInputFormatter(RegExp(
                                          r'^(-?[0-9]+([.][0-9]*)?|[.][0-9]+)$'))
                                    ],
                                    validator: (String segLongitud) {
                                      double segundoLongitud =
                                          double.tryParse(segLongitud);
                                      if (segundoLongitud == null) {
                                        return ' ';
                                      } else {
                                        if (segundoLongitud >= 0 &&
                                            segundoLongitud < 60) {
                                          setState(() {
                                            segundosLongitudF = segundoLongitud;
                                          });
                                          return null;
                                        } else {
                                          return ' ';
                                        }
                                      }
                                    },
                                  ),
                                  Text('Segundos',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.blueAccent)),
                                ],
                              )),
                          SizedBox(
                            width: 15,
                          ),
                          Container(
                              width: 75,
                              child: Column(
                                children: <Widget>[
                                  DropdownButton<String>(
                                    hint: Text('Oeste'),
                                    value: valorEO,
                                    elevation: 16,
                                    items: <String>['Oeste', 'Este']
                                        .map((String valorEO) {
                                      return DropdownMenuItem<String>(
                                        value: valorEO,
                                        child: Text(
                                          valorEO,
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (String newValue) {
                                      setState(() {
                                        valorEO = newValue;
                                      });
                                    },
                                  ),
                                  Text('Hemisferio',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.blueAccent)),
                                ],
                              )),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text('Altura',
                        style: TextStyle(
                            color: Colors.blueAccent, fontSize: 16.0)),
                    Container(
                      width: 100,
                      child: TextFormField(
                        inputFormatters: [
                          WhitelistingTextInputFormatter(
                              RegExp(r'^(-?[0-9]+([.][0-9]*)?|[.][0-9]+)$'))
                        ],
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        validator: (String alturaPunto) {
                          double altPunto = double.tryParse(alturaPunto);
                          if (altPunto == null) {
                            return ' ';
                          } else {
                            setState(() {
                              altura = altPunto;
                            });
                            return null;
                          }
                        },
                      ),
                    ),
                    SizedBox(height: 20.0),
                    FlatButton(
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(20.0)),
                        child: Text(
                          'Importar',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 12.0,
                            color: Colors.white,
                          ),
                        ),
                        color: Color(0xff007FFF),
                        onPressed: () async {
                          if (_formElipsoidalesHexa.currentState.validate()) {
                            CoordenadasElipsoidales coordenadasElipsoidales =
                                CoordenadasElipsoidales();
                            double hNS(String hemisferioNS) {
                              if (hemisferioNS == 'Norte') {
                                return 1;
                              } else {
                                return -1;
                              }
                            }

                            double hEO(String hemisferioNS) {
                              if (hemisferioNS == 'Este') {
                                return 1;
                              } else {
                                return -1;
                              }
                            }

                            coordenadasElipsoidales.latitud = (gradosLatitudF +
                                    (minutosLatitudF / 60) +
                                    (segundosLatitudF / 3600)) *
                                hNS(valorNS);
                            coordenadasElipsoidales.longitud =
                                (gradosLongitudF +
                                        (minutosLongitudF / 60) +
                                        (segundosLongitudF / 3600)) *
                                    hEO(valorEO);
                            CPlanasGenerico planasGenerico =
                                await coordenadasInportadas(
                                    coordenadasElipsoidales.latitud,
                                    coordenadasElipsoidales.longitud,
                                    altura);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PuntoIgacImportado(
                                    altura: planasGenerico.altura,
                                    este: roundDouble(planasGenerico.este, 3),
                                    nombrePunto: 'SIN NOMBRAR',
                                    ondulacion: 0,
                                    norte: roundDouble(planasGenerico.norte, 3),
                                    datosProyecto: widget.datosProyecto,
                                  ),
                                ));
                          }
                        })
                  ],
                ),
              ),
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
                                        borderRadius:
                                            BorderRadius.circular(10)),
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
              child: Form(
                key: _formElipsoidalesHexa,
                child: Column(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Center(
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height: 20.0,
                              ),
                              Text(
                                'Coordenadas Elipsoidales',
                                style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontSize: 16.0,
                                ),
                              ),
                              Divider(
                                height: 20,
                              ),
                              Image.asset(
                                'assets/images/elipsoidal.png',
                                height: 300,
                                alignment: Alignment.center,
                              ),
                              Divider(),
                              Text(
                                'Latitud',
                                style: TextStyle(
                                    color: Colors.blueAccent, fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                              width: 45,
                              child: Column(
                                children: <Widget>[
                                  TextFormField(
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      WhitelistingTextInputFormatter(RegExp(
                                          r'^(-?[0-9]+([0-9]*)?|0-9]+)$'))
                                    ],
                                    validator: (String graLatitud) {
                                      double gradosLatitud =
                                          double.tryParse(graLatitud);
                                      if (gradosLatitud == null) {
                                        return ' ';
                                      } else {
                                        if (gradosLatitud > -90 &&
                                            gradosLatitud < 90) {
                                          setState(() {
                                            gradosLatitudF = gradosLatitud;
                                          });
                                          return null;
                                        } else {
                                          return ' ';
                                        }
                                      }
                                    },
                                  ),
                                  Text('Grados',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.blueAccent))
                                ],
                              )),
                          SizedBox(
                            width: 15,
                          ),
                          Container(
                              width: 45,
                              child: Column(
                                children: <Widget>[
                                  TextFormField(
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      WhitelistingTextInputFormatter(RegExp(
                                          r'^(-?[0-9]+([0-9]*)?|0-9]+)$'))
                                    ],
                                    validator: (String minLatitud) {
                                      double minutosLatitud =
                                          double.tryParse(minLatitud);
                                      if (minutosLatitud == null) {
                                        return ' ';
                                      } else {
                                        if (minutosLatitud >= 0 &&
                                            minutosLatitud < 60) {
                                          setState(() {
                                            minutosLatitudF = minutosLatitud;
                                          });
                                          return null;
                                        } else {
                                          return ' ';
                                        }
                                      }
                                    },
                                  ),
                                  Text("Minutos",
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.blueAccent))
                                ],
                              )),
                          SizedBox(
                            width: 15,
                          ),
                          Container(
                              width: 100,
                              child: Column(
                                children: <Widget>[
                                  TextFormField(
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      WhitelistingTextInputFormatter(RegExp(
                                          r'^(-?[0-9]+([.][0-9]*)?|[.][0-9]+)$'))
                                    ],
                                    validator: (String segLatitud) {
                                      double segundosLatitud =
                                          double.tryParse(segLatitud);
                                      if (segundosLatitud == null) {
                                        return ' ';
                                      } else {
                                        if (segundosLatitud >= 0 &&
                                            segundosLatitud < 60) {
                                          setState(() {
                                            segundosLatitudF = segundosLatitud;
                                          });
                                          return null;
                                        } else {
                                          return ' ';
                                        }
                                      }
                                    },
                                  ),
                                  Text('Segundos',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.blueAccent)),
                                ],
                              )),
                          SizedBox(
                            width: 15,
                          ),
                          Container(
                              width: 75,
                              child: Column(
                                children: <Widget>[
                                  DropdownButton<String>(
                                    hint: Text('Norte'),
                                    value: valorNS,
                                    elevation: 16,
                                    items: <String>['Norte', 'Sur']
                                        .map((String valorNS) {
                                      return DropdownMenuItem<String>(
                                        value: valorNS,
                                        child: Text(
                                          valorNS,
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (String newValue) {
                                      setState(() {
                                        valorNS = newValue;
                                      });
                                    },
                                  ),
                                  Text('Hemisferio',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.blueAccent)),
                                ],
                              )),
                        ],
                      ),
                    ),
                    Divider(
                      height: 10,
                    ),
                    Text(
                      'Longitud',
                      style: TextStyle(color: Colors.blueAccent, fontSize: 16),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                              width: 45,
                              child: Column(
                                children: <Widget>[
                                  TextFormField(
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      WhitelistingTextInputFormatter(RegExp(
                                          r'^(-?[0-9]+([0-9]*)?|0-9]+)$'))
                                    ],
                                    validator: (String graLongitud) {
                                      double gradosLongitud =
                                          double.tryParse(graLongitud);
                                      if (gradosLongitud == null) {
                                        return ' ';
                                      } else {
                                        if (gradosLongitud > -180 &&
                                            gradosLongitud < 180) {
                                          setState(() {
                                            gradosLongitudF = gradosLongitud;
                                          });
                                          return null;
                                        } else {
                                          return ' ';
                                        }
                                      }
                                    },
                                  ),
                                  Text('Grados',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.blueAccent))
                                ],
                              )),
                          SizedBox(
                            width: 15,
                          ),
                          Container(
                              width: 45,
                              child: Column(
                                children: <Widget>[
                                  TextFormField(
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      WhitelistingTextInputFormatter(RegExp(
                                          r'^(-?[0-9]+([0-9]*)?|0-9]+)$'))
                                    ],
                                    validator: (String minLatitud) {
                                      double minutosLongitud =
                                          double.tryParse(minLatitud);
                                      if (minutosLongitud == null) {
                                        return ' ';
                                      } else {
                                        if (minutosLongitud >= 0 &&
                                            minutosLongitud < 60) {
                                          minutosLongitudF = minutosLongitud;
                                          return null;
                                        } else {
                                          return ' ';
                                        }
                                      }
                                    },
                                  ),
                                  Text("Minutos",
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.blueAccent))
                                ],
                              )),
                          SizedBox(
                            width: 15,
                          ),
                          Container(
                              width: 100,
                              child: Column(
                                children: <Widget>[
                                  TextFormField(
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      WhitelistingTextInputFormatter(RegExp(
                                          r'^(-?[0-9]+([.][0-9]*)?|[.][0-9]+)$'))
                                    ],
                                    validator: (String segLongitud) {
                                      double segundoLongitud =
                                          double.tryParse(segLongitud);
                                      if (segundoLongitud == null) {
                                        return ' ';
                                      } else {
                                        if (segundoLongitud >= 0 &&
                                            segundoLongitud < 60) {
                                          setState(() {
                                            segundosLongitudF = segundoLongitud;
                                          });
                                          return null;
                                        } else {
                                          return ' ';
                                        }
                                      }
                                    },
                                  ),
                                  Text('Segundos',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.blueAccent)),
                                ],
                              )),
                          SizedBox(
                            width: 15,
                          ),
                          Container(
                              width: 75,
                              child: Column(
                                children: <Widget>[
                                  DropdownButton<String>(
                                    hint: Text('Oeste'),
                                    value: valorEO,
                                    elevation: 16,
                                    items: <String>['Oeste', 'Este']
                                        .map((String valorEO) {
                                      return DropdownMenuItem<String>(
                                        value: valorEO,
                                        child: Text(
                                          valorEO,
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (String newValue) {
                                      setState(() {
                                        valorEO = newValue;
                                      });
                                    },
                                  ),
                                  Text('Hemisferio',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.blueAccent)),
                                ],
                              )),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text('Altura',
                        style: TextStyle(
                            color: Colors.blueAccent, fontSize: 16.0)),
                    Container(
                      width: 100,
                      child: TextFormField(
                        inputFormatters: [
                          WhitelistingTextInputFormatter(
                              RegExp(r'^(-?[0-9]+([.][0-9]*)?|[.][0-9]+)$'))
                        ],
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        validator: (String alturaPunto) {
                          double altPunto = double.tryParse(alturaPunto);
                          if (altPunto == null) {
                            return ' ';
                          } else {
                            setState(() {
                              altura = altPunto;
                            });
                            return null;
                          }
                        },
                      ),
                    ),
                    SizedBox(height: 20.0),
                    FlatButton(
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(20.0)),
                        child: Text(
                          'Importar',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 12.0,
                            color: Colors.white,
                          ),
                        ),
                        color: Color(0xff007FFF),
                        onPressed: () async {
                          if (_formElipsoidalesHexa.currentState.validate()) {
                            CoordenadasElipsoidales coordenadasElipsoidales =
                                CoordenadasElipsoidales();
                            double hNS(String hemisferioNS) {
                              if (hemisferioNS == 'Norte') {
                                return 1;
                              } else {
                                return -1;
                              }
                            }

                            double hEO(String hemisferioNS) {
                              if (hemisferioNS == 'Este') {
                                return 1;
                              } else {
                                return -1;
                              }
                            }

                            coordenadasElipsoidales.latitud = (gradosLatitudF +
                                    (minutosLatitudF / 60) +
                                    (segundosLatitudF / 3600)) *
                                hNS(valorNS);
                            coordenadasElipsoidales.longitud =
                                (gradosLongitudF +
                                        (minutosLongitudF / 60) +
                                        (segundosLongitudF / 3600)) *
                                    hEO(valorEO);
                            CPlanasGenerico planasGenerico =
                                await coordenadasInportadas(
                                    coordenadasElipsoidales.latitud,
                                    coordenadasElipsoidales.longitud,
                                    altura);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PuntoIgacImportado(
                                    altura: planasGenerico.altura,
                                    este: roundDouble(planasGenerico.este, 3),
                                    nombrePunto: 'SIN NOMBRAR',
                                    ondulacion: 0,
                                    norte: roundDouble(planasGenerico.norte, 3),
                                    datosProyecto: widget.datosProyecto,
                                  ),
                                ));
                          }
                        })
                  ],
                ),
              ),
            ),
          )),
        );
      }
    } else if (widget.sistemaOrigen == 'MAGNA Origen Nacional') {
      if (widget.datosProyecto.Tipo_Proyeccion == 'Plano Cartesiano') {
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
                                        borderRadius:
                                            BorderRadius.circular(10)),
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
            child: Center(
              child: Column(
                children: <Widget>[
                  Form(
                    key: _formCartesianas,
                    child: Padding(
                      padding: const EdgeInsets.all(30),
                      child: Column(
                        children: <Widget>[
                          Center(
                            child: Column(
                              children: <Widget>[
                                Text(
                                  'Magna Origen Nacional',
                                  style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontSize: 16.0,
                                  ),
                                ),
                                Divider(
                                  height: 20,
                                ),
                                Image.asset(
                                  'assets/images/nacional.png',
                                  height: 300,
                                  alignment: Alignment.center,
                                ),
                                Divider(),
                                TextFormField(
                                  decoration: InputDecoration(
                                    icon: Icon(Icons.add_location),
                                    labelText: 'Coordenada Norte',
                                  ),
                                  keyboardType: TextInputType.number,
                                  validator: (String nCarte) {
                                    double nCartesiana =
                                        double.tryParse(nCarte);
                                    if (nCartesiana == null) {
                                      return 'La Coordenada Norte, está en un formato no valido';
                                    } else {
                                      setState(() {
                                        norteCartesianas = nCartesiana;
                                      });
                                      return null;
                                    }
                                  },
                                ),
                                TextFormField(
                                  decoration: InputDecoration(
                                    icon: Icon(Icons.add_location),
                                    labelText: 'Coordenadas Este',
                                  ),
                                  keyboardType: TextInputType.number,
                                  validator: (String eCarte) {
                                    double eCartesiana =
                                        double.tryParse(eCarte);
                                    if (eCartesiana == null) {
                                      return 'La Coordenada Este, está en un formato no valido';
                                    } else {
                                      setState(() {
                                        esteCartesianas = eCartesiana;
                                      });
                                      return null;
                                    }
                                  },
                                ),
                                TextFormField(
                                  decoration: InputDecoration(
                                    icon: Icon(Icons.add_location),
                                    labelText: 'Altura',
                                  ),
                                  keyboardType: TextInputType.number,
                                  validator: (String aCar) {
                                    double aCartesiana = double.tryParse(aCar);
                                    if (aCartesiana == null) {
                                      return 'La Altura, está en un formato no valido';
                                    } else {
                                      setState(() {
                                        alturaCartesianas = aCartesiana;
                                      });
                                      return null;
                                    }
                                  },
                                ),
                                Divider(height: 30.0),
                              ],
                            ),
                          ),
                          FlatButton(
                              shape: new RoundedRectangleBorder(
                                  borderRadius:
                                      new BorderRadius.circular(20.0)),
                              child: Text(
                                'Importar',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 12.0,
                                  color: Colors.white,
                                ),
                              ),
                              color: Color(0xff007FFF),
                              onPressed: () async {
                                if (_formCartesianas.currentState.validate()) {
                                  ConversionCoordenadasMB
                                      conversionCoordenadasMB =
                                      ConversionCoordenadasMB();
                                  CoordenadasON coordenadasON = CoordenadasON();
                                  coordenadasON.este = esteCartesianas;
                                  coordenadasON.norte = norteCartesianas;
                                  coordenadasON.altura = alturaCartesianas;
                                  CoordenadasElipsoidales
                                      coordenadasElipsoidales =
                                      conversionCoordenadasMB
                                          .origenNacional2Elipsoidales(
                                              coordenadasON);
                                  CPlanasGenerico planasGenerico =
                                      await coordenadasInportadas(
                                          coordenadasElipsoidales.latitud,
                                          coordenadasElipsoidales.longitud,
                                          coordenadasElipsoidales.altitud);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            PuntoIgacImportado(
                                          altura: planasGenerico.altura,
                                          datosProyecto: widget.datosProyecto,
                                          este: roundDouble(
                                              planasGenerico.este, 3),
                                          nombrePunto: 'SIN NOMBRAR',
                                          ondulacion: 0,
                                          norte: roundDouble(
                                              planasGenerico.norte, 3),
                                        ),
                                      ));
                                }
                              })
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
        );
      } else {
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
                                        borderRadius:
                                            BorderRadius.circular(10)),
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
            child: Center(
              child: Column(
                children: <Widget>[
                  Form(
                    key: _formCartesianas,
                    child: Padding(
                      padding: const EdgeInsets.all(30),
                      child: Column(
                        children: <Widget>[
                          Center(
                            child: Column(
                              children: <Widget>[
                                Text(
                                  'Magna Origen Nacional',
                                  style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontSize: 16.0,
                                  ),
                                ),
                                Divider(
                                  height: 20,
                                ),
                                Image.asset(
                                  'assets/images/nacional.png',
                                  height: 300,
                                  alignment: Alignment.center,
                                ),
                                Divider(),
                                TextFormField(
                                  decoration: InputDecoration(
                                    icon: Icon(Icons.add_location),
                                    labelText: 'Coordenada Norte',
                                  ),
                                  keyboardType: TextInputType.number,
                                  validator: (String nCarte) {
                                    double nCartesiana =
                                        double.tryParse(nCarte);
                                    if (nCartesiana == null) {
                                      return 'La Coordenada Norte, está en un formato no valido';
                                    } else {
                                      setState(() {
                                        norteCartesianas = nCartesiana;
                                      });
                                      return null;
                                    }
                                  },
                                ),
                                TextFormField(
                                  decoration: InputDecoration(
                                    icon: Icon(Icons.add_location),
                                    labelText: 'Coordenada Este',
                                  ),
                                  keyboardType: TextInputType.number,
                                  validator: (String eCarte) {
                                    double eCartesiana =
                                        double.tryParse(eCarte);
                                    if (eCartesiana == null) {
                                      return 'La Coordenada Este, está en un formato no valido';
                                    } else {
                                      setState(() {
                                        esteCartesianas = eCartesiana;
                                      });
                                      return null;
                                    }
                                  },
                                ),
                                TextFormField(
                                  decoration: InputDecoration(
                                    icon: Icon(Icons.add_location),
                                    labelText: 'Altura',
                                  ),
                                  keyboardType: TextInputType.number,
                                  validator: (String aCar) {
                                    double aCartesiana = double.tryParse(aCar);
                                    if (aCartesiana == null) {
                                      return 'La Altura, está en un formato no valido';
                                    } else {
                                      setState(() {
                                        alturaCartesianas = aCartesiana;
                                      });
                                      return null;
                                    }
                                  },
                                ),
                                Divider(height: 30.0),
                              ],
                            ),
                          ),
                          FlatButton(
                              shape: new RoundedRectangleBorder(
                                  borderRadius:
                                      new BorderRadius.circular(20.0)),
                              child: Text(
                                'Importar',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 12.0,
                                  color: Colors.white,
                                ),
                              ),
                              color: Color(0xff007FFF),
                              onPressed: () async {
                                if (_formCartesianas.currentState.validate()) {
                                  ConversionCoordenadasMB
                                      conversionCoordenadasMB =
                                      ConversionCoordenadasMB();
                                  CoordenadasON coordenadasON = CoordenadasON();
                                  coordenadasON.este = esteCartesianas;
                                  coordenadasON.norte = norteCartesianas;
                                  coordenadasON.altura = alturaCartesianas;
                                  CoordenadasElipsoidales
                                      coordenadasElipsoidales =
                                      conversionCoordenadasMB
                                          .origenNacional2Elipsoidales(
                                              coordenadasON);
                                  CPlanasGenerico planasGenerico =
                                      await coordenadasInportadas(
                                          coordenadasElipsoidales.latitud,
                                          coordenadasElipsoidales.longitud,
                                          coordenadasElipsoidales.altitud);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            PuntoIgacImportado(
                                                altura: planasGenerico.altura,
                                                este: roundDouble(
                                                    planasGenerico.este, 3),
                                                nombrePunto: 'SIN NOMBRAR',
                                                ondulacion: 0,
                                                norte: roundDouble(
                                                    planasGenerico.norte, 3),
                                                datosProyecto:
                                                    widget.datosProyecto),
                                      ));
                                }
                              })
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
        );
      }
    } else {
      if (widget.datosProyecto.Tipo_Proyeccion == 'Plano Cartesiano') {
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
                                        borderRadius:
                                            BorderRadius.circular(10)),
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
            child: Center(
              child: Column(
                children: <Widget>[
                  Form(
                    key: _formCartesianas,
                    child: Padding(
                      padding: const EdgeInsets.all(30),
                      child: Column(
                        children: <Widget>[
                          Center(
                            child: Column(
                              children: <Widget>[
                                Text(
                                  'Coordenadas Planas Cartesianas',
                                  style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontSize: 16.0,
                                  ),
                                ),
                                Divider(
                                  height: 20,
                                ),
                                Image.asset(
                                  'assets/images/geocentrica.png',
                                  height: 300,
                                  alignment: Alignment.center,
                                ),
                                Divider(),
                                TextFormField(
                                  decoration: InputDecoration(
                                    icon: Icon(Icons.add_location),
                                    labelText: 'Coordenada Norte',
                                  ),
                                  keyboardType: TextInputType.number,
                                  validator: (String nCarte) {
                                    double nCartesiana =
                                        double.tryParse(nCarte);
                                    if (nCartesiana == null) {
                                      return 'La Coordenada Norte, está en un formato no valido';
                                    } else {
                                      setState(() {
                                        norteCartesianas = nCartesiana;
                                      });
                                      return null;
                                    }
                                  },
                                ),
                                TextFormField(
                                  decoration: InputDecoration(
                                    icon: Icon(Icons.add_location),
                                    labelText: 'Coordenadas Este',
                                  ),
                                  keyboardType: TextInputType.number,
                                  validator: (String eCarte) {
                                    double eCartesiana =
                                        double.tryParse(eCarte);
                                    if (eCartesiana == null) {
                                      return 'La Coordenada Este, está en un formato no valido';
                                    } else {
                                      setState(() {
                                        esteCartesianas = eCartesiana;
                                      });
                                      return null;
                                    }
                                  },
                                ),
                                TextFormField(
                                  decoration: InputDecoration(
                                    icon: Icon(Icons.add_location),
                                    labelText: 'Altura',
                                  ),
                                  keyboardType: TextInputType.number,
                                  validator: (String aCar) {
                                    double aCartesiana = double.tryParse(aCar);
                                    if (aCartesiana == null) {
                                      return 'La Altura, está en un formato no valido';
                                    } else {
                                      setState(() {
                                        alturaCartesianas = aCartesiana;
                                      });
                                      return null;
                                    }
                                  },
                                ),
                                Divider(height: 30.0),
                              ],
                            ),
                          ),
                          FlatButton(
                              shape: new RoundedRectangleBorder(
                                  borderRadius:
                                      new BorderRadius.circular(20.0)),
                              child: Text(
                                'Importar',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 12.0,
                                  color: Colors.white,
                                ),
                              ),
                              color: Color(0xff007FFF),
                              onPressed: () async {
                                if (_formCartesianas.currentState.validate()) {
                                  ConversionCoordenadasMB
                                      conversionCoordenadasMB =
                                      ConversionCoordenadasMB();
                                  CoordenadasCartesianas
                                      coordenadasCartesianas =
                                      CoordenadasCartesianas();
                                  coordenadasCartesianas.este = esteCartesianas;
                                  coordenadasCartesianas.norte =
                                      norteCartesianas;
                                  coordenadasCartesianas.altura =
                                      alturaCartesianas;
                                  CoordenadasElipsoidales
                                      coordenadasElipsoidales =
                                      conversionCoordenadasMB
                                          .cartesianas2Elipoidales(
                                              coordenadasCartesianas,
                                              widget.cartesianasCS);
                                  CPlanasGenerico planasGenerico =
                                      await coordenadasInportadas(
                                          coordenadasElipsoidales.latitud,
                                          coordenadasElipsoidales.longitud,
                                          coordenadasElipsoidales.altitud);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            PuntoIgacImportado(
                                          altura: planasGenerico.altura,
                                          este: roundDouble(
                                              planasGenerico.este, 3),
                                          nombrePunto: 'SIN NOMBRAR',
                                          ondulacion: 0,
                                          norte: roundDouble(
                                              planasGenerico.norte, 3),
                                          datosProyecto: widget.datosProyecto,
                                        ),
                                      ));
                                }
                              })
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
        );
      } else {
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
                                        borderRadius:
                                            BorderRadius.circular(10)),
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
            child: Center(
              child: Column(
                children: <Widget>[
                  Form(
                    key: _formCartesianas,
                    child: Padding(
                      padding: const EdgeInsets.all(30),
                      child: Column(
                        children: <Widget>[
                          Center(
                            child: Column(
                              children: <Widget>[
                                Text(
                                  'Coordenadas Planas Cartesianas',
                                  style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontSize: 16.0,
                                  ),
                                ),
                                Divider(
                                  height: 20,
                                ),
                                Image.asset(
                                  'assets/images/geocentrica.png',
                                  height: 300,
                                  alignment: Alignment.center,
                                ),
                                Divider(),
                                TextFormField(
                                  decoration: InputDecoration(
                                    icon: Icon(Icons.add_location),
                                    labelText: 'Coordenada Norte',
                                  ),
                                  keyboardType: TextInputType.number,
                                  validator: (String nCarte) {
                                    double nCartesiana =
                                        double.tryParse(nCarte);
                                    if (nCartesiana == null) {
                                      return 'La Coordenada Norte, está en un formato no valido';
                                    } else {
                                      setState(() {
                                        norteCartesianas = nCartesiana;
                                      });
                                      return null;
                                    }
                                  },
                                ),
                                TextFormField(
                                  decoration: InputDecoration(
                                    icon: Icon(Icons.add_location),
                                    labelText: 'Coordenada Este',
                                  ),
                                  keyboardType: TextInputType.number,
                                  validator: (String eCarte) {
                                    double eCartesiana =
                                        double.tryParse(eCarte);
                                    if (eCartesiana == null) {
                                      return 'La Coordenada Este, está en un formato no valido';
                                    } else {
                                      setState(() {
                                        esteCartesianas = eCartesiana;
                                      });
                                      return null;
                                    }
                                  },
                                ),
                                TextFormField(
                                  decoration: InputDecoration(
                                    icon: Icon(Icons.add_location),
                                    labelText: 'Altura',
                                  ),
                                  keyboardType: TextInputType.number,
                                  validator: (String aCar) {
                                    double aCartesiana = double.tryParse(aCar);
                                    if (aCartesiana == null) {
                                      return 'La Altura, está en un formato no valido';
                                    } else {
                                      setState(() {
                                        alturaCartesianas = aCartesiana;
                                      });
                                      return null;
                                    }
                                  },
                                ),
                                Divider(height: 30.0),
                              ],
                            ),
                          ),
                          FlatButton(
                              shape: new RoundedRectangleBorder(
                                  borderRadius:
                                      new BorderRadius.circular(20.0)),
                              child: Text(
                                'Importar',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 12.0,
                                  color: Colors.white,
                                ),
                              ),
                              color: Color(0xff007FFF),
                              onPressed: () async {
                                if (_formCartesianas.currentState.validate()) {
                                  ConversionCoordenadasMB
                                      conversionCoordenadasMB =
                                      ConversionCoordenadasMB();
                                  CoordenadasCartesianas
                                      coordenadasCartesianas =
                                      CoordenadasCartesianas();
                                  coordenadasCartesianas.este = esteCartesianas;
                                  coordenadasCartesianas.norte =
                                      norteCartesianas;
                                  coordenadasCartesianas.altura =
                                      alturaCartesianas;
                                  CoordenadasElipsoidales
                                      coordenadasElipsoidales =
                                      conversionCoordenadasMB
                                          .cartesianas2Elipoidales(
                                              coordenadasCartesianas,
                                              widget.cartesianasCS);
                                  CPlanasGenerico planasGenerico =
                                      await coordenadasInportadas(
                                          coordenadasElipsoidales.latitud,
                                          coordenadasElipsoidales.longitud,
                                          coordenadasElipsoidales.altitud);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            PuntoIgacImportado(
                                          altura: planasGenerico.altura,
                                          datosProyecto: widget.datosProyecto,
                                          este: roundDouble(
                                              planasGenerico.este, 3),
                                          nombrePunto: 'SIN NOMBRAR',
                                          ondulacion: 0,
                                          norte: roundDouble(
                                              planasGenerico.norte, 3),
                                        ),
                                      ));
                                }
                              })
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
        );
      }
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
              child: Text('      Conversión Punto',
                  style: TextStyle(fontSize: 12, color: Colors.white)),
            ),
          )
        ],
      ),
    );
  }
}
