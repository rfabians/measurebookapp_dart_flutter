import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong/latlong.dart';
import 'package:measurebookapp/clases/database.dart';
import 'package:measurebookapp/modelos/RedPasivaIGACPuntos.dart';
import 'package:user_location/user_location.dart';
import 'package:url_launcher/url_launcher.dart';

class RedPasivaIgac extends StatefulWidget {
  RedPasivaIgac({Key key}) : super(key: key);

  @override
  _RedPasivaIgacState createState() => _RedPasivaIgacState();
}

class _RedPasivaIgacState extends State<RedPasivaIgac> {
  // Inicialización de Variables
  MapController mapController = MapController();
  UserLocationOptions userLocationOptions;
  List<Marker> markersUserLocation = [];
  List<Marker> markersClauster = [];
  // Contrucción de UI
  @override
  Widget build(BuildContext context) {
    userLocationOptions = UserLocationOptions(
        context: context,
        markers: markersUserLocation,
        mapController: mapController,
        updateMapLocationOnPositionChange: false);

    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: gestorMBDatabase.db.getPuntosRedPIGAC(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.length > 0) {
                for (var i = 0; i < snapshot.data.length; i++) {
                  redPIGACPuntos listaPuntos = snapshot.data[i];
                  markersClauster.add(Marker(
                      height: 60,
                      width: 200,
                      anchorPos: AnchorPos.align(AnchorAlign.center),
                      point: LatLng(listaPuntos.Latitud, listaPuntos.Longitud),
                      builder: (ctx) => FloatingActionButton(
                            heroTag: 'RedPasivaIgac_1',
                            backgroundColor: Colors.transparent,
                            child: Column(
                              children: [
                                Text(listaPuntos.Nomenclatu,
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
                                        Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            '${listaPuntos.Nomenclatu}',
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
                                            '${listaPuntos.Municipio}',
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
                                            '${listaPuntos.Departamen}',
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
                                            '${listaPuntos.Estado_pun}',
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
                                            '${listaPuntos.FECHA}',
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
                                            '${listaPuntos.Latitud}',
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
                                            '${listaPuntos.Longitud}',
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
                                            'Altura Elipsoidal',
                                            style: TextStyle(
                                                fontFamily: 'Roboto',
                                                color: Colors.black54,
                                                fontSize: 12.0),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            '${listaPuntos.Altura_eli}',
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
                                            '${listaPuntos.Ondulacion}',
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
                                            'Coordenadas Geocentricas',
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
                                            '${listaPuntos.X}',
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
                                            '${listaPuntos.Y}',
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
                                            '${listaPuntos.Z}',
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
                                            '${listaPuntos.Vx}',
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
                                            '${listaPuntos.Vy}',
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
                                            '${listaPuntos.Vz}',
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
                                                  'http://www.google.com/maps/place/${listaPuntos.Latitud},${listaPuntos.Longitud}';
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
                                                  'https://waze.com/ul?q=${listaPuntos.Latitud},${listaPuntos.Longitud}';
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
                              heroTag: 'RedPasivaIgac_3',
                              onPressed: null,
                              child: Text(markers.length.toString()),
                              backgroundColor: Colors.black54,
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
}
