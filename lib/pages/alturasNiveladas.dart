import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong/latlong.dart';
import 'package:measurebookapp/clases/conversionCoordenadasMB.dart';
import 'package:measurebookapp/clases/database.dart';
import 'package:measurebookapp/modelos/altNiveladas.dart';
import 'package:measurebookapp/modelos/cPlanasGenerico.dart';
import 'package:measurebookapp/modelos/cartesianasCS.dart';
import 'package:measurebookapp/modelos/coordenadasCartesianas.dart';
import 'package:measurebookapp/modelos/coordenadasElipsoidales.dart';
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
import 'package:url_launcher/url_launcher.dart';
import 'package:user_location/user_location.dart';
import 'dart:math' as m;

class AlturaNiveladasMap extends StatefulWidget {
  proyectos datosProyecto;
  AlturaNiveladasMap({Key key, this.datosProyecto}) : super(key: key);

  @override
  _AlturaNiveladasMapState createState() => _AlturaNiveladasMapState();
}

class _AlturaNiveladasMapState extends State<AlturaNiveladasMap> {
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
  MapController mapController = MapController();
  UserLocationOptions userLocationOptions;
  List<Marker> markersUserLocation = [];
  List<Marker> markersClauster = [];
  Widget build(BuildContext context) {
    userLocationOptions = UserLocationOptions(
        context: context,
        markers: markersUserLocation,
        mapController: mapController,
        updateMapLocationOnPositionChange: false);

    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: gestorMBDatabase.db.getPuntosAlturasNiveladasPIGAC(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.length > 0) {
                for (var i = 0; i < snapshot.data.length; i++) {
                  AltNiveladas listaPuntos = snapshot.data[i];
                  markersClauster.add(Marker(
                      height: 60,
                      width: 200,
                      anchorPos: AnchorPos.align(AnchorAlign.center),
                      point: LatLng(listaPuntos.latitud, listaPuntos.longitud),
                      builder: (ctx) => FloatingActionButton(
                            heroTag: 'AlturasNiveladas ${i}',
                            backgroundColor: Colors.transparent,
                            child: Column(
                              children: [
                                Text(listaPuntos.nomenclatura,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold)),
                                Icon(Icons.my_location_rounded,
                                    size: 40, color: Colors.white),
                              ],
                            ),
                            onPressed: () {
                              AlertDialog datosPuntoRedPasiva = AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0)),
                                content: Container(
                                  height: 400,
                                  width: 250,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          child: ListTile(
                                            title: Text(
                                              'Nomenclatura Punto: ${listaPuntos.nomenclatura}',
                                              style: TextStyle(
                                                  color: Colors.blueAccent,
                                                  fontSize: 14.0),
                                            ),
                                            onTap: () {},
                                          ),
                                        ),
                                        Divider(
                                          height: 20.0,
                                        ),
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            'Datos Básicos',
                                            style: TextStyle(
                                                fontFamily: 'Roboto',
                                                color: Colors.blueAccent,
                                                fontSize: 12.0),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            'Municipio',
                                            style: TextStyle(
                                                fontFamily: 'Roboto',
                                                color: Colors.black54,
                                                fontSize: 12.0),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            '${listaPuntos.municipio}',
                                            style: TextStyle(
                                                fontFamily: 'Roboto',
                                                color: Colors.blueAccent,
                                                fontSize: 14.0),
                                          ),
                                        ),
                                        Divider(),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            'Departamento',
                                            style: TextStyle(
                                                fontFamily: 'Roboto',
                                                color: Colors.black54,
                                                fontSize: 12.0),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            '${listaPuntos.departamento}',
                                            style: TextStyle(
                                                fontFamily: 'Roboto',
                                                color: Colors.blueAccent,
                                                fontSize: 14.0),
                                          ),
                                        ),
                                        Divider(),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            'Estado del Punto',
                                            style: TextStyle(
                                                fontFamily: 'Roboto',
                                                color: Colors.black54,
                                                fontSize: 12.0),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            '${listaPuntos.estPunto}',
                                            style: TextStyle(
                                                fontFamily: 'Roboto',
                                                color: Colors.blueAccent,
                                                fontSize: 14.0),
                                          ),
                                        ),
                                        Divider(),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            'Fecha de Instalación',
                                            style: TextStyle(
                                                fontFamily: 'Roboto',
                                                color: Colors.black54,
                                                fontSize: 12.0),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            '${listaPuntos.fecha}',
                                            style: TextStyle(
                                                fontFamily: 'Roboto',
                                                color: Colors.blueAccent,
                                                fontSize: 14.0),
                                          ),
                                        ),
                                        Divider(),
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            'Coordenadas Elipsoidales',
                                            style: TextStyle(
                                                fontFamily: 'Roboto',
                                                color: Colors.blueAccent,
                                                fontSize: 12.0),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            'Latitud',
                                            style: TextStyle(
                                                fontFamily: 'Roboto',
                                                color: Colors.black54,
                                                fontSize: 12.0),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            '${listaPuntos.latitud}',
                                            style: TextStyle(
                                                fontFamily: 'Roboto',
                                                color: Colors.blueAccent,
                                                fontSize: 14.0),
                                          ),
                                        ),
                                        Divider(),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            'Longitud',
                                            style: TextStyle(
                                                fontFamily: 'Roboto',
                                                color: Colors.black54,
                                                fontSize: 12.0),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            '${listaPuntos.longitud}',
                                            style: TextStyle(
                                                fontFamily: 'Roboto',
                                                color: Colors.blueAccent,
                                                fontSize: 14.0),
                                          ),
                                        ),
                                        Divider(),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            'Altura Nivelada (Alt. Ortometrica)',
                                            style: TextStyle(
                                                fontFamily: 'Roboto',
                                                color: Colors.black54,
                                                fontSize: 12.0),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            '${listaPuntos.zNivelada}',
                                            style: TextStyle(
                                                fontFamily: 'Roboto',
                                                color: Colors.blueAccent,
                                                fontSize: 14.0),
                                          ),
                                        ),
                                        Divider(),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            'Ondulación Geoidal',
                                            style: TextStyle(
                                                fontFamily: 'Roboto',
                                                color: Colors.black54,
                                                fontSize: 12.0),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            '${listaPuntos.ondulacion}',
                                            style: TextStyle(
                                                fontFamily: 'Roboto',
                                                color: Colors.blueAccent,
                                                fontSize: 14.0),
                                          ),
                                        ),
                                        Divider(),
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            'Coordenadas Geocéntricas',
                                            style: TextStyle(
                                                fontFamily: 'Roboto',
                                                color: Colors.blueAccent,
                                                fontSize: 12.0),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            'X',
                                            style: TextStyle(
                                                fontFamily: 'Roboto',
                                                color: Colors.black54,
                                                fontSize: 12.0),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            '${listaPuntos.x}',
                                            style: TextStyle(
                                                fontFamily: 'Roboto',
                                                color: Colors.blueAccent,
                                                fontSize: 14.0),
                                          ),
                                        ),
                                        Divider(),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            'Y',
                                            style: TextStyle(
                                                fontFamily: 'Roboto',
                                                color: Colors.black54,
                                                fontSize: 12.0),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            '${listaPuntos.y}',
                                            style: TextStyle(
                                                fontFamily: 'Roboto',
                                                color: Colors.blueAccent,
                                                fontSize: 14.0),
                                          ),
                                        ),
                                        Divider(),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            'Z',
                                            style: TextStyle(
                                                fontFamily: 'Roboto',
                                                color: Colors.black54,
                                                fontSize: 12.0),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            '${listaPuntos.z}',
                                            style: TextStyle(
                                                fontFamily: 'Roboto',
                                                color: Colors.blueAccent,
                                                fontSize: 14.0),
                                          ),
                                        ),
                                        Divider(),
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            'Velocidades',
                                            style: TextStyle(
                                                fontFamily: 'Roboto',
                                                color: Colors.blueAccent,
                                                fontSize: 12.0),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            'Vx',
                                            style: TextStyle(
                                                fontFamily: 'Roboto',
                                                color: Colors.black54,
                                                fontSize: 12.0),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            '${listaPuntos.vx}',
                                            style: TextStyle(
                                                fontFamily: 'Roboto',
                                                color: Colors.blueAccent,
                                                fontSize: 14.0),
                                          ),
                                        ),
                                        Divider(),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            'Vy',
                                            style: TextStyle(
                                                fontFamily: 'Roboto',
                                                color: Colors.black54,
                                                fontSize: 12.0),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            '${listaPuntos.vy}',
                                            style: TextStyle(
                                                fontFamily: 'Roboto',
                                                color: Colors.blueAccent,
                                                fontSize: 14.0),
                                          ),
                                        ),
                                        Divider(),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            'Vz',
                                            style: TextStyle(
                                                fontFamily: 'Roboto',
                                                color: Colors.black54,
                                                fontSize: 12.0),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            '${listaPuntos.vz}',
                                            style: TextStyle(
                                                fontFamily: 'Roboto',
                                                color: Colors.blueAccent,
                                                fontSize: 14.0),
                                          ),
                                        ),
                                        Divider(),
                                        Center(
                                          child: new InkWell(
                                            child: Column(
                                              children: [
                                                Text(
                                                  'Navegar Google Maps',
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.blueAccent),
                                                ),
                                                Divider(),
                                                Image.asset(
                                                    'assets/images/google-maps.png',
                                                    height: 70),
                                              ],
                                            ),
                                            onTap: () async {
                                              String urlMaps =
                                                  'http://www.google.com/maps/place/${listaPuntos.latitud},${listaPuntos.longitud}';
                                              if (await canLaunch(urlMaps)) {
                                                await launch(urlMaps);
                                              } else {
                                                throw 'Error en el direccionamiento a Maps';
                                              }
                                            },
                                          ),
                                        ),
                                        Divider(),
                                        Center(
                                          child: new InkWell(
                                            child: Column(
                                              children: [
                                                Text(
                                                  'Navegar con Waze',
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.blueAccent),
                                                ),
                                                Divider(),
                                                Image.asset(
                                                    'assets/images/waze.png',
                                                    height: 70),
                                              ],
                                            ),
                                            onTap: () async {
                                              String urlMaps =
                                                  'https://waze.com/ul?q=${listaPuntos.latitud},${listaPuntos.longitud}';
                                              if (await canLaunch(urlMaps)) {
                                                await launch(urlMaps);
                                              } else {
                                                throw 'Error en el direccionamiento a Waze';
                                              }
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                              showDialog(
                                  context: context,
                                  barrierDismissible: true,
                                  builder: (BuildContext context) {
                                    return datosPuntoRedPasiva;
                                  });
                            },
                          )));
                }
                return Scaffold(
                  body: FlutterMap(
                    options: MapOptions(
                        center: LatLng(4.5970903, -74.0656485),
                        zoom: 17,
                        plugins: [
                          UserLocationPlugin(),
                          MarkerClusterPlugin(),
                        ]),
                    layers: [
                      TileLayerOptions(
                          urlTemplate:
                              'https://server.arcgisonline.com/ArcGIS/rest/services/World_Topo_Map/MapServer/tile/{z}/{y}/{x}'),
                      MarkerClusterLayerOptions(
                          maxClusterRadius: 120,
                          size: Size(50, 50),
                          fitBoundsOptions: FitBoundsOptions(
                            padding: EdgeInsets.all(50),
                          ),
                          markers: markersClauster,
                          polygonOptions: PolygonOptions(
                              borderColor: Colors.black54,
                              color: Colors.black12,
                              borderStrokeWidth: 3),
                          builder: (context, markers) {
                            return FloatingActionButton(
                              onPressed: null,
                              child: Text(markers.length.toString()),
                              backgroundColor: Colors.black54,
                              heroTag: 'AlturaNiveladasMap',
                            );
                          }),
                      MarkerLayerOptions(markers: markersUserLocation),
                      userLocationOptions,
                    ],
                    mapController: mapController,
                  ),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
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
              child: Text('      Importar puntos con altura Nivelada',
                  style: TextStyle(fontSize: 12, color: Colors.white)),
            ),
          )
        ],
      ),
    );
  }
}
