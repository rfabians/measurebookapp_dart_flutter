import 'dart:io';
import 'dart:typed_data';
import 'package:csv/csv.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:measurebookapp/clases/conversionCoordenadasMB.dart';
import 'package:measurebookapp/clases/database.dart';
import 'package:measurebookapp/modelos/cartesianasCS.dart';
import 'package:measurebookapp/modelos/coordenadasCartesianas.dart';
import 'package:measurebookapp/modelos/coordenadasElipsoidales.dart';
import 'package:measurebookapp/modelos/coordenadasGeocenticas.dart';
import 'package:measurebookapp/modelos/coordenadasPlanasGauss.dart';
import 'package:measurebookapp/modelos/departamentos.dart';
import 'package:measurebookapp/modelos/gaussCS.dart';
import 'package:measurebookapp/modelos/municipios.dart';
import 'package:measurebookapp/modelos/origenesCartesianos.dart';
import 'package:measurebookapp/modelos/origenesGauss.dart';
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
  bool origenGauss = false;
  int indexLongitud;
  int indexAlturaElip;
  bool origenCartesiano = false;
  bool validacion = true;
  GaussCS gaussCOrigen = GaussCS();
  CartesianasCS origenCartesian =CartesianasCS();
  List<Widget> camposCSVFILE = List<Widget>();
  @override
  @override
  void initState() { 
    super.initState(
    );
    camposCSV();
  }
  Widget build(BuildContext context) { 
    // Conversión de archivo Sistema de Partida Elipsoidal;
    if (widget.origenCS == 'Elipsoidales'){
      if(widget.destinoCS == 'Elipsoidales'){
      alertaIgualSystemCoor();
      Navigator.pop(context);
    } 
    //Coordenads Elipsoidales 2 Gecentricas 
    else if(widget.destinoCS == 'Geocentricas'){
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
                    ),
                    Center(
                      child: FlatButton(
                        onPressed: ()async{
                          if(indexIDElip == indexLatitud){
                            alertaIndexCoor('ID Punto', 'Latitud');
                          } else if(indexIDElip == indexLongitud){
                            alertaIndexCoor('ID Punto', 'Longitud');
                          } else if(indexIDElip == indexAlturaElip){
                            alertaIndexCoor('ID Punto', 'Altura');
                          } else if(indexLatitud == indexLongitud){
                            alertaIndexCoor('Latitud', 'Longitud');
                          } else if(indexLatitud == indexAlturaElip){
                            alertaIndexCoor('Latitud', 'Altura');
                          } else if(indexLongitud == indexAlturaElip){
                            alertaIndexCoor('Longitud', 'Altura');
                          } else {
                          List<List<dynamic>> puntosElip2Geocentricas = List<List<dynamic>>(widget.dataCSV.length);
                          List<String> puntos0 = List(4);
                          puntos0[0] = 'ID Punto';
                          puntos0[1] = 'X Geocentrica';
                          puntos0[2] = 'Y Geocentrica';
                          puntos0[3] = 'Z Geocentrica';
                          puntosElip2Geocentricas[0]=puntos0;
                          List<dynamic> datosCSVImport = List();
                          datosCSVImport = widget.dataCSV;
                          if(encabezado == true){
                            for (var i = 1; i < widget.dataCSV.length; i++) {
                            List<dynamic> puntos = List(4);
                            puntos = datosCSVImport[i+1];
                            CoordenadasGeocentricas coorGeo = CoordenadasGeocentricas();
                            CoordenadasElipsoidales coorElip = CoordenadasElipsoidales();
                            try {
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
                            } catch (e) {
                              i = widget.dataCSV.length;
                              alertaErrorArchivo();
                              validacion = false;
                            }
                          }
                          }else {
                            for (var i = 0; i < widget.dataCSV.length; i++) {
                            List<dynamic> puntos = List(4);
                            puntos = datosCSVImport[i];
                            CoordenadasGeocentricas coorGeo = CoordenadasGeocentricas();
                            CoordenadasElipsoidales coorElip = CoordenadasElipsoidales();
                            try {
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
                            } catch (e) {
                              i = widget.dataCSV.length;
                              alertaErrorArchivo();
                              validacion = false;
                            }
                          }
                          }
                          if(validacion == true) {
                          final Directory directorio = await getApplicationDocumentsDirectory();
                          final File csvGuardar = File('${directorio.path}/MeasureBookConversiónGeocentricas.csv');
                          String datosCSV = const ListToCsvConverter().convert(puntosElip2Geocentricas);
                          await csvGuardar.writeAsString(datosCSV);
                          Uint8List arCSv = csvGuardar.readAsBytesSync();
                          //final ByteData archivoCSV = await File('${directorio.path}/MeasureBookConversiónGeocentricas.csv').readAsBytes().then((data) => ByteData.view(data as ByteBuffer));
                          await Share.file('Conversion Archivos MeasureBookAPP', 'MeasureBookConversiónGeocentricas.csv', arCSv, 'file/csv', text: 'Conversión de Coordenadas MeasureBook');
                          }
                          }
                        }, 
                        child: Column(
                            children: [
                            SizedBox(height: 30),  
                            Container(
                            height: 30,
                            width: 320,
                            decoration: BoxDecoration(
                              color: Colors.blueAccent,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text('Exportar Coordenadas Convertidas a CSV', textAlign: TextAlign.center, style: TextStyle(color: Colors.white),)
                          ),
                        )]
                        ),
                    )
                )],
               ),
             ),
           ),
         )
         ),
    );
    }
    //Coordenadas Elipsoidales 2 Gauss Krüger
    else if(widget.destinoCS == 'Gauss - Krüger'){
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
                      child: Container(
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
                    ),
                    Container(
                      child: origenGauss
                      ?Container(
                        child: ListTile(
                          leading: Icon(Icons.add_location, color: Colors.blueAccent, size: 50,),
                          title: Text('Origen de Cordenadas Destino',style: TextStyle(
                          fontFamily: 'Roboto', 
                          fontSize: 13.0,
                          color: Color(0xff007FFF),
                          )),
                          subtitle: Text('${gaussCOrigen.NOMBRE}', style: 
                          TextStyle(
                            fontFamily: 'Roboto', 
                            fontSize: 16.0,
                            color: Colors.black54,
                          )),
                          onTap: (){
                            _sistemaGauss2(context);
                          },
                        )
                      )
                      :Container(
                        child: ListTile(
                          leading: Icon(Icons.add_location, color: Colors.blueAccent, size: 50,),
                          title: Text('Seleccionar Origen de Coordenadas del Punto',style: TextStyle(
                          fontFamily: 'Roboto', 
                          fontSize: 13.0,
                          color: Color(0xff007FFF),
                          )),
                          subtitle: Text('Selecciona el origen en el que se encuentra el punto ', style: 
                          TextStyle(
                            fontFamily: 'Roboto', 
                            fontSize: 12.0,
                            color: Colors.black54,
                          )),
                          trailing: Icon(Icons.chevron_right, size: 30.0, color: Colors.blueAccent,),
                          onTap: (){
                            _sistemaGauss2(context);
                          },
                        )
                      )
                    ),
                    Center(
                      child: FlatButton(
                        onPressed: ()async{
                          if (origenGauss == true){
                            if(indexIDElip == indexLatitud){
                            alertaIndexCoor('ID Punto', 'Latitud');
                          } else if(indexIDElip == indexLongitud){
                            alertaIndexCoor('ID Punto', 'Longitud');
                          } else if(indexIDElip == indexAlturaElip){
                            alertaIndexCoor('ID Punto', 'Altura');
                          } else if(indexLatitud == indexLongitud){
                            alertaIndexCoor('Latitud', 'Longitud');
                          } else if(indexLatitud == indexAlturaElip){
                            alertaIndexCoor('Latitud', 'Altura');
                          } else if(indexLongitud == indexAlturaElip){
                            alertaIndexCoor('Longitud', 'Altura');
                          } else {
                          List<List<dynamic>> puntosElip2Gauss = List<List<dynamic>>(widget.dataCSV.length+1);
                          List<String> puntos0 = List(4);
                          puntos0[0] = 'ID Punto';
                          puntos0[1] = 'Norte';
                          puntos0[2] = 'Este';
                          puntos0[3] = 'Altura';
                          puntosElip2Gauss[0]=puntos0;
                          List<dynamic> datosCSVImport = List();
                          datosCSVImport = widget.dataCSV;
                          if(encabezado == true){
                            for (var i = 1; i < widget.dataCSV.length; i++) {
                            List<dynamic> puntos = List(4);
                            puntos = datosCSVImport[i];
                            CoordenadasGauss coorGauss = CoordenadasGauss();
                            CoordenadasElipsoidales coorElip = CoordenadasElipsoidales();
                            try {
                            coorElip.latitud = puntos[indexLatitud];
                            coorElip.longitud = puntos[indexLongitud];
                            coorElip.altitud = puntos[indexAlturaElip];
                            ConversionCoordenadasMB conversionCoordenadasMB = ConversionCoordenadasMB();
                            coorGauss = conversionCoordenadasMB.elipsoidales2Gauss(coorElip, gaussCOrigen);
                            puntos[0] = puntos[indexIDElip];
                            puntos[1] = double.parse(coorGauss.norte.toString());
                            puntos[2] = double.parse(coorGauss.este.toString());
                            puntos[3] = double.parse(coorGauss.altura.toString());
                            puntosElip2Gauss[i] = puntos;
                            } catch (e) {
                              alertaErrorArchivo();
                              validacion = false;
                            }
                          }
                          }else {
                            for (var i = 0; i < widget.dataCSV.length; i++) {
                            List<dynamic> puntos = List(4);
                            puntos = datosCSVImport[i];
                            CoordenadasGauss coorGauss = CoordenadasGauss();
                            CoordenadasElipsoidales coorElip = CoordenadasElipsoidales();
                            try {
                            coorElip.latitud = puntos[indexLatitud];
                            coorElip.longitud = puntos[indexLongitud];
                            coorElip.altitud = puntos[indexAlturaElip];
                            ConversionCoordenadasMB conversionCoordenadasMB = ConversionCoordenadasMB();
                            coorGauss = conversionCoordenadasMB.elipsoidales2Gauss(coorElip, gaussCOrigen);
                            puntos[0] = puntos[indexIDElip];
                            puntos[1] = double.parse(coorGauss.norte.toString());
                            puntos[2] = double.parse(coorGauss.este.toString());
                            puntos[3] = double.parse(coorGauss.altura.toString());
                            puntosElip2Gauss[i+1] = puntos;
                            } catch (e) {
                              print(e);
                              alertaErrorArchivo();
                              validacion = false;
                            }
                          }
                          }
                          if(validacion == true) {
                          final Directory directorio = await getApplicationDocumentsDirectory();
                          final File csvGuardar = File('${directorio.path}/MeasureBookConversiónGauss.csv');
                          String datosCSV = const ListToCsvConverter().convert(puntosElip2Gauss);
                          await csvGuardar.writeAsString(datosCSV);
                          Uint8List arCSv = csvGuardar.readAsBytesSync();
                          await Share.file('Conversion Archivos MeasureBookAPP', 'MeasureBookConversiónGauss.csv', arCSv, 'file/csv', text: 'Conversión de Coordenadas MeasureBook');
                          }
                          }
                          }else {
                            alertanoGaussOrigen();
                          }
                        }, 
                        child: Column(
                            children: [
                            SizedBox(height: 30),  
                            Container(
                            height: 30,
                            width: 320,
                            decoration: BoxDecoration(
                              color: Colors.blueAccent,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text('Exportar Coordenadas Convertidas a CSV', textAlign: TextAlign.center, style: TextStyle(color: Colors.white),)
                          ),
                        )]
                        ),
                    )
                )],
               ),
             ),
           ),
         )
         ),
    );
    }else if(widget.destinoCS == 'Planas Cartesianas'){
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
                      child: Container(
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
                    ),
                    Container(
                      child: origenCartesiano
                      ?Container(
                        child: ListTile(
                        leading: Icon(Icons.add_location, color: Colors.blueAccent, size: 50,),
                        title: Text('Plano Cartesiano de Origen Seleccionado',style: TextStyle(
                        fontFamily: 'Roboto', 
                        fontSize: 13.0,
                        color: Color(0xff007FFF),
                        )),
                        subtitle: Text('${origenCartesian.NOMBRE}', style: 
                        TextStyle(
                          fontFamily: 'Roboto', 
                          fontSize: 12.0,
                          color: Colors.black54,
                        )),
                        trailing: Icon(Icons.chevron_right, size: 30.0, color: Colors.blueAccent,),
                        onTap: (){
                          _alertDialogoCartesianas2(context);
                        },
                      ),
                      )
                      : Container(
                        child: ListTile(
                        leading: Icon(Icons.add_location, color: Colors.blueAccent, size: 50,),
                        title: Text('Seleccionar Origen de Coordenadas del Punto',style: TextStyle(
                        fontFamily: 'Roboto', 
                        fontSize: 13.0,
                        color: Color(0xff007FFF),
                        )),
                        subtitle: Text('Selecciona el origen en el que se encuentra el punto ', style: 
                        TextStyle(
                          fontFamily: 'Roboto', 
                          fontSize: 12.0,
                          color: Colors.black54,
                        )),
                        trailing: Icon(Icons.chevron_right, size: 30.0, color: Colors.blueAccent,),
                        onTap: (){
                          _alertDialogoCartesianas2(context);
                        },
                      ),
                      )
                    ),
                    Center(
                      child: FlatButton(
                        onPressed: ()async{
                          if (origenCartesiano == true){
                            if(indexIDElip == indexLatitud){
                            alertaIndexCoor('ID Punto', 'Latitud');
                          } else if(indexIDElip == indexLongitud){
                            alertaIndexCoor('ID Punto', 'Longitud');
                          } else if(indexIDElip == indexAlturaElip){
                            alertaIndexCoor('ID Punto', 'Altura');
                          } else if(indexLatitud == indexLongitud){
                            alertaIndexCoor('Latitud', 'Longitud');
                          } else if(indexLatitud == indexAlturaElip){
                            alertaIndexCoor('Latitud', 'Altura');
                          } else if(indexLongitud == indexAlturaElip){
                            alertaIndexCoor('Longitud', 'Altura');
                          } else {
                          List<List<dynamic>> puntosElip2Cartesian = List<List<dynamic>>(widget.dataCSV.length+1);
                          List<String> puntos0 = List(4);
                          puntos0[0] = 'ID Punto';
                          puntos0[1] = 'Norte';
                          puntos0[2] = 'Este';
                          puntos0[3] = 'Altura';
                          puntosElip2Cartesian[0]=puntos0;
                          List<dynamic> datosCSVImport = List();
                          datosCSVImport = widget.dataCSV;
                          if(encabezado == true){
                            for (var i = 1; i < widget.dataCSV.length; i++) {
                            List<dynamic> puntos = List(4);
                            puntos = datosCSVImport[i];
                            CoordenadasCartesianas coordenadasCartesia = CoordenadasCartesianas();
                            CoordenadasElipsoidales coorElip = CoordenadasElipsoidales();
                            try {
                            coorElip.latitud = puntos[indexLatitud];
                            coorElip.longitud = puntos[indexLongitud];
                            coorElip.altitud = puntos[indexAlturaElip];
                            ConversionCoordenadasMB conversionCoordenadasMB = ConversionCoordenadasMB();
                            coordenadasCartesia = conversionCoordenadasMB.elipsoidales2Cartesianas(origenCartesian, coorElip);
                            puntos[0] = puntos[indexIDElip];
                            puntos[1] = double.parse(coordenadasCartesia.norte.toString());
                            puntos[2] = double.parse(coordenadasCartesia.este.toString());
                            puntos[3] = double.parse(coordenadasCartesia.altura.toString());
                            puntosElip2Cartesian[i] = puntos;
                            } catch (e) {
                              i = widget.dataCSV.length;
                              alertaErrorArchivo();
                              origenCartesiano = false;
                            }
                          }
                          }else {
                            for (var i = 0; i < widget.dataCSV.length; i++) {
                            List<dynamic> puntos = List(4);
                            List<dynamic> puntosOut = List(4);
                            puntos = datosCSVImport[i];
                            CoordenadasCartesianas coordenadasCartesia = CoordenadasCartesianas();
                            CoordenadasElipsoidales coorElip = CoordenadasElipsoidales();
                            try {
                            coorElip.latitud = puntos[indexLatitud];
                            coorElip.longitud = puntos[indexLongitud];
                            coorElip.altitud = puntos[indexAlturaElip];
                            ConversionCoordenadasMB conversionCoordenadasMB = ConversionCoordenadasMB();
                            coordenadasCartesia = conversionCoordenadasMB.elipsoidales2Cartesianas(origenCartesian, coorElip);
                            puntosOut[0] = puntos[indexIDElip];
                            puntosOut[1] = coordenadasCartesia.norte;
                            puntosOut[2] = coordenadasCartesia.este;
                            puntosOut[3] = coordenadasCartesia.altura;
                            puntosElip2Cartesian[i+1] = puntosOut;
                            } catch (e) {
                              i = widget.dataCSV.length;
                              alertaErrorArchivo();
                              origenCartesiano = false;
                            }
                          }
                          }
                          if(origenCartesiano == true) {
                            
                          final Directory directorio = await getApplicationDocumentsDirectory();
                          final File csvGuardar = File('${directorio.path}/MeasureBookConversiónCartesianas.csv');
                          String datosCSV = const ListToCsvConverter().convert(puntosElip2Cartesian);
                          await csvGuardar.writeAsString(datosCSV);
                          Uint8List arCSv = csvGuardar.readAsBytesSync();
                          await Share.file('Conversion Archivos MeasureBookAPP', 'MeasureBookConversiónCartesiana.csv', arCSv, 'file/csv', text: 'Conversión de Coordenadas MeasureBook');
                          }
                          }
                          }else {
                            alertanoGaussCartesian();
                          }
                        }, 
                        child: Column(
                            children: [
                            SizedBox(height: 30),  
                            Container(
                            height: 30,
                            width: 320,
                            decoration: BoxDecoration(
                              color: Colors.blueAccent,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text('Exportar Coordenadas Convertidas a CSV', textAlign: TextAlign.center, style: TextStyle(color: Colors.white),)
                          ),
                        )]
                        ),
                    )
                )],
               ),
             ),
           ),
         )
         ),
    );
    }
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

    void alertaErrorArchivo(){
    Fluttertoast.showToast(
    msg: "El formato del archivo no es compatible, por favor valide que el CSV este delimitado por comas y use punto como simbolo decimal ",
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 2
    );
  }
  void alertaIndexCoor( String indiceI, indiceII){
    Fluttertoast.showToast(
    msg: "El indice ${indiceI} es igual al indice ${indiceII}, por favor verifique el indice seleccionado para cada uno de los campos",
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 2
    );
  }
  void alertanoGaussOrigen(){
    Fluttertoast.showToast(
    msg: "No se ha seleccionado el origen del sisitema Gauss",
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 2
    );
  }
  void alertanoGaussCartesian(){
    Fluttertoast.showToast(
    msg: "No se ha seleccionado el origen del Plano Cartesiano",
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 2
    );
  }
  _sistemaGauss2 (BuildContext context){
    showDialog(
      context: context,
      builder: (context) => Container(
        child: Container(
          decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0)
          )
          ),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Container(
            child:FutureBuilder<List<origenesGauss>>(
            future: gestorMBDatabase.db.getGauss(),
            builder: (context, AsyncSnapshot<List<origenesGauss>> snapshot) {
              if(snapshot.hasData){
                return Swiper(
                  loop: false,
                  pagination: SwiperPagination(
                    builder: SwiperPagination.dots
                  ),
                  layout: SwiperLayout.TINDER,
                  itemWidth: 320,
                  itemHeight: 580,
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, int index){
                    origenesGauss listaOrigenes = snapshot.data[index];
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      key: UniqueKey(),
                      child: Card(
                        elevation: 14.0,
                        child: Container(
                          decoration: BoxDecoration(
                          image: DecorationImage(image: AssetImage('assets/images/fondo_sistemas.png'),
                          fit: BoxFit.cover,
                           ),   
                           ),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: RichText(text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(text: 'Gauss-Krüger', style: TextStyle(
                                      fontFamily: 'Roboto',
                                      color: Colors.white,
                                      fontSize: 14.0
                                      )),
                                  ]
                                )),
                                ),
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Text(
                                    '${listaOrigenes.NOMBRE}', style: TextStyle(
                                      fontFamily: 'Roboto',
                                      color: Colors.white,
                                      fontSize: 14.0
                                    ),
                                  ),
                                ),
                                SizedBox(height: 45.0),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: RichText(text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(text: 'DATUM: \n ', style: TextStyle(
                                      fontFamily: 'Roboto',
                                      color: Colors.black54,
                                      fontSize: 12.0
                                    )),
                                    TextSpan( text: 'Magna Sirgas', style: TextStyle(
                                      fontFamily: 'Roboto',
                                      color: Color(0xff007FFF),
                                      fontSize: 13.0
                                    ))
                                  ]
                                )),
                                ),
                                Divider(),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: RichText(text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(text: 'Elipsoide: \n', style: TextStyle(
                                      fontFamily: 'Roboto',
                                      color: Colors.black54,
                                      fontSize: 12.0
                                    )),
                                    TextSpan( text: 'GRS80', style: TextStyle(
                                      fontFamily: 'Roboto',
                                      color: Color(0xff007FFF),
                                      fontSize: 13.0
                                    ))
                                  ]
                                )),
                                ),
                                Divider(),
                                Align(
                                  alignment: Alignment.center,
                                  child: RichText(text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(text: 'Sistema de Proyección', style: TextStyle(
                                      fontFamily: 'Roboto',
                                      color: Color(0xff007FFF),
                                      fontSize: 14.0
                                    )),
                                  ]
                                )),
                                ),
                                Divider(),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: RichText(text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(text: 'Proyección \n', style: TextStyle(
                                      fontFamily: 'Roboto',
                                      color: Colors.black54,
                                      fontSize: 12.0
                                    )),
                                    TextSpan( text: 'Transversal de Mercator', style: TextStyle(
                                      fontFamily: 'Roboto',
                                      color: Color(0xff007FFF),
                                      fontSize: 13.0
                                    ))
                                  ]
                                )),
                                ),
                                Divider(),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: RichText(text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(text: 'Latitud de Origen \n', style: TextStyle(
                                      fontFamily: 'Roboto',
                                      color: Colors.black54,
                                      fontSize: 12.0
                                    )),
                                    TextSpan( text: '${listaOrigenes.LATITUD.toString()}', style: TextStyle(
                                      fontFamily: 'Roboto',
                                      color: Color(0xff007FFF),
                                      fontSize: 13.0
                                    ))
                                  ]
                                )),
                                ), 
                                Divider(),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: RichText(text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(text: 'Longitud de Origen \n', style: TextStyle(
                                      fontFamily: 'Roboto',
                                      color: Colors.black54,
                                      fontSize: 12.0
                                    )),
                                    TextSpan( text: '${listaOrigenes.LONGITUD.toString()}', style: TextStyle(
                                      fontFamily: 'Roboto',
                                      color: Color(0xff007FFF),
                                      fontSize: 13.0
                                    ))
                                  ]
                                )),
                                ),
                                Divider(),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: RichText(text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(text: 'Falso Norte \n', style: TextStyle(
                                      fontFamily: 'Roboto',
                                      color: Colors.black54,
                                      fontSize: 12.0
                                    )),
                                    TextSpan( text: '${listaOrigenes.NORTE.toString()}00 m', style: TextStyle(
                                      fontFamily: 'Roboto',
                                      color: Color(0xff007FFF),
                                      fontSize: 13.0
                                    ))
                                  ]
                                )),
                                ),
                                Divider(),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: RichText(text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(text: 'Falso Este \n', style: TextStyle(
                                      fontFamily: 'Roboto',
                                      color: Colors.black54,
                                      fontSize: 12.0
                                    )),
                                    TextSpan( text: '${listaOrigenes.ESTE.toString()} m', style: TextStyle(
                                      fontFamily: 'Roboto',
                                      color: Color(0xff007FFF),
                                      fontSize: 13.0
                                    ))
                                  ]
                                )),
                                ),
                                Divider(),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: RichText(text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(text: 'Factor de Escala\n ', style: TextStyle(
                                      fontFamily: 'Roboto',
                                      color: Colors.black54,
                                      fontSize: 12.0
                                    )),
                                    TextSpan( text: '1.000000000', style: TextStyle(
                                      fontFamily: 'Roboto',
                                      color: Color(0xff007FFF),
                                      fontSize: 13.0
                                    ))
                                  ]
                                )),
                                ),
                                Divider(), 
                                Align(
                                  alignment: Alignment.center,
                                  child: Center(
                                    child: Column(
                                      children: <Widget>[
                                        FlatButton(
                                          onPressed: (){
                                              GaussCS gaussC = GaussCS();
                                              gaussC.NORTE = listaOrigenes.NORTE;
                                              gaussC.ESTE = listaOrigenes.ESTE;
                                              gaussC.LATITUD = listaOrigenes.LATITUD;
                                              gaussC.LONGITUD = listaOrigenes.LONGITUD;
                                              gaussC.NOMBRE = listaOrigenes.NOMBRE;
                                              Navigator.pop(context);
                                             setState(() {
                                               gaussCOrigen = gaussC;
                                               origenGauss = true;
                                             });
                                              }, 
                                              child: Column(
                                                children: <Widget>[
                                                Image.asset('assets/images/seleccionar.png', height: 40,),
                                                Text('Seleccionar',style: TextStyle(color: Colors.blueAccent, fontSize: 14))
                                                ],
                                              )
                                              ),
                                              ],
                                              ),
                                              ),
                                              )
                                              ],
                                              ),
                                            ),
                                            ),
                                            ));
                                          }
                                          );
                                        }else {
                                        return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                    },
                                    ),
                          )
              )
                                            
      )
      );
      }

void _alertDialogoCartesianas2(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => Container(
      height: 500,
      
      child: Scaffold(
        body: FutureBuilder<List<departamentos>>(
          future: gestorMBDatabase.db.getDepartamentos(),
          builder: (BuildContext context, AsyncSnapshot<List<departamentos>> listaDep){
            if(listaDep.hasData) {
                return Container(
                  height: 700,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 30),
                      Text('Seleccione un Departamento', style: TextStyle(
                        color: Color(0xff007FFF),
                        fontSize: 16.0
                      ),),
                      SizedBox(
                        height: 14.0,
                      ),
                      Flexible(
                      child: ListView.builder(
                      itemCount: listaDep.data.length,
                      itemBuilder: (BuildContext context, int index){
                      departamentos listaDepartamentos = listaDep.data[index];
                      return Dismissible(
                      onDismissed: (direction){},
                      key: UniqueKey(), 
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        child: ListTile(
                          title: Text(listaDepartamentos.NOMBRE, style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16.0
                          ),),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Icon(Icons.chevron_right, color: Colors.blueAccent)
                          ],
                        ),
                        onTap: (){
                          Navigator.pop(context);
                          _alertDialogoCartesianasMunicipio2(context, listaDepartamentos.PK_DEPARTAMENTO);
                          
                        },
                        )
                      )
                      );
                      }   
                      ),
                      )
                    ],
                  )
                );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
              );
            }
          }
          ),
      ),
    )
  );
}

  void _alertDialogoCartesianasMunicipio2(BuildContext context, int fk_Departamento) {
  showDialog(
    context: context,
    builder: (context) => Container(
      height: 500,
      
      child: Scaffold(
        body: FutureBuilder<List<municipios>>(
          future: gestorMBDatabase.db.getMunicipios(fk_Departamento),
          builder: (BuildContext context, AsyncSnapshot<List<municipios>> listaMunicipios){
            if(listaMunicipios.hasData) {
                return Container(
                  height: 700,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 30),
                      Text('Seleccione un Municipio', style: TextStyle(
                        color: Color(0xff007FFF),
                        fontSize: 16.0
                      ),),
                      SizedBox(
                        height: 14.0,
                      ),
                      Flexible(
                      child: ListView.builder(
                      itemCount: listaMunicipios.data.length,
                      itemBuilder: (BuildContext context, int index){
                      municipios listaMun = listaMunicipios.data[index];
                      return Dismissible(
                      key: UniqueKey(), 
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        child: ListTile(
                          title: Text(listaMun.NOMBRE, style: TextStyle(
                            color: Colors.black54,
                            fontSize: 14.0
                          ),),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Icon(Icons.chevron_right, color: Colors.blueAccent)
                          ],
                        ),
                        onTap: (){
                            Navigator.pop(context);
                           _sistemas2Cartesianos2(context, listaMun.PK_MUNICIPIOS);
                        },
                        )
                      )
                      );
                      }   
                      ),
                      )
                    ],
                  )
                );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
              );
            }
          }
          ),
      ),
    )
  );
}

void _sistemas2Cartesianos2 (BuildContext context, int fk_Muninipio) {
  showDialog(
  context: context,
    builder: (context) => Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30)
      ),
      child:FutureBuilder<List<origenesCartesianos>>(
        future: gestorMBDatabase.db.getCartesianas(fk_Muninipio),
        builder: (BuildContext context, AsyncSnapshot<List<origenesCartesianos>> snapshot) {
          if(snapshot.hasData){             
            if (snapshot.data.length>1) {
              return Swiper(
              layout: SwiperLayout.TINDER,
              pagination: SwiperPagination(
                builder: SwiperPagination.dots
              ),
              loop: false,
              itemWidth: MediaQuery.of(context).size.width*0.8,
              itemHeight: MediaQuery.of(context).size.height*.70,
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index){
                origenesCartesianos listaOrigenes = snapshot.data[index];
                return Container(
                  height: 550,
                  width: 270,
                  decoration: BoxDecoration(
                  ),
                  key: UniqueKey(),
                  child: Card(
                    elevation: 14.0,
                    child: Container(
                      height: 500,
                      decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage('assets/images/fondo_sistemas.png'),
                      fit: BoxFit.cover,
                        ),   
                        ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: 5),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: RichText(text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(text: 'Plano Cartesiano', style: TextStyle(
                                  fontFamily: 'Roboto',
                                  color: Colors.white,
                                  fontSize: 14.0
                                  )),
                              ]
                            )),
                            ),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                '${listaOrigenes.NOMBRE}', style: TextStyle(
                                  fontFamily: 'Roboto',
                                  color: Colors.white,
                                  fontSize: 14.0
                                ),
                              ),
                            ),
                            SizedBox(height: 40.0),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: RichText(text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(text: 'DATUM \n', style: TextStyle(
                                  fontFamily: 'Roboto',
                                  color: Colors.black54,
                                  fontSize: 12.0
                                )),
                                TextSpan( text: 'Magna Sirgas', style: TextStyle(
                                  fontFamily: 'Roboto',
                                  color: Color(0xff007FFF),
                                  fontSize: 13.0
                                ))
                              ]
                            )),
                            ),
                            Divider(),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: RichText(text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(text: 'Elipsoide\n', style: TextStyle(
                                  fontFamily: 'Roboto',
                                  color: Colors.black54,
                                  fontSize: 12.0
                                )),
                                TextSpan( text: 'GRS80', style: TextStyle(
                                  fontFamily: 'Roboto',
                                  color: Color(0xff007FFF),
                                  fontSize: 13.0
                                ))
                              ]
                            )),
                            ),
                            SizedBox(height: 5.0,),
                            Align(
                              alignment: Alignment.center,
                              child: RichText(text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(text: 'Sistema de Proyección ', style: TextStyle(
                                  fontFamily: 'Roboto',
                                  color: Color(0xff007FFF),
                                  fontSize: 14.0
                                )),
                              ]
                            )),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: RichText(text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(text: 'Proyección\n', style: TextStyle(
                                  fontFamily: 'Roboto',
                                  color: Colors.black54,
                                  fontSize: 12.0
                                )),
                                TextSpan( text: 'Plano Cartesiano IGAC', style: TextStyle(
                                  fontFamily: 'Roboto',
                                  color: Color(0xff007FFF),
                                  fontSize: 13.0
                                ))
                              ]
                            )),
                            ),
                            Divider(),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: RichText(text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(text: 'Latitud de Origen\n', style: TextStyle(
                                  fontFamily: 'Roboto',
                                  color: Colors.black54,
                                  fontSize: 12.0
                                )),
                                TextSpan( text: '${listaOrigenes.LATITUD.toString()}', style: TextStyle(
                                  fontFamily: 'Roboto',
                                  color: Color(0xff007FFF),
                                  fontSize: 13.0
                                ))
                              ]
                            )),
                            ), 
                            Divider(),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: RichText(text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(text: 'Longitud de Origen\n', style: TextStyle(
                                  fontFamily: 'Roboto',
                                  color: Colors.black54,
                                  fontSize: 13.0
                                )),
                                TextSpan( text: '${listaOrigenes.LONGITUD.toString()}', style: TextStyle(
                                  fontFamily: 'Roboto',
                                  color: Color(0xff007FFF),
                                  fontSize: 13.0
                                ))
                              ]
                            )),
                            ),
                            Divider(),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: RichText(text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(text: 'Falso Norte\n', style: TextStyle(
                                  fontFamily: 'Roboto',
                                  color: Colors.black54,
                                  fontSize: 12.0
                                )),
                                TextSpan( text: '${listaOrigenes.NORTE.toString()} m', style: TextStyle(
                                  fontFamily: 'Roboto',
                                  color: Color(0xff007FFF),
                                  fontSize: 13.0
                                ))
                              ]
                            )),
                            ),
                            Divider(),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: RichText(text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(text: 'Falso Este\n ', style: TextStyle(
                                  fontFamily: 'Roboto',
                                  color: Colors.black54,
                                  fontSize: 12.0
                                )),
                                TextSpan( text: '${listaOrigenes.ESTE.toString()} m', style: TextStyle(
                                  fontFamily: 'Roboto',
                                  color: Color(0xff007FFF),
                                  fontSize: 13.0
                                ))
                              ]
                            )),
                            ),
                            Divider(),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: RichText(text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(text: 'Altura del Plano\n ', style: TextStyle(
                                  fontFamily: 'Roboto',
                                  color: Colors.black54,
                                  fontSize: 12.0
                                )),
                                TextSpan( text: '${listaOrigenes.PLANO_PROY} m', style: TextStyle(
                                  fontFamily: 'Roboto',
                                  color: Color(0xff007FFF),
                                  fontSize: 13.0
                                ))
                              ]
                            )),
                            ),  
                            Divider(),
                            Align(
                              alignment: Alignment.center,
                              child: Center(
                                child: Column(
                                  children: <Widget>[
                                    FlatButton(
                                      onPressed: (){
                                        CartesianasCS cartesianasCS = CartesianasCS();
                                            cartesianasCS.NOMBRE = listaOrigenes.NOMBRE;
                                            cartesianasCS.ESTE = listaOrigenes.ESTE;
                                            cartesianasCS.NORTE = listaOrigenes.NORTE;
                                            cartesianasCS.PLANO_PROY = listaOrigenes.PLANO_PROY;
                                            cartesianasCS.LATITUD = listaOrigenes.LATITUD;
                                            cartesianasCS.LONGITUD = listaOrigenes.LONGITUD;
                                            Navigator.pop(context);
                                            setState(() {
                                              origenCartesian = cartesianasCS;
                                              origenCartesiano = true;
                                            });
                                      }, 
                                      child: Column(
                                        children: <Widget>[
                                        Image.asset('assets/images/seleccionar.png', height: 40,),
                                        Text('Seleccionar',style: TextStyle(color: Colors.blueAccent, fontSize: 14))
                                        ],
                                      )
                                      ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ));
              }
              );
            } else {
              return Swiper(
                layout: SwiperLayout.DEFAULT,
                pagination: SwiperPagination(
                builder: SwiperPagination.dots
              ),
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index){
                origenesCartesianos listaOrigenes = snapshot.data[index];
                return Container(
                  child: Container(
                    key: UniqueKey(),
                    child: Center(
                      child: Card(
                        elevation: 14.0,
                        child: Container(
                          height: 580,
                          width: 320,
                          decoration: BoxDecoration(
                          image: DecorationImage(image: AssetImage('assets/images/fondo_sistemas.png'),
                          fit: BoxFit.cover,
                            ),   
                            ),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: RichText(text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(text: 'Plano Cartesiano', style: TextStyle(
                                      fontFamily: 'Roboto',
                                      color: Colors.white,
                                      fontSize: 14.0
                                      )),
                                  ]
                                )),
                                ),
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Text(
                                    '${listaOrigenes.NOMBRE}', style: TextStyle(
                                      fontFamily: 'Roboto',
                                      color: Colors.white,
                                      fontSize: 14.0
                                    ),
                                  ),
                                ),
                                SizedBox(height: 45.0),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: RichText(text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(text: 'DATUM \n', style: TextStyle(
                                      fontFamily: 'Roboto',
                                      color: Colors.black54,
                                      fontSize: 12.0
                                    )),
                                    TextSpan( text: 'Magna Sirgas        ', style: TextStyle(
                                      fontFamily: 'Roboto',
                                      color: Color(0xff007FFF),
                                      fontSize: 13.0
                                    ))
                                  ]
                                )),
                                ),
                                Divider(),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: RichText(text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(text: 'Elipsoide\n', style: TextStyle(
                                      fontFamily: 'Roboto',
                                      color: Colors.black54,
                                      fontSize: 12.0
                                    )),
                                    TextSpan( text: 'GRS80        ', style: TextStyle(
                                      fontFamily: 'Roboto',
                                      color: Color(0xff007FFF),
                                      fontSize: 13.0
                                    ))
                                  ]
                                )),
                                ),
                                Divider(),
                                Align(
                                  alignment: Alignment.center,
                                  child: RichText(text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(text: '      Sistema de Proyección ', style: TextStyle(
                                      fontFamily: 'Roboto',
                                      color: Color(0xff007FFF),
                                      fontSize: 13.0
                                    )),
                                  ]
                                )),
                                ),
                                Divider(),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: RichText(text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(text: 'Proyección\n', style: TextStyle(
                                      fontFamily: 'Roboto',
                                      color: Colors.black54,
                                      fontSize: 12.0
                                    )),
                                    TextSpan( text: 'Plano Cartesiano IGAC', style: TextStyle(
                                      fontFamily: 'Roboto',
                                      color: Color(0xff007FFF),
                                      fontSize: 13.0
                                    ))
                                  ]
                                )),
                                ),
                                Divider(),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: RichText(text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(text: 'Latitud de Origen\n', style: TextStyle(
                                      fontFamily: 'Roboto',
                                      color: Colors.black54,
                                      fontSize: 12.0
                                    )),
                                    TextSpan( text: '${listaOrigenes.LATITUD.toString()}', style: TextStyle(
                                      fontFamily: 'Roboto',
                                      color: Color(0xff007FFF),
                                      fontSize: 13.0
                                    ))
                                  ]
                                )),
                                ), 
                                Divider(),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: RichText(text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(text: 'Longitud de Origen\n', style: TextStyle(
                                      fontFamily: 'Roboto',
                                      color: Colors.black54,
                                      fontSize: 12.0
                                    )),
                                    TextSpan( text: '${listaOrigenes.LONGITUD.toString()}', style: TextStyle(
                                      fontFamily: 'Roboto',
                                      color: Color(0xff007FFF),
                                      fontSize: 13.0
                                    ))
                                  ]
                                )),
                                ),
                                Divider(),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: RichText(text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(text: 'Falso Norte\n', style: TextStyle(
                                      fontFamily: 'Roboto',
                                      color: Colors.black54,
                                      fontSize: 12.0
                                    )),
                                    TextSpan( text: '${listaOrigenes.NORTE.toString()} m', style: TextStyle(
                                      fontFamily: 'Roboto',
                                      color: Color(0xff007FFF),
                                      fontSize: 13.0
                                    ))
                                  ]
                                )),
                                ),
                                Divider(),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: RichText(text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(text: 'Falso Este\n', style: TextStyle(
                                      fontFamily: 'Roboto',
                                      color: Colors.black54,
                                      fontSize: 12.0
                                    )),
                                    TextSpan( text: '${listaOrigenes.ESTE.toString()} m', style: TextStyle(
                                      fontFamily: 'Roboto',
                                      color: Color(0xff007FFF),
                                      fontSize: 13.0
                                    ))
                                  ]
                                )),
                                ),
                                Divider(),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: RichText(text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(text: 'Altura del Plano\n', style: TextStyle(
                                      fontFamily: 'Roboto',
                                      color: Colors.black54,
                                      fontSize: 12.0
                                    )),
                                    TextSpan( text: '${listaOrigenes.PLANO_PROY} m', style: TextStyle(
                                      fontFamily: 'Roboto',
                                      color: Color(0xff007FFF),
                                      fontSize: 13.0
                                    ))
                                  ]
                                )),
                                ),  
                                Divider(),
                                Align(
                                  alignment: Alignment.center,
                                  child: Center(
                                    child: Column(
                                      children: <Widget>[
                                        FlatButton(
                                          onPressed: (){
                                            CartesianasCS cartesianasCS = CartesianasCS();
                                            cartesianasCS.NOMBRE = listaOrigenes.NOMBRE;
                                            cartesianasCS.ESTE = listaOrigenes.ESTE;
                                            cartesianasCS.NORTE = listaOrigenes.NORTE;
                                            cartesianasCS.PLANO_PROY = listaOrigenes.PLANO_PROY;
                                            cartesianasCS.LATITUD = listaOrigenes.LATITUD;
                                            cartesianasCS.LONGITUD = listaOrigenes.LONGITUD;
                                            Navigator.pop(context);
                                            setState(() {
                                              origenCartesian = cartesianasCS;
                                              origenCartesiano = true;
                                            });
                                          },child: Column(
                                          children: <Widget>[
                                          Image.asset('assets/images/seleccionar.png', height: 40,),
                                          Text('Seleccionar',style: TextStyle(color: Colors.blueAccent, fontSize: 14))
                                          ],
                                        )
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    )),
                );
              }
              );
            
            }

          }else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      )
  );
}

}