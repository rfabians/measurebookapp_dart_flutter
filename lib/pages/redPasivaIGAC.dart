import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong/latlong.dart';
import 'package:measurebookapp/clases/database.dart';
import 'package:measurebookapp/modelos/RedPasivaIGACPuntos.dart';
import 'package:user_location/user_location.dart';
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
      updateMapLocationOnPositionChange: false
      );

    return Scaffold(
      body: FutureBuilder(
        future: gestorMBDatabase.db.getPuntosRedPIGAC(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData){
          if(snapshot.data.length > 0) {
            for (var i = 0; i < snapshot.data.length; i++) {
              
              redPIGACPuntos listaPuntos = snapshot.data[i];
              markersClauster.add(
                Marker(
                    anchorPos: AnchorPos.align(AnchorAlign.center),
                    point: LatLng(listaPuntos.Latitud, listaPuntos.Longitud),
                    builder: (ctx) => FloatingActionButton(
                    backgroundColor: Colors.transparent,
                    child: Icon(Icons.location_on, size: 40, color: Colors.blueAccent),
                    onPressed: (){
                    AlertDialog datosPuntoRedPasiva = AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)
                      ),
                      title: Text(listaPuntos.Nomenclatu),
                      content: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                      height: 400,
                      width: 250,
                      child: SingleChildScrollView(
                      child: Padding(padding: EdgeInsets.all(15.0),
                      child: Column(
                      children: <Widget>[
                      Text(listaPuntos.Municipio),
                      Text(listaPuntos.Latitud.toString())
                      ],
                      ),
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
                  )
              );
             
            }
            return  Scaffold(
            body: FlutterMap(
            options: MapOptions(
            center: LatLng(0, 0),
            zoom: 15,
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
            onPressed: null,
            child: Text(markers.length.toString()),
            backgroundColor: Colors.black54,
            );
                                }
            ),
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
          }
          else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          
        },
      ),
    );
  }
}