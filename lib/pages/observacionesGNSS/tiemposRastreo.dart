import 'dart:async';
import 'dart:collection';
import 'package:geodesy/geodesy.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong/latlong.dart';
import 'package:measurebookapp/clases/database.dart';
import 'package:measurebookapp/clases/funcionesGenericas.dart';
import 'package:measurebookapp/modelos/MagnaECO.dart';
import 'package:measurebookapp/modelos/RedPasivaIGACPuntos.dart';
import 'package:measurebookapp/modelos/proyectos.dart';
import 'package:measurebookapp/modelos/tiemposRastreoM.dart';
import 'package:measurebookapp/pages/conversionCoordenadas.dart';
import 'package:measurebookapp/pages/gestorPuntos.dart';
import 'package:measurebookapp/pages/menuPrincipal.dart';
import 'package:measurebookapp/pages/nivelaciones.dart';
import 'package:measurebookapp/pages/observacionesGNSS/observacionGNSSVertice.dart';
import 'package:measurebookapp/pages/poligonales/poligonalesMain.dart';
import 'package:user_location/user_location.dart';
import 'package:measurebookapp/modelos/GeoRED.dart';
import 'package:share/share.dart';

class TiemposRastreoGNSS extends StatefulWidget {
  int estaciones, norma;
  final proyectos datosProyecto;
  TiemposRastreoGNSS({Key key, this.estaciones, this.datosProyecto, this.norma})
      : super(key: key);

  @override
  _TiemposRastreoGNSSState createState() => _TiemposRastreoGNSSState();
}

class _TiemposRastreoGNSSState extends State<TiemposRastreoGNSS> {
  MapController mapController = MapController();
  UserLocationOptions userLocationOptions;
  List<Marker> markersUserLocation = [];
  List<Marker> markersClauster = [];
  double latitud = 4.5970903;
  double longitud = -74.0656485;
  Timer _timer;
  String norma = 'IGAC RES 643 30/05/2018';
  String estacionesRef = 'Red Magna ECO';
  List<Marker> puntoMarcadorTiempo;
  List<Widget> listaEstaciones = List<Widget>();
  @override
  void initState() {
    super.initState();
    if (widget.norma == 0) {
      setState(() {
        norma = 'IGAC RES 643 30/05/2018';
      });
    } else if (widget.norma == 1) {
      setState(() {
        norma = 'IDU Elab. Estudios Top.';
      });
    } else if (widget.norma == 2) {
      setState(() {
        norma = 'EAB NS-030';
      });
    }

    if (widget.estaciones == 0) {
      setState(() {
        estacionesRef = 'Red Magna ECO';
      });
    } else if (widget.estaciones == 1) {
      setState(() {
        estacionesRef = 'GeoRED';
      });
    }
    _timer = Timer.periodic(Duration(milliseconds: 100), (_) {
      puntoMarcadorTiempo = [
        Marker(
            height: 50,
            width: 80,
            point: LatLng(latitud, longitud),
            builder: (ctx) => Icon(
                  Icons.location_searching,
                  size: 50,
                  color: Colors.blueAccent,
                ))
      ];
    });
  }

  int _index = 0;
  @override
  Widget build(BuildContext context) {
    userLocationOptions = UserLocationOptions(
        context: context,
        markers: markersUserLocation,
        mapController: mapController,
        updateMapLocationOnPositionChange: false);

    var circulosPunto = <CircleMarker>[
      CircleMarker(
          point: LatLng(latitud, longitud),
          color: Colors.transparent,
          borderStrokeWidth: 0.5,
          borderColor: Colors.black.withOpacity(0.3),
          useRadiusInMeter: true,
          radius: 20000),
      CircleMarker(
          point: LatLng(latitud, longitud),
          color: Colors.transparent,
          borderStrokeWidth: 0.5,
          borderColor: Colors.black.withOpacity(0.7),
          useRadiusInMeter: true,
          radius: 40000),
      CircleMarker(
          point: LatLng(latitud, longitud),
          color: Colors.transparent,
          borderColor: Colors.black,
          borderStrokeWidth: 0.5,
          useRadiusInMeter: true,
          radius: 60000),
      CircleMarker(
          point: LatLng(latitud, longitud),
          color: Colors.blueAccent.withOpacity(0.15),
          borderColor: Colors.black.withOpacity(0.9),
          borderStrokeWidth: 0.5,
          useRadiusInMeter: true,
          radius: 80000),
    ];

    puntoMarcadorTiempo = [
      Marker(
          height: 50,
          width: 80,
          point: LatLng(latitud, longitud),
          builder: (context) => FlatButton(
              onPressed: () {},
              child: Icon(
                Icons.location_searching,
                size: 50,
                color: Colors.blueAccent,
              )))
    ];

    if (estacionesRef == 'Red Magna ECO') {
      return Scaffold(
        body: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: FutureBuilder(
              future: gestorMBDatabase.db.getMagnaECO(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  List<MagnaEco> listaEst = List<MagnaEco>();
                  if (snapshot.data.length > 0) {
                    for (var i = 0; i < snapshot.data.length; i++) {
                      MagnaEco listaPuntos = snapshot.data[i];
                      listaEst.add(listaPuntos);
                      markersClauster.add(Marker(
                          anchorPos: AnchorPos.align(AnchorAlign.center),
                          point:
                              LatLng(listaPuntos.latitud, listaPuntos.longitud),
                          builder: (ctx) => FloatingActionButton(
                                heroTag: 'RedPasivaIgac_1${i}',
                                backgroundColor: Colors.transparent,
                                child: Icon(Icons.location_on,
                                    size: 40, color: Colors.blueAccent),
                                onPressed: () {
                                  AlertDialog datosMagnaEco = AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                    content: Container(
                                      height: 150,
                                      width: 200,
                                      child: SingleChildScrollView(
                                        child: Column(
                                          children: <Widget>[
                                            Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                '${listaPuntos.nombre}',
                                                style: TextStyle(
                                                    fontFamily: 'Roboto',
                                                    color: Colors.blueAccent,
                                                    fontSize: 16.0),
                                              ),
                                            ),
                                            Divider(),
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
                                            Align(
                                                alignment: Alignment.center,
                                                child: Image.asset(
                                                    'assets/images/igac.png',
                                                    height: 50)),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                  showDialog(
                                      context: context,
                                      barrierDismissible: true,
                                      builder: (BuildContext context) {
                                        return datosMagnaEco;
                                      });
                                },
                              )));
                    }
                    return Scaffold(
                      body: Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: <Widget>[
                            Stack(
                              children: <Widget>[
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * .5,
                                  width: MediaQuery.of(context).size.width,
                                  child: FlutterMap(
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
                                              child: Text(
                                                  markers.length.toString()),
                                              backgroundColor: Colors.black54,
                                            );
                                          }),
                                      MarkerLayerOptions(
                                          markers: markersUserLocation),
                                      MarkerLayerOptions(
                                          markers: puntoMarcadorTiempo),
                                      CircleLayerOptions(
                                          circles: circulosPunto),
                                      userLocationOptions,
                                    ],
                                    mapController: mapController,
                                  ),
                                ),
                                Positioned(
                                    left:
                                        (MediaQuery.of(context).size.width / 2),
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.5,
                                      width: 2,
                                      color: Colors.black54,
                                    )),
                                Positioned(
                                    top: MediaQuery.of(context).size.height *
                                        0.25,
                                    child: Container(
                                      height: 2,
                                      width: MediaQuery.of(context).size.width,
                                      color: Colors.black54,
                                    )),
                                Positioned(
                                    left: (MediaQuery.of(context).size.width /
                                            2) -
                                        25,
                                    top: (MediaQuery.of(context).size.height *
                                            0.25) -
                                        25,
                                    child: Icon(Icons.location_searching,
                                        size: 50)),
                                Positioned(
                                    bottom: 10,
                                    left: 20,
                                    child: Row(
                                      children: <Widget>[
                                        Icon(Icons.location_searching,
                                            color: Colors.black, size: 50),
                                        SizedBox(width: 0),
                                        FlatButton(
                                            onPressed: () {
                                              setState(() {
                                                actualizarPuntos();
                                              });
                                            },
                                            child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    color: Colors.black87),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    'Establecer Ubicación',
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.white),
                                                  ),
                                                )))
                                      ],
                                    ))
                              ],
                            ),
                            Divider(),
                            Center(
                              child: Text('Coordenadas Punto de referencia',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.blueAccent,
                                      fontFamily: 'Reboto')),
                            ),
                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text('Latitud:   ',
                                    style: TextStyle(
                                        color: Colors.black54, fontSize: 12)),
                                Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Colors.blueAccent),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        FuncionesGenericas.mb
                                            .decimal2Hexadecimal(latitud),
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.white),
                                      ),
                                    )),
                                SizedBox(width: 30),
                                Text('Longitud:   ',
                                    style: TextStyle(
                                        color: Colors.black54, fontSize: 12)),
                                Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Colors.blueAccent),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        FuncionesGenericas.mb
                                            .decimal2Hexadecimal(longitud),
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.white),
                                      ),
                                    ))
                              ],
                            ),
                            Divider(height: 10),
                            FlatButton(
                                onPressed: () {
                                  tiempoRastreo(
                                      LatLng(latitud, longitud), listaEst);
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Colors.blueAccent),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Calcular tiempos de Rastreo',
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.white),
                                      ),
                                    ))),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                          blurRadius: 2, color: Colors.black26)
                                    ]),
                                height: 170,
                                child: SingleChildScrollView(
                                    child: Column(
                                  children: listaEstaciones,
                                )),
                              ),
                            ),
                          ],
                        ),
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
        ),
      );
    } else if (estacionesRef == 'GeoRED') {
      return Scaffold(
        body: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: FutureBuilder(
              future: gestorMBDatabase.db.getGeoRED(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  List<GeoRED> listaEst = List<GeoRED>();
                  if (snapshot.data.length > 0) {
                    for (var i = 0; i < snapshot.data.length; i++) {
                      GeoRED listaPuntos = snapshot.data[i];
                      listaEst.add(listaPuntos);
                      markersClauster.add(Marker(
                          anchorPos: AnchorPos.align(AnchorAlign.center),
                          point:
                              LatLng(listaPuntos.latitud, listaPuntos.longitud),
                          builder: (ctx) => FloatingActionButton(
                                heroTag: 'GeoRED${i}',
                                backgroundColor: Colors.transparent,
                                child: Icon(Icons.location_on,
                                    size: 40, color: Colors.blueAccent),
                                onPressed: () {
                                  AlertDialog datosMagnaEco = AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                    content: Container(
                                      height: 180,
                                      width: 250,
                                      child: SingleChildScrollView(
                                        child: Column(
                                          children: <Widget>[
                                            Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                '${listaPuntos.nombre}',
                                                style: TextStyle(
                                                    fontFamily: 'Roboto',
                                                    color: Colors.blueAccent,
                                                    fontSize: 16.0),
                                              ),
                                            ),
                                            Divider(),
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
                                            Align(
                                                alignment: Alignment.center,
                                                child: Image.asset(
                                                    'assets/images/minas.png',
                                                    height: 50)),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                  showDialog(
                                      context: context,
                                      barrierDismissible: true,
                                      builder: (BuildContext context) {
                                        return datosMagnaEco;
                                      });
                                },
                              )));
                    }
                    return Scaffold(
                      body: SingleChildScrollView(
                        child: Container(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            children: <Widget>[
                              Stack(
                                children: <Widget>[
                                  Container(
                                    height:
                                        MediaQuery.of(context).size.height * .5,
                                    width: MediaQuery.of(context).size.width,
                                    child: FlutterMap(
                                      options: MapOptions(
                                          center:
                                              LatLng(4.5970903, -74.0656485),
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
                                                child: Text(
                                                    markers.length.toString()),
                                                backgroundColor: Colors.black54,
                                              );
                                            }),
                                        MarkerLayerOptions(
                                            markers: markersUserLocation),
                                        MarkerLayerOptions(
                                            markers: puntoMarcadorTiempo),
                                        CircleLayerOptions(
                                            circles: circulosPunto),
                                        userLocationOptions,
                                      ],
                                      mapController: mapController,
                                    ),
                                  ),
                                  Positioned(
                                      left: (MediaQuery.of(context).size.width /
                                          2),
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.5,
                                        width: 2,
                                        color: Colors.black54,
                                      )),
                                  Positioned(
                                      top: MediaQuery.of(context).size.height *
                                          0.25,
                                      child: Container(
                                        height: 2,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        color: Colors.black54,
                                      )),
                                  Positioned(
                                      left: (MediaQuery.of(context).size.width /
                                              2) -
                                          25,
                                      top: (MediaQuery.of(context).size.height *
                                              0.25) -
                                          25,
                                      child: Icon(Icons.location_searching,
                                          size: 50)),
                                  Positioned(
                                      bottom: 10,
                                      left: 20,
                                      child: Row(
                                        children: <Widget>[
                                          Icon(Icons.location_searching,
                                              color: Colors.black, size: 50),
                                          SizedBox(width: 0),
                                          FlatButton(
                                              onPressed: () {
                                                setState(() {
                                                  actualizarPuntos();
                                                });
                                              },
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      color: Colors.black87),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      'Establecer Ubicación',
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.white),
                                                    ),
                                                  )))
                                        ],
                                      ))
                                ],
                              ),
                              Divider(),
                              Center(
                                child: Text('Coordenadas Punto de referencia',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.blueAccent,
                                        fontFamily: 'Reboto')),
                              ),
                              Divider(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text('Latitud:   ',
                                      style: TextStyle(
                                          color: Colors.black54, fontSize: 12)),
                                  Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: Colors.blueAccent),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          FuncionesGenericas.mb
                                              .decimal2Hexadecimal(latitud),
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.white),
                                        ),
                                      )),
                                  SizedBox(width: 10),
                                  Text('Longitud:   ',
                                      style: TextStyle(
                                          color: Colors.black54, fontSize: 12)),
                                  Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: Colors.blueAccent),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          FuncionesGenericas.mb
                                              .decimal2Hexadecimal(longitud),
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.white),
                                        ),
                                      ))
                                ],
                              ),
                              Divider(height: 5),
                              FlatButton(
                                  onPressed: () {
                                    tiempoRastreoGeoRED(
                                        LatLng(latitud, longitud), listaEst);
                                  },
                                  child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: Colors.blueAccent),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          'Calcular tiempos de Rastreo',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.white),
                                        ),
                                      ))),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                            blurRadius: 2,
                                            color: Colors.black26)
                                      ]),
                                  height: 170,
                                  child: SingleChildScrollView(
                                      child: Column(
                                    children: listaEstaciones,
                                  )),
                                ),
                              ),
                            ],
                          ),
                        ),
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
        ),
      );
    }
  }

  List<TiemposRastreoM> tiempoRastreo(
      LatLng puntoCalculo, List<MagnaEco> estaciones) {
    List<TiemposRastreoM> listaTiemposRastreo = List<TiemposRastreoM>();
    listaTiemposRastreo.clear();
    Geodesy geodesy = Geodesy();
    for (var i = 0; i < estaciones.length - 1; i++) {
      LatLng estacion = LatLng(estaciones[i].latitud, estaciones[i].longitud);
      listaTiemposRastreo.add(TiemposRastreoM(
        latitud: latitud,
        longitud: longitud,
        nombre: estaciones[i].nombre,
        distancia: geodesy.distanceBetweenTwoGeoPoints(puntoCalculo, estacion),
        entidadRespondable: norma,
        tiempoRastreo: FuncionesGenericas.mb.tiempoRastreo(
            geodesy.distanceBetweenTwoGeoPoints(puntoCalculo, estacion), norma),
      ));
    }
    listaTiemposRastreo.sort((a, b) => a.distancia.compareTo(b.distancia));
    List<Widget> lista = List<Widget>();
    for (var i = 0; i < 9; i++) {
      lista.add(ListTile(
        dense: true,
        leading: Icon(Icons.my_location, size: 30, color: Colors.blueAccent),
        title: Text(listaTiemposRastreo[i].nombre,
            style: TextStyle(color: Colors.blueAccent, fontSize: 12)),
        subtitle:
            Text('Tiempos de Rastreo: ${listaTiemposRastreo[i].tiempoRastreo}'),
        trailing: Icon(Icons.share),
        onTap: () {
          Share.share('Calculo de Tiempos de Rastreo MeasureBookAPP \n\n' +
              'Red de Referencia: ${estacionesRef} \n' +
              'Coordenadas Punto de Cálculo \n' +
              'Latitud: ${FuncionesGenericas.mb.decimal2Hexadecimal(latitud)}\n' +
              'Longitud: ${FuncionesGenericas.mb.decimal2Hexadecimal(longitud)}\n\n' +
              'Estación de Referencia: ${listaTiemposRastreo[i].nombre}\n' +
              'Distancia (Km): ${FuncionesGenericas.mb.redondearDouble(listaTiemposRastreo[i].distancia / 1000, 3)}\n' +
              'Norma de Referencia: ${norma}\n' +
              'Tiempos de Rastreo: ${listaTiemposRastreo[i].tiempoRastreo}\n');
        },
      ));
      lista.add(Divider(
        height: 3,
      ));
    }
    setState(() {
      listaEstaciones = lista;
    });
  }

  List<TiemposRastreoM> tiempoRastreoGeoRED(
      LatLng puntoCalculo, List<GeoRED> estaciones) {
    List<TiemposRastreoM> listaTiemposRastreo = List<TiemposRastreoM>();
    listaTiemposRastreo.clear();
    Geodesy geodesy = Geodesy();
    for (var i = 0; i < estaciones.length - 1; i++) {
      LatLng estacion = LatLng(estaciones[i].latitud, estaciones[i].longitud);
      listaTiemposRastreo.add(TiemposRastreoM(
        latitud: latitud,
        longitud: longitud,
        nombre: estaciones[i].nombre,
        distancia: geodesy.distanceBetweenTwoGeoPoints(puntoCalculo, estacion),
        entidadRespondable: norma,
        tiempoRastreo: FuncionesGenericas.mb.tiempoRastreo(
            geodesy.distanceBetweenTwoGeoPoints(puntoCalculo, estacion), norma),
      ));
    }
    listaTiemposRastreo.sort((a, b) => a.distancia.compareTo(b.distancia));
    List<Widget> lista = List<Widget>();
    for (var i = 0; i < 9; i++) {
      lista.add(ListTile(
        dense: true,
        leading: Icon(Icons.my_location, size: 30, color: Colors.blueAccent),
        title: Text(listaTiemposRastreo[i].nombre,
            style: TextStyle(color: Colors.blueAccent, fontSize: 12)),
        subtitle:
            Text('Tiempos de Rastreo: ${listaTiemposRastreo[i].tiempoRastreo}'),
        trailing: Icon(Icons.share),
        onTap: () {
          Share.share('Calculo de Tiempos de Rastreo MeasureBookAPP \n\n' +
              'Red de Referencia: ${estacionesRef} \n' +
              'Coordenadas Punto de Cálculo \n' +
              'Latitud: ${FuncionesGenericas.mb.decimal2Hexadecimal(latitud)}\n' +
              'Longitud: ${FuncionesGenericas.mb.decimal2Hexadecimal(longitud)}\n\n' +
              'Estación de Referencia: ${listaTiemposRastreo[i].nombre}\n' +
              'Distancia (Km): ${FuncionesGenericas.mb.redondearDouble(listaTiemposRastreo[i].distancia / 1000, 3)}\n' +
              'Norma de Referencia: ${norma}\n' +
              'Tiempos de Rastreo: ${listaTiemposRastreo[i].tiempoRastreo}\n');
        },
      ));
      lista.add(Divider(
        height: 3,
      ));
    }
    setState(() {
      listaEstaciones = lista;
    });
  }

  actualizarPuntos() {
    setState(() {
      latitud = mapController.center.latitude;
      longitud = mapController.center.longitude;
    });
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
              child: Text('      Calcular Tiempos de Rastreo',
                  style: TextStyle(fontSize: 12, color: Colors.white)),
            ),
          )
        ],
      ),
    );
  }
}
