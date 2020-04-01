import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:measurebookapp/clases/database.dart';
import 'package:measurebookapp/modelos/RedPasivaIGACPuntos.dart';
import 'package:user_location/user_location.dart';
import 'package:geojson/geojson.dart';
import 'package:latlong/latlong.dart';
import 'package:map_controller/map_controller.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';

class RedPasivaIGAC extends StatefulWidget {
  RedPasivaIGAC({Key key}) : super(key: key);

  @override
  _RedPasivaIGACState createState() => _RedPasivaIGACState();

}

class _RedPasivaIGACState extends State<RedPasivaIGAC> {
  List<Marker> markers = List<Marker>();
  List<Marker> ubicacionUser = List<Marker>();
  MapController mapController = MapController();
  UserLocationOptions userLocationOptions;
  redPIGACPuntos listaPuntosRedPasivaIGACDB = redPIGACPuntos();
  @override
  Widget build(BuildContext context) {
    userLocationOptions = UserLocationOptions(
    context: context,
        mapController: mapController,
        markers: ubicacionUser,
        updateMapLocationOnPositionChange: false,
        showMoveToCurrentLocationFloatingActionButton: true,
        zoomToCurrentLocationOnLoad: true,
        fabBottom: 50,
        fabRight: 50,
        verbose: false
    );
    return Scaffold(
       body: Container(
         child: FutureBuilder(
           future: gestorMBDatabase.db.getPuntosRedPIGAC(),
           builder: (BuildContext context, AsyncSnapshot snapshot) {
             if (snapshot.hasData) {
               if(snapshot.data.length>0) {
                 for (int i = 0; i < snapshot.data.length-1; i++) {
                   redPIGACPuntos listaPuntosRedPasivaIGACDB = snapshot.data[i];
                    markers.add(Marker(
                     anchorPos: AnchorPos.align(AnchorAlign.center),
                     point: LatLng(listaPuntosRedPasivaIGACDB.Latitud,listaPuntosRedPasivaIGACDB.Longitud),
                     builder: (ctx) => FloatingActionButton(
                      backgroundColor: Colors.transparent,
                       child: Icon(Icons.location_on, size: 40, color: Colors.blueAccent),
                       onPressed: (){
                         AlertDialog datosPuntoRedPasiva = AlertDialog(
                           title: Text(listaPuntosRedPasivaIGACDB.Nomenclatu),
                           content: Container(
                             height: 400,
                             width: 250,
                             child: SingleChildScrollView(
                               child: Padding(padding: EdgeInsets.all(15.0),
                               child: Column(
                                 children: <Widget>[
                                   Text(listaPuntosRedPasivaIGACDB.Municipio),
                                   Text(listaPuntosRedPasivaIGACDB.Latitud.toString())
                                 ],
                               ),
                               ),
                             ),
                           ),
                         );
                         showDialog(context: context, barrierDismissible: true, builder: (BuildContext context){
                           return datosPuntoRedPasiva;
                         });
                       },
                       )
                   ));
                 }
                 return FlutterMap(
                   options: MapOptions(    
                     center: LatLng(4.597085, -74.0656539),
                     zoom: 17,           
                     plugins: [
                       MarkerClusterPlugin(),
                       UserLocationPlugin()
                     ]
                   ),
                   layers: [
                     userLocationOptions,
                     TileLayerOptions(
                       urlTemplate: 'https://mt1.google.com/vt/lyrs=r&x={x}&y={y}&z={z}',
                     ),
                     MarkerClusterLayerOptions(
                       maxClusterRadius: 120,
                       size: Size(60, 40),
                       fitBoundsOptions: FitBoundsOptions(
                         padding: EdgeInsets.all(50),
                       ),
                       markers: markers,
                       polygonOptions: PolygonOptions(
                         borderColor: Colors.black54,
                         color: Colors.black12,
                         borderStrokeWidth: 3
                       ),
                       builder: (context, markers) {
                         return FloatingActionButton(
                           child: Text(markers.length.toString()),
                           backgroundColor: Colors.black54,
                           onPressed: null
                           );
                       }
                       ),
                       MarkerLayerOptions(markers: ubicacionUser),
                   ],
                   mapController: mapController,
                   );

               }else {
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