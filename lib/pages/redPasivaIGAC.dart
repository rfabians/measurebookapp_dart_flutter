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
  redPIGACPuntos listaPuntosRedPasivaIGACDB = redPIGACPuntos();
  @override
  Widget build(BuildContext context) {
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
                     height: 40,
                     width: 40,
                     point: LatLng(listaPuntosRedPasivaIGACDB.Latitud,listaPuntosRedPasivaIGACDB.Longitud),
                     builder: (ctx) => Icon(Icons.pin_drop)
                   ));
                 }
                 return FlutterMap(
                   options: MapOptions(
                     plugins: [
                       MarkerClusterPlugin()
                     ]
                   ),
                   layers: [
                     TileLayerOptions(
                       urlTemplate: 'https://server.arcgisonline.com/ArcGIS/rest/services/World_Topo_Map/MapServer/tile/{z}/{y}/{x}',
                     ),
                     MarkerClusterLayerOptions(
                       maxClusterRadius: 120,
                       size: Size(40, 40),
                       fitBoundsOptions: FitBoundsOptions(
                         padding: EdgeInsets.all(50),
                       ),
                       markers: markers,
                       polygonOptions: PolygonOptions(
                         borderColor: Colors.blueAccent,
                         color: Colors.black12,
                         borderStrokeWidth: 3
                       ),
                       builder: (context, markers) {
                         return FloatingActionButton(
                           child: Text(markers.length.toString()),
                           onPressed: null
                           );
                       }
                       )
                   ],
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