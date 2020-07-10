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
          .getOrigenCartesianoData(widget.datosProyecto.Tipo_Proyeccion);
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
        child: FutureBuilder(
          future: gestorMBDatabase.db.getPuntosAlturasNiveladasPIGAC(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.length > 0) {
                for (var i = 0; i < snapshot.data.length; i++) {
                  AltNiveladas listaPuntos = snapshot.data[i];
                  markersClauster.add(Marker(
                      anchorPos: AnchorPos.align(AnchorAlign.center),
                      point: LatLng(listaPuntos.latitud, listaPuntos.longitud),
                      builder: (ctx) => FloatingActionButton(
                            heroTag: 'AlturasNiveladas ${i}',
                            backgroundColor: Colors.transparent,
                            child: Icon(Icons.location_on,
                                size: 40, color: Colors.blueAccent),
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
                                              'Importar Punto ${listaPuntos.nomenclatura}',
                                              style: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 16.0),
                                            ),
                                            onTap: () async {
                                              CPlanasGenerico
                                                  coordenadasSalida =
                                                  CPlanasGenerico();
                                              coordenadasSalida =
                                                  await coordenadasInportadas(
                                                      listaPuntos.latitud,
                                                      listaPuntos.longitud,
                                                      listaPuntos.zNivelada);
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          PuntoIgacImportado(
                                                            altura: roundDouble(
                                                                listaPuntos
                                                                    .zNivelada,
                                                                3),
                                                            nombrePunto:
                                                                listaPuntos
                                                                    .nomenclatura,
                                                            norte: roundDouble(
                                                                coordenadasSalida
                                                                    .norte,
                                                                3),
                                                            este: roundDouble(
                                                                coordenadasSalida
                                                                    .este,
                                                                3),
                                                            ondulacion: 0,
                                                            datosProyecto: widget
                                                                .datosProyecto,
                                                          )));
                                            },
                                            trailing: Icon(
                                              Icons.chevron_right,
                                              color: Colors.blueAccent,
                                            ),
                                            leading: Image.asset(
                                              'assets/images/import.png',
                                              height: 100,
                                            ),
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
