import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong/latlong.dart';
import 'package:measurebookapp/clases/conversionCoordenadasMB.dart';
import 'package:measurebookapp/clases/database.dart';
import 'package:measurebookapp/modelos/cPlanasGenerico.dart';
import 'package:measurebookapp/modelos/cartesianasCS.dart';
import 'package:measurebookapp/modelos/coordenadasCartesianas.dart';
import 'package:measurebookapp/modelos/coordenadasElipsoidales.dart';
import 'package:measurebookapp/modelos/coordenadasON.dart';
import 'package:measurebookapp/modelos/coordenadasPlanasGauss.dart';
import 'package:measurebookapp/modelos/gaussCS.dart';
import 'package:measurebookapp/modelos/proyectos.dart';
import 'package:measurebookapp/modelos/puntosReferencia.dart';
import 'package:measurebookapp/pages/conversionCoordenadas.dart';
import 'package:measurebookapp/pages/gestorPuntos.dart';
import 'package:measurebookapp/pages/menuPrincipal.dart';
import 'package:measurebookapp/pages/nivelaciones.dart';
import 'package:measurebookapp/pages/observacionesGNSS/observacionGNSSVertice.dart';
import 'package:measurebookapp/pages/poligonales/poligonalesMain.dart';
import 'package:user_location/user_location.dart';
import 'package:flare_flutter/flare_actor.dart';

class MapaPuntosReferencia extends StatefulWidget {
  final proyectos datosProyecto;
  const MapaPuntosReferencia({Key key, this.datosProyecto}) : super(key: key);

  @override
  _MapaPuntosReferenciaState createState() => _MapaPuntosReferenciaState();
}

class _MapaPuntosReferenciaState extends State<MapaPuntosReferencia> {
  int _index = 0;

  MapController mapController = MapController();

  UserLocationOptions userLocationOptions;

  List<Marker> markersUserLocation = [];

  List<Marker> markersClauster = [];

  Future<List<puntosReferencia>> listaPuntosRef() async {
    if (widget.datosProyecto.Tipo_Proyeccion == 'Gauss-Krüger') {
      GaussCS gaussCS = await gestorMBDatabase.db
          .getOrigenGaussData(widget.datosProyecto.ID_Proyeccion);
      List<puntosReferencia> listaRef = await gestorMBDatabase.db
          .getPuntosReferenciaData(widget.datosProyecto.Nombre_Proyecto);
      int cont = listaRef.length;
      ConversionCoordenadasMB conversionCoordenadasMB =
          ConversionCoordenadasMB();

      for (var i = 0; i < cont; i++) {
        List<CoordenadasElipsoidales> listCoorElip =
            List<CoordenadasElipsoidales>(cont);
        listCoorElip[i] = conversionCoordenadasMB.gauss2Elipsoidales(
            gaussCS,
            CoordenadasGauss(
                norte: listaRef[i].Norte,
                este: listaRef[i].Este,
                altura: listaRef[i].Altura));
        listaRef[i].latitud = listCoorElip[i].latitud;
        listaRef[i].longitud = listCoorElip[i].longitud;
        listaRef[i].Altura = listCoorElip[i].altitud;
      }
      return listaRef;
    } else if (widget.datosProyecto.Tipo_Proyeccion == 'Plano Cartesiano') {
      CartesianasCS cartesianasCS = await gestorMBDatabase.db
          .getOrigenCartesianoData(widget.datosProyecto.ID_Proyeccion);
      List<puntosReferencia> listaRef = await gestorMBDatabase.db
          .getPuntosReferenciaData(widget.datosProyecto.Nombre_Proyecto);
      int cont = listaRef.length;
      ConversionCoordenadasMB conversionCoordenadasMB =
          ConversionCoordenadasMB();
      for (var i = 0; i < cont; i++) {
        List<CoordenadasElipsoidales> listCoorElip =
            List<CoordenadasElipsoidales>(cont);
        listCoorElip[i] = conversionCoordenadasMB.cartesianas2Elipoidales(
            CoordenadasCartesianas(
                norte: listaRef[i].Norte,
                este: listaRef[i].Este,
                altura: listaRef[i].Altura),
            cartesianasCS);
        listaRef[i].latitud = listCoorElip[i].latitud;
        listaRef[i].longitud = listCoorElip[i].longitud;
        listaRef[i].Altura = listCoorElip[i].altitud;
      }
      return listaRef;
    } else if (widget.datosProyecto.Tipo_Proyeccion ==
        'Transversal de Mercator') {
      List<puntosReferencia> listaRef = await gestorMBDatabase.db
          .getPuntosReferenciaData(widget.datosProyecto.Nombre_Proyecto);
      int cont = listaRef.length;
      ConversionCoordenadasMB conversionCoordenadasMB =
          ConversionCoordenadasMB();
      for (var i = 0; i < cont; i++) {
        List<CoordenadasElipsoidales> listCoorElip =
            List<CoordenadasElipsoidales>(cont);
        listCoorElip[i] = conversionCoordenadasMB.origenNacional2Elipsoidales(
            CoordenadasON(
                norte: listaRef[i].Norte,
                este: listaRef[i].Este,
                altura: listaRef[i].Altura));
        listaRef[i].latitud = listCoorElip[i].latitud;
        listaRef[i].longitud = listCoorElip[i].longitud;
        listaRef[i].Altura = listCoorElip[i].altitud;
      }
      return listaRef;
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

    userLocationOptions = UserLocationOptions(
        context: context,
        markers: markersUserLocation,
        mapController: mapController,
        updateMapLocationOnPositionChange: false);
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
          future: listaPuntosRef(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.length > 0) {
                for (var i = 0; i < snapshot.data.length; i++) {
                  puntosReferencia listaPuntos = snapshot.data[i];
                  Image ftoPlaca =
                      Image.memory(base64Decode(listaPuntos.Foto_Placa));

                  markersClauster.add(Marker(
                      anchorPos: AnchorPos.align(AnchorAlign.center),
                      point: LatLng(listaPuntos.latitud, listaPuntos.longitud),
                      builder: (ctx) => FloatingActionButton(
                            heroTag: 'RedPasivaIgac_1100${i}',
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
                                        Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            '${listaPuntos.Nombre_Punto}',
                                            style: TextStyle(
                                                fontFamily: 'Roboto',
                                                color: Colors.blueAccent,
                                                fontSize: 16.0),
                                          ),
                                        ),
                                        Divider(),
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            'Coordenadas del Punto',
                                            style: TextStyle(
                                                fontFamily: 'Roboto',
                                                color: Colors.blueAccent,
                                                fontSize: 12.0),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            'Norte',
                                            style: TextStyle(
                                                fontFamily: 'Roboto',
                                                color: Colors.black54,
                                                fontSize: 12.0),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            '${listaPuntos.Norte}',
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
                                            'Este',
                                            style: TextStyle(
                                                fontFamily: 'Roboto',
                                                color: Colors.black54,
                                                fontSize: 12.0),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            '${listaPuntos.Este}',
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
                                            'Altura',
                                            style: TextStyle(
                                                fontFamily: 'Roboto',
                                                color: Colors.black54,
                                                fontSize: 12.0),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            '${listaPuntos.Altura}',
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
                                            'Tipo Altura',
                                            style: TextStyle(
                                                fontFamily: 'Roboto',
                                                color: Colors.black54,
                                                fontSize: 12.0),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            '${listaPuntos.Tipo_Altura}',
                                            style: TextStyle(
                                                fontFamily: 'Roboto',
                                                color: Colors.blueAccent,
                                                fontSize: 14.0),
                                          ),
                                        ),
                                        Divider(),
                                        Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            'Foto Placa',
                                            style: TextStyle(
                                                fontFamily: 'Roboto',
                                                color: Colors.blueAccent,
                                                fontSize: 16.0),
                                          ),
                                        ),
                                        Container(
                                            child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                child: ftoPlaca))
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
                              heroTag: 'importarPuntoRedPasivaIgac_1',
                            );
                          }),
                      MarkerLayerOptions(markers: markersUserLocation),
                      userLocationOptions,
                    ],
                    mapController: mapController,
                  ),
                );
              } else {
                return Scaffold(
                    //Inicio
                    body: Center(
                        child: Container(
                  child: FlareActor(
                    'assets/images/forki.flr',
                    animation: 'forki',
                  ),
                ))
                    //Final
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
              child: Text('      Mapa de puntos de referencia',
                  style: TextStyle(fontSize: 12, color: Colors.white)),
            ),
          )
        ],
      ),
    );
  }
}
