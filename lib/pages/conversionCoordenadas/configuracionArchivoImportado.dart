import 'dart:io';
import 'dart:typed_data';
import 'package:csv/csv.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:measurebookapp/clases/conversionCoordenadasMB.dart';
import 'package:measurebookapp/modelos/coordenadasElipsoidales.dart';
import 'package:measurebookapp/modelos/coordenadasGeocenticas.dart';
import 'package:path_provider/path_provider.dart';

class ConfiguracionArchivoImportado extends StatefulWidget {
  final String origenCS, destinoCS;
  final List<List<dynamic>> dataCSV;
  ConfiguracionArchivoImportado({Key key, this.destinoCS, this.origenCS, this.dataCSV}) : super(key: key);

  @override
  _ConfiguracionArchivoImportadoState createState() => _ConfiguracionArchivoImportadoState();
}

class _ConfiguracionArchivoImportadoState extends State<ConfiguracionArchivoImportado> {
  bool encabezado = true;
  int indexIDElip;
  int indexLatitud;
  int indexLongitud;
  int indexAlturaElip;
  List<Widget> camposCSVFILE = List<Widget>();
  @override
  @override
  void initState() { 
    super.initState(
    );
    camposCSV();
  }
  Widget build(BuildContext context) {
    

    if(widget.destinoCS == 'Elipsoidales'){
      alertaIgualSystemCoor();
      Navigator.pop(context);
    } else if(widget.destinoCS == 'Geocentricas'){
      return Scaffold(
       body: SafeArea(
         child: SingleChildScrollView(
           child: Center(
             child: Padding(
               padding: const EdgeInsets.all(15.0),
               child: Column(
                 children: <Widget>[
                   Image.asset('assets/images/csv_load.png', height: 80),
                   SizedBox(height: 10),
                   Text('Conversión de archivo CSV con coordenadas ${widget.origenCS} a ${widget.destinoCS}', textAlign: TextAlign.center, style: TextStyle(color: Colors.blueAccent, fontSize: 13),),
                   Divider(),
                   Text('Archivo con encabezado',style: TextStyle(color: Colors.black54),),
                   CupertinoSwitch(
                     activeColor: Colors.blueAccent,
                     value: encabezado, 
                     onChanged: (bool switchEncabezado) {
                       setState(() {
                         encabezado = switchEncabezado;
                       });
                     }
                     ),
                    Divider(),
                    Container(
                      height: 440,
                      width: MediaQuery.of(context).size.width,
                      child: encabezado
                      //Archivo con Encabezado
                      ?Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 5,
                              color: Colors.black54,
                              offset: Offset(0, 5)
                            )
                          ]
                        ),
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text('Seleccione el nombre del Campo que contiene los valores de la Latitud', textAlign: TextAlign.center, style: TextStyle(color: Colors.blueAccent, fontSize: 13),),
                            ),
                            Divider(thickness: 5),
                            Row(
                              children: <Widget>[
                                Container(
                                  width: MediaQuery.of(context).size.width/2-30,
                                  height: 80,
                                   child: Center(child: Text('Identificador del Punto: ', style:  TextStyle(color: Colors.black54, fontSize: 13),)),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width/2-30,
                                  height: 80,
                                  child: CupertinoPicker(
                                  squeeze: .9,
                                  looping: false,
                                  diameterRatio: 20,
                                  backgroundColor: Colors.white,
                                  itemExtent: 20, 
                                  onSelectedItemChanged: (index){
                                     setState(() {
                                       indexIDElip = index;
                                     });
                                  }, 
                                  children: camposCSVFILE
                                  ),
                                ),

                              ],
                            ),
                            Divider(thickness: 5),
                            Row(
                              children: <Widget>[
                                Container(
                                  width: MediaQuery.of(context).size.width/2-30,
                                  height: 80,
                                   child: Center(child: Text('Latitud ', style:  TextStyle(color: Colors.black54, fontSize: 13),)),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width/2-30,
                                  height: 80,
                                  child: CupertinoPicker(
                                  squeeze: .9,
                                  looping: false,
                                  diameterRatio: 20,
                                  backgroundColor: Colors.white,
                                  itemExtent: 20, 
                                  onSelectedItemChanged: (index){
                                    setState(() {
                                       indexLatitud = index;
                                     });
                                  }, 
                                  children: camposCSVFILE
                                  ),
                                ),
                              ],
                            ),
                            Divider(thickness: 5),
                            Row(
                              children: <Widget>[
                                Container(
                                  width: MediaQuery.of(context).size.width/2-30,
                                  height: 80,
                                   child: Center(child: Text('Longitud ', style:  TextStyle(color: Colors.black54, fontSize: 13),)),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width/2-30,
                                  height: 80,
                                  child: CupertinoPicker(
                                  squeeze: .9,
                                  looping: false,
                                  diameterRatio: 20,
                                  backgroundColor: Colors.white,
                                  itemExtent: 20, 
                                  onSelectedItemChanged: (index){
                                    setState(() {
                                       indexLongitud = index;
                                     });
                                  }, 
                                  children: camposCSVFILE
                                  ),
                                ),
                              
                              ],
                            ),
                            Divider(thickness: 5),
                            Row(
                              children: <Widget>[
                                Container(
                                  width: MediaQuery.of(context).size.width/2-30,
                                  height: 80,
                                   child: Center(child: Text('Altura: ', style:  TextStyle(color: Colors.black54, fontSize: 13),)),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width/2-30,
                                  height: 80,
                                  child: CupertinoPicker(
                                  squeeze: .9,
                                  looping: false,
                                  diameterRatio: 20,
                                  backgroundColor: Colors.white,
                                  itemExtent: 20, 
                                  onSelectedItemChanged: (index){
                                    setState(() {
                                       indexAlturaElip = index;
                                     });
                                  }, 
                                  children: camposCSVFILE
                                  ),
                                ),
                              
                              ],
                            )
                          ],
                        ),
                      )
                      //Archivo sin Encabezado
                      :Container(
                        child: Text('Sin encabezado'),
                      )
                    ),
                    Center(
                      child: FlatButton(
                        onPressed: ()async{
                          List<List<dynamic>> puntosElip2Geocentricas = List<List<dynamic>>(widget.dataCSV.length);
                          List<String> puntos0 = List(4);
                          puntos0[0] = 'ID Punto';
                          puntos0[1] = 'X Geocentrica';
                          puntos0[2] = 'Y Geocentrica';
                          puntos0[3] = 'Z Geocentrica';
                          puntosElip2Geocentricas[0]=puntos0;
                          List<dynamic> datosCSVImport = List();
                          datosCSVImport = widget.dataCSV;
                          for (var i = 1; i < widget.dataCSV.length; i++) {
                            List<dynamic> puntos = List(4);
                            puntos = datosCSVImport[i];
                            CoordenadasGeocentricas coorGeo = CoordenadasGeocentricas();
                            CoordenadasElipsoidales coorElip = CoordenadasElipsoidales();
                            coorElip.latitud = puntos[indexLatitud];
                            coorElip.longitud = puntos[indexLongitud];
                            coorElip.altitud = puntos[indexAlturaElip];
                            ConversionCoordenadasMB conversionCoordenadasMB = ConversionCoordenadasMB();
                            coorGeo = conversionCoordenadasMB.elipsoidales2Geocentricas(coorElip);
                            puntos[0] = puntos[indexIDElip];
                            puntos[1] = double.parse(coorGeo.x.toString());
                            puntos[2] = double.parse(coorGeo.y.toString());
                            puntos[3] = double.parse(coorGeo.z.toString());
                            puntosElip2Geocentricas[i] = puntos;
                          }
                          final Directory directorio = await getApplicationDocumentsDirectory();
                          final File csvGuardar = File('${directorio.path}/MeasureBookConversiónGeocentricas.csv');
                          String datosCSV = const ListToCsvConverter().convert(puntosElip2Geocentricas);
                          await csvGuardar.writeAsString(datosCSV);
                          Uint8List arCSv = csvGuardar.readAsBytesSync();
                          //final ByteData archivoCSV = await File('${directorio.path}/MeasureBookConversiónGeocentricas.csv').readAsBytes().then((data) => ByteData.view(data as ByteBuffer));
                          await Share.file('Conversion Archivos MeasureBookAPP', 'MeasureBookConversiónGeocentricas.csv', arCSv, 'file/csv', text: 'Conversión de Coordenadas MeasureBook');
                        }, 
                        child: Text('Exportar Coordenadas Convertidas a CSV')
                        ),
                    )
                 ],
               ),
             ),
           ),
         )
         ),
    );
    }else if(widget.destinoCS == 'Gauss - Krüger'){
      return Container(
        child: Center(child: Text('Gauss - Krüger'),),
      );
    }else if(widget.destinoCS == 'Planas Cartesianas'){
      return Container(
        child: Center(child: Text('Gauss - Krüger'),),
      );
    }
  }
  void camposCSV(){
      
    for (var i = 0; i < widget.dataCSV[0].length; i++) {
      camposCSVFILE.add(Text('${widget.dataCSV[0][i]}', style: TextStyle(color: Colors.blueAccent, fontSize: 13),)); 
      print('${widget.dataCSV[0][i]}');
    }
  }
  // Mensaje cuando se tiene el mismo sistema de Coordenadas
    void alertaIgualSystemCoor(){
    Fluttertoast.showToast(
    msg: "El sistema de Partida es igual al de destino ",
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 2
    );
  }
}