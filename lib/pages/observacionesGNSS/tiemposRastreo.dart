import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong/latlong.dart';
import 'package:measurebookapp/clases/database.dart';
import 'package:measurebookapp/modelos/MagnaECO.dart';
import 'package:measurebookapp/modelos/RedPasivaIGACPuntos.dart';
import 'package:user_location/user_location.dart';

class TiemposRastreoGNSS extends StatefulWidget {
  TiemposRastreoGNSS({Key key}) : super(key: key);

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
  List<Marker> puntoMarcadorTiempo;
  @override
  void initState() { 
    super.initState();
    
    _timer = Timer.periodic(Duration(milliseconds: 100), (_) {
      puntoMarcadorTiempo = [
      Marker(
        height: 50,
        width: 80,
        point: LatLng(latitud, longitud),
        builder: (ctx)=> Icon(Icons.location_searching, size: 50, color: Colors.blueAccent,)
      )
    ];
     });
  }
 
  @override
  Widget build(BuildContext context) {

    userLocationOptions = UserLocationOptions(
      context: context, 
      markers: markersUserLocation,
      mapController: mapController,
      updateMapLocationOnPositionChange: false
      );
      
    puntoMarcadorTiempo= [Marker(
      height: 50,
      width: 80,
      point: LatLng(latitud, longitud),
      builder: (context)=> FlatButton(onPressed: (){}, 
      child: Icon(Icons.location_searching, size: 50, color: Colors.blueAccent,)
      )
    )
    
    ];
    

    return Scaffold(
      body: SafeArea(
        child: Container(
          child: FutureBuilder(
            future: gestorMBDatabase.db.getMagnaECO(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData){
              if(snapshot.data.length > 0) {
                for (var i = 0; i < snapshot.data.length; i++) {
                  MagnaEco listaPuntos = snapshot.data[i];
                  markersClauster.add(
                    Marker(
                        anchorPos: AnchorPos.align(AnchorAlign.center),
                        point: LatLng(listaPuntos.latitud, listaPuntos.longitud),
                        builder: (ctx) => FloatingActionButton(
                        heroTag: 'RedPasivaIgac_1${i}',
                        backgroundColor: Colors.transparent,
                        child: Icon(Icons.location_on, size: 40, color: Colors.blueAccent),
                        onPressed: (){
                        AlertDialog datosMagnaEco = AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)
                          ),
                          content: Container(
                          height: 150,
                          width: 200,
                          child: SingleChildScrollView(
                          child: Column(
                          children: <Widget>[
                          Align(alignment: Alignment.center,child: Text('${listaPuntos.nombre}', style: TextStyle(fontFamily: 'Roboto',color: Colors.blueAccent,fontSize: 16.0),),),
                          Divider(),
                          Align(alignment: Alignment.centerRight,child: Text('Latitud', style: TextStyle(fontFamily: 'Roboto',color: Colors.black54,fontSize: 12.0),),),
                          Align(alignment: Alignment.centerRight,child: Text('${listaPuntos.latitud}', style: TextStyle(fontFamily: 'Roboto',color: Colors.blueAccent,fontSize: 14.0),),),
                          Divider(),
                          Align(alignment: Alignment.centerRight,child: Text('Longitud', style: TextStyle(fontFamily: 'Roboto',color: Colors.black54,fontSize: 12.0),),),
                          Align(alignment: Alignment.centerRight,child: Text('${listaPuntos.longitud}', style: TextStyle(fontFamily: 'Roboto',color: Colors.blueAccent,fontSize: 14.0),),),
                          Align(alignment: Alignment.center,child: Image.asset('assets/images/igac.png', height: 50)),
                          ],
                          ),
                          ),
                          ),
                        );
                        showDialog(context: context, barrierDismissible: true, builder: (BuildContext context){
                        return datosMagnaEco;
                        });
                        },
                        )
                      )
                  );
                 
                }
                return  Scaffold(
                body: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                              Container(
                                  height: 500,
                                  width: MediaQuery.of(context).size.width,
                                  child: FlutterMap(
                                  options: MapOptions(
                                  center: LatLng(4.5970903, -74.0656485),
                                  zoom: 17,
                                  plugins: [
                                  UserLocationPlugin(),
                                  MarkerClusterPlugin(),
                              ]
                            ),
                            layers: [
                              TileLayerOptions(
                                  urlTemplate: 'https://server.arcgisonline.com/ArcGIS/rest/services/World_Topo_Map/MapServer/tile/{z}/{y}/{x}'
                              ),
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
                                  borderStrokeWidth: 3
                                  ),
                                  builder: (context, markers) {
                                  return FloatingActionButton(
                                    heroTag: 'RedPasivaIgac_3',
                                  onPressed: null,
                                  child: Text(markers.length.toString()),
                                  backgroundColor: Colors.black54,
                                  );
                                                      }
                                  ),
                              MarkerLayerOptions(markers: markersUserLocation),
                              MarkerLayerOptions(
                                  markers: puntoMarcadorTiempo
                              ),
                              userLocationOptions,
                            ],
                            mapController: mapController,
                            ),
                          ),
                          Positioned(
                            left: (MediaQuery.of(context).size.width/2),
                            child: Container(
                            height: 500,
                            width: 2,
                            color: Colors.black54,
                          )),
                          Positioned(
                            top: 250,
                            child: Container(
                            height: 2,
                            width: MediaQuery.of(context).size.width,
                            color: Colors.black54,
                          )),
                          Positioned(
                            left: (MediaQuery.of(context).size.width/2)-25,
                            top: 225,
                            child: Icon(Icons.location_searching, size: 50)),
                          Positioned(
                            bottom: 10,
                            left: 20,
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.location_searching, color: Colors.black, size: 50),
                                SizedBox(width: 0),
                                FlatButton(onPressed: (){
                                  setState(() {
                                    actualizarPuntos();
                                  });
                                }, 
                                child: Container(
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.black87),
                                  child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('Establecer Ubicación', style: TextStyle(fontSize: 12, color: Colors.white),),
                                ))
                                )
                              ],
                            )
                          )
                        ],
                      )
                      ],
                  ),
                ),
              );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              }
              else {
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

 actualizarPuntos(){
   setState(() {
     latitud = mapController.center.latitude;
     longitud = mapController.center.longitude;
   });
 }
}