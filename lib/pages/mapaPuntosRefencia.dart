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
import 'package:measurebookapp/modelos/coordenadasPlanasGauss.dart';
import 'package:measurebookapp/modelos/gaussCS.dart';
import 'package:measurebookapp/modelos/puntosReferencia.dart';
import 'package:user_location/user_location.dart';

class MapaPuntosReferencia extends StatefulWidget {
  final String nombreProyecto, sistemaCoordenadas, idCoordenadas;
  const MapaPuntosReferencia({Key key, this.nombreProyecto, this.sistemaCoordenadas, this.idCoordenadas}) : super(key: key);

  @override
  _MapaPuntosReferenciaState createState() => _MapaPuntosReferenciaState();
}

class _MapaPuntosReferenciaState extends State<MapaPuntosReferencia> {
  MapController mapController = MapController();

  UserLocationOptions userLocationOptions;

  List<Marker> markersUserLocation = [];

  List<Marker> markersClauster = [];

  Future<List<puntosReferencia>>  listaPuntosRef () async {
  if (widget.sistemaCoordenadas == 'Gauss-Krüger')  {
    GaussCS gaussCS = await gestorMBDatabase.db.getOrigenGaussData(widget.idCoordenadas);
    List<puntosReferencia> listaRef = await gestorMBDatabase.db.getPuntosReferenciaData(widget.nombreProyecto);
    int cont = listaRef.length;
    ConversionCoordenadasMB conversionCoordenadasMB = ConversionCoordenadasMB();

    for (var i = 0; i < cont; i++) {
    List<CoordenadasElipsoidales> listCoorElip = List<CoordenadasElipsoidales>(cont);
    listCoorElip[i] = conversionCoordenadasMB.gauss2Elipsoidales(gaussCS, CoordenadasGauss(norte: listaRef[i].Norte, este: listaRef[i].Este, altura: listaRef[i].Altura));
    listaRef[i].latitud = listCoorElip[i].latitud;
    listaRef[i].longitud = listCoorElip[i].longitud;
    listaRef[i].Altura = listCoorElip[i].altitud;
    }
    return listaRef;
    
  }else {
    CartesianasCS cartesianasCS = await gestorMBDatabase.db.getOrigenCartesianoData(widget.idCoordenadas);
    List<puntosReferencia> listaRef = await gestorMBDatabase.db.getPuntosReferenciaData(widget.nombreProyecto);
    int cont = listaRef.length;
    ConversionCoordenadasMB conversionCoordenadasMB = ConversionCoordenadasMB();
    for (var i = 0; i < cont; i++) {
    List<CoordenadasElipsoidales> listCoorElip = List<CoordenadasElipsoidales>(cont);
    listCoorElip[i] = conversionCoordenadasMB.cartesianas2Elipoidales(CoordenadasCartesianas(norte: listaRef[i].Norte, este: listaRef[i].Este, altura: listaRef[i].Altura), cartesianasCS);
    listaRef[i].latitud = listCoorElip[i].latitud;
    listaRef[i].longitud = listCoorElip[i].longitud;
    listaRef[i].Altura = listCoorElip[i].altitud;
    }
    return listaRef;
  }
}


  @override
  Widget build(BuildContext context) {
    userLocationOptions = UserLocationOptions(
      context: context, 
      markers: markersUserLocation,
      mapController: mapController,
      updateMapLocationOnPositionChange: false
      );
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: listaPuntosRef(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData){
            if(snapshot.data.length > 0) {
              for (var i = 0; i < snapshot.data.length; i++) {
                puntosReferencia listaPuntos = snapshot.data[i]; 
                markersClauster.add(
                  Marker(
                      anchorPos: AnchorPos.align(AnchorAlign.center),
                      point: LatLng(listaPuntos.latitud, listaPuntos.longitud),
                      builder: (ctx) => FloatingActionButton(
                        heroTag: 'RedPasivaIgac_1100${i}',
                      backgroundColor: Colors.transparent,
                      child: Icon(Icons.location_on, size: 40, color: Colors.blueAccent),
                      onPressed: (){
                      AlertDialog datosPuntoRedPasiva = AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)
                        ),
                        content: Container(
                        height: 400,
                        width: 250,
                        child: SingleChildScrollView(
                        child: Column(
                        children: <Widget>[
                        Align(alignment: Alignment.center,child: Text('${listaPuntos.Nombre_Punto}', style: TextStyle(fontFamily: 'Roboto',color: Colors.blueAccent,fontSize: 16.0),),),
                        Divider(),
                        Align(alignment: Alignment.centerLeft,child: Text('Coordenadas del Punto', style: TextStyle(fontFamily: 'Roboto',color: Colors.blueAccent,fontSize: 12.0),),),
                        Align(alignment: Alignment.centerRight,child: Text('Norte', style: TextStyle(fontFamily: 'Roboto',color: Colors.black54,fontSize: 12.0),),),
                        Align(alignment: Alignment.centerRight,child: Text('${listaPuntos.Norte}', style: TextStyle(fontFamily: 'Roboto',color: Colors.blueAccent,fontSize: 14.0),),),
                        Divider(),
                        Align(alignment: Alignment.centerRight,child: Text('Este', style: TextStyle(fontFamily: 'Roboto',color: Colors.black54,fontSize: 12.0),),),
                        Align(alignment: Alignment.centerRight,child: Text('${listaPuntos.Este}', style: TextStyle(fontFamily: 'Roboto',color: Colors.blueAccent,fontSize: 14.0),),),
                        Divider(),
                        Align(alignment: Alignment.centerRight,child: Text('Altura', style: TextStyle(fontFamily: 'Roboto',color: Colors.black54,fontSize: 12.0),),),
                        Align(alignment: Alignment.centerRight,child: Text('${listaPuntos.Altura}', style: TextStyle(fontFamily: 'Roboto',color: Colors.blueAccent,fontSize: 14.0),),),
                        Divider(),
                        Align(alignment: Alignment.centerRight,child: Text('Tipo Altura', style: TextStyle(fontFamily: 'Roboto',color: Colors.black54,fontSize: 12.0),),),
                        Align(alignment: Alignment.centerRight,child: Text('${listaPuntos.Tipo_Altura}', style: TextStyle(fontFamily: 'Roboto',color: Colors.blueAccent,fontSize: 14.0),),),
                        Divider(),
                        ],
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
              onPressed: null,
              child: Text(markers.length.toString()),
              backgroundColor: Colors.black54,
              heroTag: 'importarPuntoRedPasivaIgac_1',
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
      ),
    );
  }
}