import 'dart:typed_data';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
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
import 'package:measurebookapp/modelos/proyectos.dart';
import 'package:measurebookapp/modelos/puntosReferencia.dart';
import 'package:measurebookapp/pages/conversionCoordenadas/configuracionArchivoImportado.dart';
import 'package:measurebookapp/pages/conversionCoordenadas/conversionPuntoIndividual.dart';
import 'package:measurebookapp/pages/descripcionSC.dart';
import 'package:csv/csv.dart';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class CoversionCoordenadas extends StatefulWidget {
  final proyectos datosProyecto;
  const CoversionCoordenadas({Key key, this.datosProyecto}) : super(key: key);

  @override
  _CoversionCoordenadasState createState() => _CoversionCoordenadasState();
}

class _CoversionCoordenadasState extends State<CoversionCoordenadas> {
  bool check = true;
  bool csvload = false;
  List<DescripcionSistemCoor> listSistemasOrigenPI =
      List<DescripcionSistemCoor>(5);
  List<DescripcionSistemCoor> listSistemasDestinoPI =
      List<DescripcionSistemCoor>(5);
  List<DescripcionSistemCoor> listSistemasOrigenArc =
      List<DescripcionSistemCoor>(5);
  List<DescripcionSistemCoor> listSistemasDestinoArc =
      List<DescripcionSistemCoor>(5);
  List<DescripcionSistemCoor> listSistemasDestinoPR =
      List<DescripcionSistemCoor>(5);
  String tipoConversion;
  String sistemaOrigenPI = 'Elipsoidales';
  String sistemadestinoPI = 'Elipsoidales';
  String sistemaOrigenArc = 'Elipsoidales';
  String sistemadestinoArc = 'Elipsoidales';
  String sistemadestinoRef = 'Elipsoidales';
  GaussCS gaussCOrigen = GaussCS();
  CartesianasCS origenCartesian = CartesianasCS();
  bool cartesianCS = false;
  bool origenGauss = false;
  bool origenCartesiano = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Center(
              child: Column(
                children: <Widget>[
                  Image.asset('assets/images/conversion.png', height: 80.0),
                  SizedBox(height: 10),
                  RichText(
                      text: TextSpan(children: <TextSpan>[
                    TextSpan(
                        text: 'Conversion de coordenadas ',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 13.0,
                          color: Color(0xff007FFF),
                        )),
                    TextSpan(
                        text:
                            'Convierte tus coordenadas entre los sistemas de coordenadas Elipsoidales, Geocéntricas, Gauss Krüger o Planas Cartesianas',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 13.0,
                          color: Colors.black54,
                        )),
                  ])),
                  SizedBox(height: 25),
                  //Convertir Punto Individual
                  Container(
                    height: 440,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 2,
                              offset: Offset(0, 3),
                              color: Colors.black54)
                        ]),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 20),
                        Text('Conversión Punto Individual',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.blueAccent, fontSize: 14)),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            'Convierte las coordenadas de un punto entre los sistemas de Coordenadas Planas Cartesianas, Gauss Krüger, Geocéntricas y Elipsoidales que se encuentren en el Datum MAGNA SIRGAS',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              height: 280,
                              width: MediaQuery.of(context).size.width / 2 - 20,
                              child: Swiper(
                                onIndexChanged: (int index) {
                                  sistemaOrigenPI = listSistemasOrigenPI[index]
                                      .nombreProyeccion;
                                },
                                control: SwiperControl(size: 15),
                                pagination: SwiperPagination(
                                    builder: SwiperPagination.dots),
                                itemCount: 5,
                                loop: false,
                                layout: SwiperLayout.DEFAULT,
                                itemHeight: 200,
                                itemWidth:
                                    MediaQuery.of(context).size.width / 2,
                                itemBuilder: (BuildContext context, int index) {
                                  DescripcionSistemCoor elipsoidal =
                                      DescripcionSistemCoor(
                                          nombreProyeccion: 'Elipsoidales',
                                          imagen:
                                              'assets/images/elipsoidal.png');
                                  DescripcionSistemCoor geocentrico =
                                      DescripcionSistemCoor(
                                    nombreProyeccion: 'Geocentricas',
                                    imagen: 'assets/images/geocentrica.png',
                                  );
                                  DescripcionSistemCoor planas_Gauss =
                                      DescripcionSistemCoor(
                                    nombreProyeccion: 'Gauss - Krüger',
                                    imagen: 'assets/images/gauss.png',
                                  );
                                  DescripcionSistemCoor planas_Cartesianas =
                                      DescripcionSistemCoor(
                                          nombreProyeccion:
                                              'Planas Cartesianas',
                                          imagen:
                                              'assets/images/cartesiana.png');
                                  DescripcionSistemCoor tm =
                                      DescripcionSistemCoor(
                                          nombreProyeccion:
                                              'Magna Origen Nacional',
                                          imagen: 'assets/images/nacional.png');
                                  listSistemasOrigenPI[0] = elipsoidal;
                                  listSistemasOrigenPI[1] = geocentrico;
                                  listSistemasOrigenPI[2] = planas_Gauss;
                                  listSistemasOrigenPI[3] = planas_Cartesianas;
                                  listSistemasOrigenPI[4] = tm;
                                  DescripcionSistemCoor a =
                                      listSistemasOrigenPI[index];

                                  return Container(
                                    width: 150,
                                    height: 210,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Column(
                                      children: <Widget>[
                                        Center(
                                          child: Text(
                                            'Sistema Partida',
                                            style: TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.black54,
                                            ),
                                          ),
                                        ),
                                        Divider(),
                                        Center(
                                          child: Text(
                                            a.nombreProyeccion,
                                            style: TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.blueAccent,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 60.0),
                                        Image.asset(a.imagen, height: 160)
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                            Container(
                              height: 280,
                              width: MediaQuery.of(context).size.width / 2 - 20,
                              child: Swiper(
                                onIndexChanged: (int index) {
                                  sistemadestinoPI =
                                      listSistemasDestinoPI[index]
                                          .nombreProyeccion;
                                },
                                control: SwiperControl(size: 15),
                                loop: false,
                                itemCount: 5,
                                pagination: SwiperPagination(
                                    builder: SwiperPagination.dots),
                                layout: SwiperLayout.DEFAULT,
                                itemHeight: 200,
                                itemWidth:
                                    MediaQuery.of(context).size.width / 2,
                                itemBuilder: (BuildContext context, int index) {
                                  DescripcionSistemCoor elipsoidal =
                                      DescripcionSistemCoor(
                                          nombreProyeccion: 'Elipsoidales',
                                          imagen:
                                              'assets/images/elipsoidal.png');
                                  DescripcionSistemCoor geocentrico =
                                      DescripcionSistemCoor(
                                    nombreProyeccion: 'Geocentricas',
                                    imagen: 'assets/images/geocentrica.png',
                                  );
                                  DescripcionSistemCoor planas_Gauss =
                                      DescripcionSistemCoor(
                                    nombreProyeccion: 'Gauss - Krüger',
                                    imagen: 'assets/images/gauss.png',
                                  );
                                  DescripcionSistemCoor planas_Cartesianas =
                                      DescripcionSistemCoor(
                                          nombreProyeccion:
                                              'Planas Cartesianas',
                                          imagen:
                                              'assets/images/cartesiana.png');
                                  DescripcionSistemCoor tm =
                                      DescripcionSistemCoor(
                                          nombreProyeccion:
                                              'Magna Origen Nacional',
                                          imagen: 'assets/images/nacional.png');
                                  listSistemasDestinoPI[0] = elipsoidal;
                                  listSistemasDestinoPI[1] = geocentrico;
                                  listSistemasDestinoPI[2] = planas_Gauss;
                                  listSistemasDestinoPI[3] = planas_Cartesianas;
                                  listSistemasDestinoPI[4] = tm;
                                  DescripcionSistemCoor a =
                                      listSistemasDestinoPI[index];

                                  return Container(
                                    width: 150,
                                    height: 200,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Column(
                                      children: <Widget>[
                                        Center(
                                          child: Text(
                                            'Sistema Destino',
                                            style: TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.black54,
                                            ),
                                          ),
                                        ),
                                        Divider(),
                                        Center(
                                          child: Text(
                                            a.nombreProyeccion,
                                            style: TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.blueAccent,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 60.0),
                                        Image.asset(a.imagen, height: 160),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                        FlatButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (context) =>
                                          new ConversionPuntoIndividual(
                                            destino: sistemadestinoPI,
                                            origen: sistemaOrigenPI,
                                          )));
                            },
                            child: Column(
                              children: <Widget>[
                                Image.asset(
                                  'assets/images/seleccionar.png',
                                  height: 40,
                                ),
                                Text('Seleccionar',
                                    style: TextStyle(
                                        color: Colors.blueAccent, fontSize: 14))
                              ],
                            ))
                      ],
                    ),
                  ),
                  SizedBox(height: 25),
                  //Convertir CSV
                  Container(
                    height: 450,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 2,
                              offset: Offset(0, 3),
                              color: Colors.black54)
                        ]),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 20),
                        Text('Conversión Archivo',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.blueAccent, fontSize: 14)),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            'Convierte las coordenadas desde un archivo CSV a los sistemas de Coordenadas Planas Cartesianas, Gauss Krüger, Geocéntricas y Elipsoidales que se encuentren en el Datum MAGNA SIRGAS',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              height: 280,
                              width: MediaQuery.of(context).size.width / 2 - 20,
                              child: Swiper(
                                onIndexChanged: (int index) {
                                  sistemaOrigenArc =
                                      listSistemasOrigenArc[index]
                                          .nombreProyeccion;
                                },
                                control: SwiperControl(size: 15),
                                pagination: SwiperPagination(
                                    builder: SwiperPagination.dots),
                                itemCount: 5,
                                loop: false,
                                layout: SwiperLayout.DEFAULT,
                                itemHeight: 200,
                                itemWidth:
                                    MediaQuery.of(context).size.width / 2,
                                itemBuilder: (BuildContext context, int index) {
                                  DescripcionSistemCoor elipsoidal =
                                      DescripcionSistemCoor(
                                          nombreProyeccion: 'Elipsoidales',
                                          imagen:
                                              'assets/images/elipsoidal.png');
                                  DescripcionSistemCoor geocentrico =
                                      DescripcionSistemCoor(
                                    nombreProyeccion: 'Geocentricas',
                                    imagen: 'assets/images/geocentrica.png',
                                  );
                                  DescripcionSistemCoor planas_Gauss =
                                      DescripcionSistemCoor(
                                    nombreProyeccion: 'Gauss - Krüger',
                                    imagen: 'assets/images/gauss.png',
                                  );
                                  DescripcionSistemCoor planas_Cartesianas =
                                      DescripcionSistemCoor(
                                          nombreProyeccion:
                                              'Planas Cartesianas',
                                          imagen:
                                              'assets/images/cartesiana.png');
                                  DescripcionSistemCoor tm =
                                      DescripcionSistemCoor(
                                          nombreProyeccion:
                                              'Magna Origen Nacional',
                                          imagen: 'assets/images/nacional.png');
                                  listSistemasOrigenArc[0] = elipsoidal;
                                  listSistemasOrigenArc[1] = geocentrico;
                                  listSistemasOrigenArc[2] = planas_Gauss;
                                  listSistemasOrigenArc[3] = planas_Cartesianas;
                                  listSistemasOrigenArc[4] = tm;
                                  DescripcionSistemCoor a =
                                      listSistemasOrigenArc[index];
                                  return Container(
                                    width: 150,
                                    height: 200,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Column(
                                      children: <Widget>[
                                        Center(
                                          child: Text(
                                            'Sistema Partida',
                                            style: TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.black54,
                                            ),
                                          ),
                                        ),
                                        Divider(),
                                        Center(
                                          child: Text(
                                            a.nombreProyeccion,
                                            style: TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.blueAccent,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 60.0),
                                        Image.asset(a.imagen, height: 160)
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                            Container(
                              height: 280,
                              width: MediaQuery.of(context).size.width / 2 - 20,
                              child: Swiper(
                                onIndexChanged: (int index) {
                                  sistemadestinoArc =
                                      listSistemasDestinoArc[index]
                                          .nombreProyeccion;
                                },
                                control: SwiperControl(size: 15),
                                loop: false,
                                itemCount: 5,
                                pagination: SwiperPagination(
                                    builder: SwiperPagination.dots),
                                layout: SwiperLayout.DEFAULT,
                                itemHeight: 200,
                                itemWidth:
                                    MediaQuery.of(context).size.width / 2,
                                itemBuilder: (BuildContext context, int index) {
                                  DescripcionSistemCoor elipsoidal =
                                      DescripcionSistemCoor(
                                          nombreProyeccion: 'Elipsoidales',
                                          imagen:
                                              'assets/images/elipsoidal.png');
                                  DescripcionSistemCoor geocentrico =
                                      DescripcionSistemCoor(
                                    nombreProyeccion: 'Geocentricas',
                                    imagen: 'assets/images/geocentrica.png',
                                  );
                                  DescripcionSistemCoor planas_Gauss =
                                      DescripcionSistemCoor(
                                    nombreProyeccion: 'Gauss - Krüger',
                                    imagen: 'assets/images/gauss.png',
                                  );
                                  DescripcionSistemCoor planas_Cartesianas =
                                      DescripcionSistemCoor(
                                          nombreProyeccion:
                                              'Planas Cartesianas',
                                          imagen:
                                              'assets/images/cartesiana.png');
                                  DescripcionSistemCoor tm =
                                      DescripcionSistemCoor(
                                          nombreProyeccion:
                                              'Magna Origen Nacional',
                                          imagen: 'assets/images/nacional.png');
                                  listSistemasDestinoArc[0] = elipsoidal;
                                  listSistemasDestinoArc[1] = geocentrico;
                                  listSistemasDestinoArc[2] = planas_Gauss;
                                  listSistemasDestinoArc[3] =
                                      planas_Cartesianas;
                                  listSistemasDestinoArc[4] = tm;
                                  DescripcionSistemCoor a =
                                      listSistemasDestinoArc[index];
                                  return Container(
                                    width: 150,
                                    height: 200,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Column(
                                      children: <Widget>[
                                        Center(
                                          child: Text(
                                            'Sistema Destino',
                                            style: TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.black54,
                                            ),
                                          ),
                                        ),
                                        Divider(),
                                        Center(
                                          child: Text(
                                            a.nombreProyeccion,
                                            style: TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.blueAccent,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 60.0),
                                        Image.asset(a.imagen, height: 160),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                        FlatButton(
                            onPressed: () {
                              AlertDialog conversionArchivoCSV = AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                content: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  height: 300,
                                  width: 200,
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Column(
                                      children: <Widget>[
                                        Text(
                                            'Conversión de coordendas por Archivo',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.blueAccent,
                                                fontSize: 13)),
                                        Divider(),
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                              'Sistema de Coordenadas Origen',
                                              style: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 12)),
                                        ),
                                        Divider(),
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text('${sistemaOrigenArc}',
                                              style: TextStyle(
                                                  color: Colors.blueAccent,
                                                  fontSize: 13)),
                                        ),
                                        Divider(),
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                              'Sistema de Coordenadas Destino',
                                              style: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 12)),
                                        ),
                                        Divider(),
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text('${sistemadestinoArc}',
                                              style: TextStyle(
                                                  color: Colors.blueAccent,
                                                  fontSize: 13)),
                                        ),
                                        Container(
                                            height: 120,
                                            width: 250,
                                            child: Container(
                                              child: Center(
                                                child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            2.0),
                                                    child: FlatButton(
                                                      onPressed: () async {
                                                        File archivoCSVElip =
                                                            await FilePicker.getFile(
                                                                allowedExtensions: [
                                                              'csv'
                                                            ],
                                                                type: FileType
                                                                    .custom);
                                                        String datosCSV =
                                                            await archivoCSVElip
                                                                .readAsString();
                                                        List<List<dynamic>>
                                                            listaDatosCSV =
                                                            CsvToListConverter()
                                                                .convert(
                                                                    datosCSV);
                                                        if (datosCSV != null) {
                                                          setState(() {
                                                            csvload = true;
                                                          });
                                                          Navigator.push(
                                                              context,
                                                              new MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          ConfiguracionArchivoImportado(
                                                                            destinoCS:
                                                                                sistemadestinoArc,
                                                                            origenCS:
                                                                                sistemaOrigenArc,
                                                                            dataCSV:
                                                                                listaDatosCSV,
                                                                          )));
                                                          Navigator.of(context,
                                                                  rootNavigator:
                                                                      true)
                                                              .pop('dialog');
                                                        }
                                                      },
                                                      child: Column(
                                                        children: <Widget>[
                                                          Image.asset(
                                                            'assets/images/csv_unload.png',
                                                            height: 80,
                                                          ),
                                                          Text(
                                                              'Seleccione el archico CSV con coordenadas ${sistemaOrigenArc}',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black54,
                                                                  fontSize:
                                                                      13)),
                                                        ],
                                                      ),
                                                    )),
                                              ),
                                            ))
                                      ],
                                    ),
                                  ),
                                ),
                              );
                              showDialog(
                                  context: context,
                                  barrierDismissible: true,
                                  builder: (BuildContext context) {
                                    return conversionArchivoCSV;
                                  });
                            },
                            child: Column(
                              children: <Widget>[
                                Image.asset(
                                  'assets/images/seleccionar.png',
                                  height: 20,
                                ),
                                Text('Seleccionar',
                                    style: TextStyle(
                                        color: Colors.blueAccent, fontSize: 14))
                              ],
                            ))
                      ],
                    ),
                  ),
                  SizedBox(height: 25),
                  Container(
                    height: 450,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 2,
                              offset: Offset(0, 3),
                              color: Colors.black54)
                        ]),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 20),
                        Text('Conversión Puntos de Referencia',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.blueAccent, fontSize: 14)),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            'Convierte las coordenadas de tus puntos de referencia almacenados dentro del proyecto a los sistemas de Coordenadas Planas Cartesianas, Gauss Krüger, Geocéntricas y Elipsoidales que se encuentren en el Datum MAGNA SIRGAS',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        Container(
                          height: 280,
                          width: MediaQuery.of(context).size.width / 2 - 20,
                          child: Swiper(
                            onIndexChanged: (int index) {
                              sistemadestinoRef =
                                  listSistemasDestinoPR[index].nombreProyeccion;
                            },
                            control: SwiperControl(size: 15),
                            pagination: SwiperPagination(
                                builder: SwiperPagination.dots),
                            itemCount: 5,
                            loop: false,
                            layout: SwiperLayout.DEFAULT,
                            itemHeight: 200,
                            itemWidth: MediaQuery.of(context).size.width / 2,
                            itemBuilder: (BuildContext context, int index) {
                              DescripcionSistemCoor elipsoidal =
                                  DescripcionSistemCoor(
                                      nombreProyeccion: 'Elipsoidales',
                                      imagen: 'assets/images/elipsoidal.png');
                              DescripcionSistemCoor geocentrico =
                                  DescripcionSistemCoor(
                                nombreProyeccion: 'Geocentricas',
                                imagen: 'assets/images/geocentrica.png',
                              );
                              DescripcionSistemCoor planas_Gauss =
                                  DescripcionSistemCoor(
                                nombreProyeccion: 'Gauss - Krüger',
                                imagen: 'assets/images/gauss.png',
                              );
                              DescripcionSistemCoor planas_Cartesianas =
                                  DescripcionSistemCoor(
                                      nombreProyeccion: 'Planas Cartesianas',
                                      imagen: 'assets/images/cartesiana.png');
                              DescripcionSistemCoor tm = DescripcionSistemCoor(
                                  nombreProyeccion: 'Magna Origen Nacional',
                                  imagen: 'assets/images/nacional.png');
                              listSistemasDestinoPR[0] = elipsoidal;
                              listSistemasDestinoPR[1] = geocentrico;
                              listSistemasDestinoPR[2] = planas_Gauss;
                              listSistemasDestinoPR[3] = planas_Cartesianas;
                              listSistemasDestinoPR[4] = tm;
                              DescripcionSistemCoor a =
                                  listSistemasDestinoPR[index];
                              return Container(
                                width: 150,
                                height: 200,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  children: <Widget>[
                                    Center(
                                      child: Text(
                                        'Sistema Destino',
                                        style: TextStyle(
                                          fontSize: 12.0,
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ),
                                    Divider(),
                                    Center(
                                      child: Text(
                                        a.nombreProyeccion,
                                        style: TextStyle(
                                          fontSize: 12.0,
                                          color: Colors.blueAccent,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 60.0),
                                    Image.asset(a.imagen, height: 160)
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        FlatButton(
                            onPressed: () async {
                              GaussCS gaussCS = await gestorMBDatabase.db
                                  .getOrigenGaussData(
                                      widget.datosProyecto.ID_Proyeccion);
                              List<puntosReferencia> listaRef =
                                  await gestorMBDatabase.db
                                      .getPuntosReferenciaData(
                                          widget.datosProyecto.Nombre_Proyecto);
                              int cont = listaRef.length;
                              if (cont > 0) {
                                if (widget.datosProyecto.Tipo_Proyeccion ==
                                    'Gauss-Krüger') {
                                  ConversionCoordenadasMB
                                      conversionCoordenadasMB =
                                      ConversionCoordenadasMB();
                                  if (sistemadestinoRef == 'Elipsoidales') {
                                    List<CoordenadasElipsoidales> listCoorElip =
                                        List<CoordenadasElipsoidales>(cont);
                                    List<String> nombrePunto =
                                        List<String>(cont);
                                    List<List<dynamic>> ref2Elispodailes =
                                        List<List<dynamic>>(cont + 1);
                                    List<String> puntos0 = List(4);
                                    puntos0[0] = 'ID Punto';
                                    puntos0[1] = 'Latitud';
                                    puntos0[2] = 'Longitud';
                                    puntos0[3] = 'Altura';
                                    ref2Elispodailes[0] = puntos0;
                                    for (var i = 0; i < cont; i++) {
                                      nombrePunto[i] = listaRef[i].Nombre_Punto;
                                      listCoorElip[i] = conversionCoordenadasMB
                                          .gauss2Elipsoidales(
                                              gaussCS,
                                              CoordenadasGauss(
                                                  norte: listaRef[i].Norte,
                                                  este: listaRef[i].Este,
                                                  altura: listaRef[i].Altura));
                                      List<dynamic> puntos = List(4);
                                      puntos[0] = nombrePunto[i];
                                      puntos[1] = listCoorElip[i].latitud;
                                      puntos[2] = listCoorElip[i].longitud;
                                      puntos[3] = listCoorElip[i].altitud;
                                      ref2Elispodailes[i + 1] = puntos;
                                    }
                                    final Directory directorio =
                                        await getApplicationDocumentsDirectory();
                                    final File csvGuardar = File(
                                        '${directorio.path}/MeasureBookConversiónElipsoidales.csv');
                                    String datosCSV = const ListToCsvConverter()
                                        .convert(ref2Elispodailes);
                                    await csvGuardar.writeAsString(datosCSV);
                                    Uint8List arCSv =
                                        csvGuardar.readAsBytesSync();
                                    await Share.file(
                                        'Conversion Archivos MeasureBookAPP',
                                        'Elipsoidales.csv',
                                        arCSv,
                                        'file/csv',
                                        text:
                                            'Conversión de Coordenadas MeasureBook');
                                  } else if (sistemadestinoRef ==
                                      'Geocentricas') {
                                    List<CoordenadasElipsoidales> listCoorElip =
                                        List<CoordenadasElipsoidales>(cont);
                                    List<CoordenadasGeocentricas>
                                        listCoorGeocen =
                                        List<CoordenadasGeocentricas>(cont);
                                    List<String> nombrePunto =
                                        List<String>(cont);
                                    List<List<dynamic>> ref2Elispodailes =
                                        List<List<dynamic>>(cont + 1);
                                    List<String> puntos0 = List(4);
                                    puntos0[0] = 'ID Punto';
                                    puntos0[1] = 'Coordenada X';
                                    puntos0[2] = 'Coordenada Y';
                                    puntos0[3] = 'Coordenada Z';
                                    ref2Elispodailes[0] = puntos0;
                                    for (var i = 0; i < cont; i++) {
                                      nombrePunto[i] = listaRef[i].Nombre_Punto;
                                      listCoorElip[i] = conversionCoordenadasMB
                                          .gauss2Elipsoidales(
                                              gaussCS,
                                              CoordenadasGauss(
                                                  norte: listaRef[i].Norte,
                                                  este: listaRef[i].Este,
                                                  altura: listaRef[i].Altura));
                                      listCoorGeocen[i] =
                                          conversionCoordenadasMB
                                              .elipsoidales2Geocentricas(
                                                  listCoorElip[i]);
                                      List<dynamic> puntos = List(4);
                                      puntos[0] = nombrePunto[i];
                                      puntos[1] = listCoorGeocen[i].x;
                                      puntos[2] = listCoorGeocen[i].y;
                                      puntos[3] = listCoorGeocen[i].z;
                                      ref2Elispodailes[i + 1] = puntos;
                                    }
                                    final Directory directorio =
                                        await getApplicationDocumentsDirectory();
                                    final File csvGuardar = File(
                                        '${directorio.path}/MeasureBookConversiónElipsoidales.csv');
                                    String datosCSV = const ListToCsvConverter()
                                        .convert(ref2Elispodailes);
                                    await csvGuardar.writeAsString(datosCSV);
                                    Uint8List arCSv =
                                        csvGuardar.readAsBytesSync();
                                    await Share.file(
                                        'Conversion Archivos MeasureBookAPP',
                                        'Geocentricas.csv',
                                        arCSv,
                                        'file/csv',
                                        text:
                                            'Conversión de Coordenadas MeasureBook');
                                  } else if (sistemadestinoRef ==
                                      'Gauss - Krüger') {
                                    if (origenGauss == true) {
                                      List<CoordenadasElipsoidales>
                                          listCoorElip =
                                          List<CoordenadasElipsoidales>(cont);
                                      List<CoordenadasGauss> listCoorGauss =
                                          List<CoordenadasGauss>(cont);
                                      List<String> nombrePunto =
                                          List<String>(cont);
                                      List<List<dynamic>> ref2Elispodailes =
                                          List<List<dynamic>>(cont + 1);
                                      List<String> puntos0 = List(4);
                                      puntos0[0] = 'ID Punto';
                                      puntos0[1] = 'Norte';
                                      puntos0[2] = 'Este';
                                      puntos0[3] = 'Altura';
                                      ref2Elispodailes[0] = puntos0;
                                      for (var i = 0; i < cont; i++) {
                                        nombrePunto[i] =
                                            listaRef[i].Nombre_Punto;
                                        listCoorElip[i] =
                                            conversionCoordenadasMB
                                                .gauss2Elipsoidales(
                                                    gaussCS,
                                                    CoordenadasGauss(
                                                        norte:
                                                            listaRef[i].Norte,
                                                        este: listaRef[i].Este,
                                                        altura: listaRef[i]
                                                            .Altura));
                                        listCoorGauss[i] =
                                            conversionCoordenadasMB
                                                .elipsoidales2Gauss(
                                                    listCoorElip[i],
                                                    gaussCOrigen);
                                        List<dynamic> puntos = List(4);
                                        puntos[0] = nombrePunto[i];
                                        puntos[1] = listCoorGauss[i].norte;
                                        puntos[2] = listCoorGauss[i].este;
                                        puntos[3] = listCoorGauss[i].altura;
                                        ref2Elispodailes[i + 1] = puntos;
                                      }
                                      final Directory directorio =
                                          await getApplicationDocumentsDirectory();
                                      final File csvGuardar = File(
                                          '${directorio.path}/MeasureBookConversiónElipsoidales.csv');
                                      String datosCSV =
                                          const ListToCsvConverter()
                                              .convert(ref2Elispodailes);
                                      await csvGuardar.writeAsString(datosCSV);
                                      Uint8List arCSv =
                                          csvGuardar.readAsBytesSync();
                                      await Share.file(
                                          'Conversion Archivos MeasureBookAPP',
                                          'Gauss.csv',
                                          arCSv,
                                          'file/csv',
                                          text:
                                              'Conversión de Coordenadas MeasureBook');
                                      origenGauss = false;
                                    } else {
                                      _sistemaGauss2(context);
                                    }
                                  }
                                  //Planas Cartesianas
                                  else if (sistemadestinoRef ==
                                      'Planas Cartesianas') {
                                    if (origenCartesiano == true) {
                                      List<CoordenadasElipsoidales>
                                          listCoorElip =
                                          List<CoordenadasElipsoidales>(cont);
                                      List<CoordenadasCartesianas>
                                          listCoorCartesian =
                                          List<CoordenadasCartesianas>(cont);
                                      List<String> nombrePunto =
                                          List<String>(cont);
                                      List<List<dynamic>> ref2Elispodailes =
                                          List<List<dynamic>>(cont + 1);
                                      List<String> puntos0 = List(4);
                                      puntos0[0] = 'ID Punto';
                                      puntos0[1] = 'Norte';
                                      puntos0[2] = 'Este';
                                      puntos0[3] = 'Altura';
                                      ref2Elispodailes[0] = puntos0;
                                      for (var i = 0; i < cont; i++) {
                                        nombrePunto[i] =
                                            listaRef[i].Nombre_Punto;
                                        listCoorElip[i] =
                                            conversionCoordenadasMB
                                                .gauss2Elipsoidales(
                                                    gaussCS,
                                                    CoordenadasGauss(
                                                        norte:
                                                            listaRef[i].Norte,
                                                        este: listaRef[i].Este,
                                                        altura: listaRef[i]
                                                            .Altura));
                                        listCoorCartesian[i] =
                                            conversionCoordenadasMB
                                                .elipsoidales2Cartesianas(
                                                    origenCartesian,
                                                    listCoorElip[i]);
                                        List<dynamic> puntos = List(4);
                                        puntos[0] = nombrePunto[i];
                                        puntos[1] = listCoorCartesian[i].norte;
                                        puntos[2] = listCoorCartesian[i].este;
                                        puntos[3] = listCoorCartesian[i].altura;
                                        ref2Elispodailes[i + 1] = puntos;
                                      }
                                      final Directory directorio =
                                          await getApplicationDocumentsDirectory();
                                      final File csvGuardar = File(
                                          '${directorio.path}/MeasureBookConversiónElipsoidales.csv');
                                      String datosCSV =
                                          const ListToCsvConverter()
                                              .convert(ref2Elispodailes);
                                      await csvGuardar.writeAsString(datosCSV);
                                      Uint8List arCSv =
                                          csvGuardar.readAsBytesSync();
                                      await Share.file(
                                          'Conversion Archivos MeasureBookAPP',
                                          'Cartesianas.csv',
                                          arCSv,
                                          'file/csv',
                                          text:
                                              'Conversión de Coordenadas MeasureBook');
                                      origenCartesiano = false;
                                    } else {
                                      _alertDialogoCartesianas2(context);
                                    }
                                  }
                                } else {
                                  //Planas Cartesianas
                                }
                              } else {
                                sinPuntosReferencia();
                              }
                            },
                            child: Column(
                              children: <Widget>[
                                Image.asset(
                                  'assets/images/seleccionar.png',
                                  height: 40,
                                ),
                                Text('Seleccionar',
                                    style: TextStyle(
                                        color: Colors.blueAccent, fontSize: 14))
                              ],
                            ))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void sinPuntosReferencia() {
    Fluttertoast.showToast(
        msg: "Aún no tienes puntos de referencia creados en este proyecto ",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2);
  }

  void alertaIgualSystemCoor() {
    Navigator.pop(context);
    Fluttertoast.showToast(
        msg: "El sistema de Partida es igual al de destino ",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2);
  }

  void alertaErrorArchivo() {
    Fluttertoast.showToast(
        msg:
            "El formato del archivo no es compatible, por favor valide que el CSV este delimitado por comas y use punto como simbolo decimal ",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2);
  }

  void alertaIndexCoor(String indiceI, indiceII) {
    Fluttertoast.showToast(
        msg:
            "El indice ${indiceI} es igual al indice ${indiceII}, por favor verifique el indice seleccionado para cada uno de los campos",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2);
  }

  void alertanoGaussOrigen() {
    Fluttertoast.showToast(
        msg: "No se ha seleccionado el origen del sistema Gauss",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2);
  }

  void alertanoGaussCartesian() {
    Fluttertoast.showToast(
        msg: "No se ha seleccionado el origen del Plano Cartesiano",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2);
  }

  _sistemaGauss2(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => Container(
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  child: FutureBuilder<List<origenesGauss>>(
                    future: gestorMBDatabase.db.getGauss(),
                    builder:
                        (context, AsyncSnapshot<List<origenesGauss>> snapshot) {
                      if (snapshot.hasData) {
                        return Swiper(
                            loop: false,
                            pagination: SwiperPagination(
                                builder: SwiperPagination.dots),
                            layout: SwiperLayout.TINDER,
                            itemWidth: 320,
                            itemHeight: 580,
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, int index) {
                              origenesGauss listaOrigenes =
                                  snapshot.data[index];
                              return Container(
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                  ),
                                  key: UniqueKey(),
                                  child: Card(
                                    elevation: 14.0,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/fondo_sistemas.png'),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Column(
                                          children: <Widget>[
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: RichText(
                                                  text: TextSpan(
                                                      children: <TextSpan>[
                                                    TextSpan(
                                                        text: 'Gauss-Krüger',
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'Roboto',
                                                            color: Colors.white,
                                                            fontSize: 14.0)),
                                                  ])),
                                            ),
                                            Align(
                                              alignment: Alignment.bottomLeft,
                                              child: Text(
                                                '${listaOrigenes.NOMBRE}',
                                                style: TextStyle(
                                                    fontFamily: 'Roboto',
                                                    color: Colors.white,
                                                    fontSize: 14.0),
                                              ),
                                            ),
                                            SizedBox(height: 45.0),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: RichText(
                                                  text: TextSpan(children: <
                                                      TextSpan>[
                                                TextSpan(
                                                    text: 'DATUM: \n ',
                                                    style: TextStyle(
                                                        fontFamily: 'Roboto',
                                                        color: Colors.black54,
                                                        fontSize: 12.0)),
                                                TextSpan(
                                                    text: 'Magna Sirgas',
                                                    style: TextStyle(
                                                        fontFamily: 'Roboto',
                                                        color:
                                                            Color(0xff007FFF),
                                                        fontSize: 13.0))
                                              ])),
                                            ),
                                            Divider(),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: RichText(
                                                  text: TextSpan(children: <
                                                      TextSpan>[
                                                TextSpan(
                                                    text: 'Elipsoide: \n',
                                                    style: TextStyle(
                                                        fontFamily: 'Roboto',
                                                        color: Colors.black54,
                                                        fontSize: 12.0)),
                                                TextSpan(
                                                    text: 'GRS80',
                                                    style: TextStyle(
                                                        fontFamily: 'Roboto',
                                                        color:
                                                            Color(0xff007FFF),
                                                        fontSize: 13.0))
                                              ])),
                                            ),
                                            Divider(),
                                            Align(
                                              alignment: Alignment.center,
                                              child: RichText(
                                                  text: TextSpan(children: <
                                                      TextSpan>[
                                                TextSpan(
                                                    text:
                                                        'Sistema de Proyección',
                                                    style: TextStyle(
                                                        fontFamily: 'Roboto',
                                                        color:
                                                            Color(0xff007FFF),
                                                        fontSize: 14.0)),
                                              ])),
                                            ),
                                            Divider(),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: RichText(
                                                  text: TextSpan(children: <
                                                      TextSpan>[
                                                TextSpan(
                                                    text: 'Proyección \n',
                                                    style: TextStyle(
                                                        fontFamily: 'Roboto',
                                                        color: Colors.black54,
                                                        fontSize: 12.0)),
                                                TextSpan(
                                                    text:
                                                        'Transversal de Mercator',
                                                    style: TextStyle(
                                                        fontFamily: 'Roboto',
                                                        color:
                                                            Color(0xff007FFF),
                                                        fontSize: 13.0))
                                              ])),
                                            ),
                                            Divider(),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: RichText(
                                                  text: TextSpan(children: <
                                                      TextSpan>[
                                                TextSpan(
                                                    text:
                                                        'Latitud de Origen \n',
                                                    style: TextStyle(
                                                        fontFamily: 'Roboto',
                                                        color: Colors.black54,
                                                        fontSize: 12.0)),
                                                TextSpan(
                                                    text:
                                                        '${listaOrigenes.LATITUD.toString()}',
                                                    style: TextStyle(
                                                        fontFamily: 'Roboto',
                                                        color:
                                                            Color(0xff007FFF),
                                                        fontSize: 13.0))
                                              ])),
                                            ),
                                            Divider(),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: RichText(
                                                  text: TextSpan(children: <
                                                      TextSpan>[
                                                TextSpan(
                                                    text:
                                                        'Longitud de Origen \n',
                                                    style: TextStyle(
                                                        fontFamily: 'Roboto',
                                                        color: Colors.black54,
                                                        fontSize: 12.0)),
                                                TextSpan(
                                                    text:
                                                        '${listaOrigenes.LONGITUD.toString()}',
                                                    style: TextStyle(
                                                        fontFamily: 'Roboto',
                                                        color:
                                                            Color(0xff007FFF),
                                                        fontSize: 13.0))
                                              ])),
                                            ),
                                            Divider(),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: RichText(
                                                  text: TextSpan(children: <
                                                      TextSpan>[
                                                TextSpan(
                                                    text: 'Falso Norte \n',
                                                    style: TextStyle(
                                                        fontFamily: 'Roboto',
                                                        color: Colors.black54,
                                                        fontSize: 12.0)),
                                                TextSpan(
                                                    text:
                                                        '${listaOrigenes.NORTE.toString()}00 m',
                                                    style: TextStyle(
                                                        fontFamily: 'Roboto',
                                                        color:
                                                            Color(0xff007FFF),
                                                        fontSize: 13.0))
                                              ])),
                                            ),
                                            Divider(),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: RichText(
                                                  text: TextSpan(children: <
                                                      TextSpan>[
                                                TextSpan(
                                                    text: 'Falso Este \n',
                                                    style: TextStyle(
                                                        fontFamily: 'Roboto',
                                                        color: Colors.black54,
                                                        fontSize: 12.0)),
                                                TextSpan(
                                                    text:
                                                        '${listaOrigenes.ESTE.toString()} m',
                                                    style: TextStyle(
                                                        fontFamily: 'Roboto',
                                                        color:
                                                            Color(0xff007FFF),
                                                        fontSize: 13.0))
                                              ])),
                                            ),
                                            Divider(),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: RichText(
                                                  text: TextSpan(children: <
                                                      TextSpan>[
                                                TextSpan(
                                                    text: 'Factor de Escala\n ',
                                                    style: TextStyle(
                                                        fontFamily: 'Roboto',
                                                        color: Colors.black54,
                                                        fontSize: 12.0)),
                                                TextSpan(
                                                    text: '1.000000000',
                                                    style: TextStyle(
                                                        fontFamily: 'Roboto',
                                                        color:
                                                            Color(0xff007FFF),
                                                        fontSize: 13.0))
                                              ])),
                                            ),
                                            Divider(),
                                            Align(
                                              alignment: Alignment.center,
                                              child: Center(
                                                child: Column(
                                                  children: <Widget>[
                                                    FlatButton(
                                                        onPressed: () {
                                                          GaussCS gaussC =
                                                              GaussCS();
                                                          gaussC.NORTE =
                                                              listaOrigenes
                                                                  .NORTE;
                                                          gaussC.ESTE =
                                                              listaOrigenes
                                                                  .ESTE;
                                                          gaussC.LATITUD =
                                                              listaOrigenes
                                                                  .LATITUD;
                                                          gaussC.LONGITUD =
                                                              listaOrigenes
                                                                  .LONGITUD;
                                                          gaussC.NOMBRE =
                                                              listaOrigenes
                                                                  .NOMBRE;
                                                          Navigator.pop(
                                                              context);
                                                          setState(() {
                                                            gaussCOrigen =
                                                                gaussC;
                                                            origenGauss = true;
                                                          });
                                                        },
                                                        child: Column(
                                                          children: <Widget>[
                                                            Image.asset(
                                                              'assets/images/seleccionar.png',
                                                              height: 40,
                                                            ),
                                                            Text('Seleccionar',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .blueAccent,
                                                                    fontSize:
                                                                        14))
                                                          ],
                                                        )),
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ));
                            });
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ))));
  }

  void _alertDialogoCartesianas2(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => Container(
              height: 500,
              child: Scaffold(
                body: FutureBuilder<List<departamentos>>(
                    future: gestorMBDatabase.db.getDepartamentos(),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<departamentos>> listaDep) {
                      if (listaDep.hasData) {
                        return Container(
                            height: 700,
                            child: Column(
                              children: <Widget>[
                                SizedBox(height: 30),
                                Text(
                                  'Seleccione un Departamento',
                                  style: TextStyle(
                                      color: Color(0xff007FFF), fontSize: 16.0),
                                ),
                                SizedBox(
                                  height: 14.0,
                                ),
                                Flexible(
                                  child: ListView.builder(
                                      itemCount: listaDep.data.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        departamentos listaDepartamentos =
                                            listaDep.data[index];
                                        return Dismissible(
                                            onDismissed: (direction) {},
                                            key: UniqueKey(),
                                            child: Container(
                                                height: 50,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: ListTile(
                                                  title: Text(
                                                    listaDepartamentos.NOMBRE,
                                                    style: TextStyle(
                                                        color: Colors.black54,
                                                        fontSize: 16.0),
                                                  ),
                                                  trailing: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: <Widget>[
                                                      Icon(Icons.chevron_right,
                                                          color:
                                                              Colors.blueAccent)
                                                    ],
                                                  ),
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                    _alertDialogoCartesianasMunicipio2(
                                                        context,
                                                        listaDepartamentos
                                                            .PK_DEPARTAMENTO);
                                                  },
                                                )));
                                      }),
                                )
                              ],
                            ));
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
              ),
            ));
  }

  void _alertDialogoCartesianasMunicipio2(
      BuildContext context, int fk_Departamento) {
    showDialog(
        context: context,
        builder: (context) => Container(
              height: 500,
              child: Scaffold(
                body: FutureBuilder<List<municipios>>(
                    future: gestorMBDatabase.db.getMunicipios(fk_Departamento),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<municipios>> listaMunicipios) {
                      if (listaMunicipios.hasData) {
                        return Container(
                            height: 700,
                            child: Column(
                              children: <Widget>[
                                SizedBox(height: 30),
                                Text(
                                  'Seleccione un Municipio',
                                  style: TextStyle(
                                      color: Color(0xff007FFF), fontSize: 16.0),
                                ),
                                SizedBox(
                                  height: 14.0,
                                ),
                                Flexible(
                                  child: ListView.builder(
                                      itemCount: listaMunicipios.data.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        municipios listaMun =
                                            listaMunicipios.data[index];
                                        return Dismissible(
                                            key: UniqueKey(),
                                            child: Container(
                                                height: 50,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: ListTile(
                                                  title: Text(
                                                    listaMun.NOMBRE,
                                                    style: TextStyle(
                                                        color: Colors.black54,
                                                        fontSize: 14.0),
                                                  ),
                                                  trailing: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: <Widget>[
                                                      Icon(Icons.chevron_right,
                                                          color:
                                                              Colors.blueAccent)
                                                    ],
                                                  ),
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                    _sistemas2Cartesianos2(
                                                        context,
                                                        listaMun.PK_MUNICIPIOS);
                                                  },
                                                )));
                                      }),
                                )
                              ],
                            ));
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
              ),
            ));
  }

  void _sistemas2Cartesianos2(BuildContext context, int fk_Muninipio) {
    showDialog(
        context: context,
        builder: (context) => Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(30)),
              child: FutureBuilder<List<origenesCartesianos>>(
                future: gestorMBDatabase.db.getCartesianas(fk_Muninipio),
                builder: (BuildContext context,
                    AsyncSnapshot<List<origenesCartesianos>> snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data.length > 1) {
                      return Swiper(
                          layout: SwiperLayout.TINDER,
                          pagination:
                              SwiperPagination(builder: SwiperPagination.dots),
                          loop: false,
                          itemWidth: MediaQuery.of(context).size.width * 0.8,
                          itemHeight: MediaQuery.of(context).size.height * .70,
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            origenesCartesianos listaOrigenes =
                                snapshot.data[index];
                            return Container(
                                height: 550,
                                width: 270,
                                decoration: BoxDecoration(),
                                key: UniqueKey(),
                                child: Card(
                                  elevation: 14.0,
                                  child: Container(
                                    height: 500,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/fondo_sistemas.png'),
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
                                            child: RichText(
                                                text: TextSpan(
                                                    children: <TextSpan>[
                                                  TextSpan(
                                                      text: 'Plano Cartesiano',
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          color: Colors.white,
                                                          fontSize: 14.0)),
                                                ])),
                                          ),
                                          Align(
                                            alignment: Alignment.bottomLeft,
                                            child: Text(
                                              '${listaOrigenes.NOMBRE}',
                                              style: TextStyle(
                                                  fontFamily: 'Roboto',
                                                  color: Colors.white,
                                                  fontSize: 14.0),
                                            ),
                                          ),
                                          SizedBox(height: 40.0),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: RichText(
                                                text: TextSpan(
                                                    children: <TextSpan>[
                                                  TextSpan(
                                                      text: 'DATUM \n',
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          color: Colors.black54,
                                                          fontSize: 12.0)),
                                                  TextSpan(
                                                      text: 'Magna Sirgas',
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          color:
                                                              Color(0xff007FFF),
                                                          fontSize: 13.0))
                                                ])),
                                          ),
                                          Divider(),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: RichText(
                                                text: TextSpan(
                                                    children: <TextSpan>[
                                                  TextSpan(
                                                      text: 'Elipsoide\n',
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          color: Colors.black54,
                                                          fontSize: 12.0)),
                                                  TextSpan(
                                                      text: 'GRS80',
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          color:
                                                              Color(0xff007FFF),
                                                          fontSize: 13.0))
                                                ])),
                                          ),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                          Align(
                                            alignment: Alignment.center,
                                            child: RichText(
                                                text: TextSpan(
                                                    children: <TextSpan>[
                                                  TextSpan(
                                                      text:
                                                          'Sistema de Proyección ',
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          color:
                                                              Color(0xff007FFF),
                                                          fontSize: 14.0)),
                                                ])),
                                          ),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: RichText(
                                                text: TextSpan(
                                                    children: <TextSpan>[
                                                  TextSpan(
                                                      text: 'Proyección\n',
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          color: Colors.black54,
                                                          fontSize: 12.0)),
                                                  TextSpan(
                                                      text:
                                                          'Plano Cartesiano IGAC',
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          color:
                                                              Color(0xff007FFF),
                                                          fontSize: 13.0))
                                                ])),
                                          ),
                                          Divider(),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: RichText(
                                                text: TextSpan(
                                                    children: <TextSpan>[
                                                  TextSpan(
                                                      text:
                                                          'Latitud de Origen\n',
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          color: Colors.black54,
                                                          fontSize: 12.0)),
                                                  TextSpan(
                                                      text:
                                                          '${listaOrigenes.LATITUD.toString()}',
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          color:
                                                              Color(0xff007FFF),
                                                          fontSize: 13.0))
                                                ])),
                                          ),
                                          Divider(),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: RichText(
                                                text: TextSpan(
                                                    children: <TextSpan>[
                                                  TextSpan(
                                                      text:
                                                          'Longitud de Origen\n',
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          color: Colors.black54,
                                                          fontSize: 13.0)),
                                                  TextSpan(
                                                      text:
                                                          '${listaOrigenes.LONGITUD.toString()}',
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          color:
                                                              Color(0xff007FFF),
                                                          fontSize: 13.0))
                                                ])),
                                          ),
                                          Divider(),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: RichText(
                                                text: TextSpan(
                                                    children: <TextSpan>[
                                                  TextSpan(
                                                      text: 'Falso Norte\n',
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          color: Colors.black54,
                                                          fontSize: 12.0)),
                                                  TextSpan(
                                                      text:
                                                          '${listaOrigenes.NORTE.toString()} m',
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          color:
                                                              Color(0xff007FFF),
                                                          fontSize: 13.0))
                                                ])),
                                          ),
                                          Divider(),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: RichText(
                                                text: TextSpan(
                                                    children: <TextSpan>[
                                                  TextSpan(
                                                      text: 'Falso Este\n ',
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          color: Colors.black54,
                                                          fontSize: 12.0)),
                                                  TextSpan(
                                                      text:
                                                          '${listaOrigenes.ESTE.toString()} m',
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          color:
                                                              Color(0xff007FFF),
                                                          fontSize: 13.0))
                                                ])),
                                          ),
                                          Divider(),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: RichText(
                                                text: TextSpan(
                                                    children: <TextSpan>[
                                                  TextSpan(
                                                      text:
                                                          'Altura del Plano\n ',
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          color: Colors.black54,
                                                          fontSize: 12.0)),
                                                  TextSpan(
                                                      text:
                                                          '${listaOrigenes.PLANO_PROY} m',
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          color:
                                                              Color(0xff007FFF),
                                                          fontSize: 13.0))
                                                ])),
                                          ),
                                          Divider(),
                                          Align(
                                            alignment: Alignment.center,
                                            child: Center(
                                              child: Column(
                                                children: <Widget>[
                                                  FlatButton(
                                                      onPressed: () {
                                                        CartesianasCS
                                                            cartesianasCS =
                                                            CartesianasCS();
                                                        cartesianasCS.NOMBRE =
                                                            listaOrigenes
                                                                .NOMBRE;
                                                        cartesianasCS.ESTE =
                                                            listaOrigenes.ESTE;
                                                        cartesianasCS.NORTE =
                                                            listaOrigenes.NORTE;
                                                        cartesianasCS
                                                                .PLANO_PROY =
                                                            listaOrigenes
                                                                .PLANO_PROY;
                                                        cartesianasCS.LATITUD =
                                                            listaOrigenes
                                                                .LATITUD;
                                                        cartesianasCS.LONGITUD =
                                                            listaOrigenes
                                                                .LONGITUD;
                                                        Navigator.pop(context);
                                                        setState(() {
                                                          origenCartesian =
                                                              cartesianasCS;
                                                          origenCartesiano =
                                                              true;
                                                        });
                                                      },
                                                      child: Column(
                                                        children: <Widget>[
                                                          Image.asset(
                                                            'assets/images/seleccionar.png',
                                                            height: 40,
                                                          ),
                                                          Text('Seleccionar',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .blueAccent,
                                                                  fontSize: 14))
                                                        ],
                                                      )),
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ));
                          });
                    } else {
                      return Swiper(
                          layout: SwiperLayout.DEFAULT,
                          pagination:
                              SwiperPagination(builder: SwiperPagination.dots),
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            origenesCartesianos listaOrigenes =
                                snapshot.data[index];
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
                                          image: DecorationImage(
                                            image: AssetImage(
                                                'assets/images/fondo_sistemas.png'),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Column(
                                            children: <Widget>[
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: RichText(
                                                    text: TextSpan(children: <
                                                        TextSpan>[
                                                  TextSpan(
                                                      text: 'Plano Cartesiano',
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          color: Colors.white,
                                                          fontSize: 14.0)),
                                                ])),
                                              ),
                                              Align(
                                                alignment: Alignment.bottomLeft,
                                                child: Text(
                                                  '${listaOrigenes.NOMBRE}',
                                                  style: TextStyle(
                                                      fontFamily: 'Roboto',
                                                      color: Colors.white,
                                                      fontSize: 14.0),
                                                ),
                                              ),
                                              SizedBox(height: 45.0),
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: RichText(
                                                    text: TextSpan(children: <
                                                        TextSpan>[
                                                  TextSpan(
                                                      text: 'DATUM \n',
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          color: Colors.black54,
                                                          fontSize: 12.0)),
                                                  TextSpan(
                                                      text:
                                                          'Magna Sirgas        ',
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          color:
                                                              Color(0xff007FFF),
                                                          fontSize: 13.0))
                                                ])),
                                              ),
                                              Divider(),
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: RichText(
                                                    text: TextSpan(children: <
                                                        TextSpan>[
                                                  TextSpan(
                                                      text: 'Elipsoide\n',
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          color: Colors.black54,
                                                          fontSize: 12.0)),
                                                  TextSpan(
                                                      text: 'GRS80        ',
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          color:
                                                              Color(0xff007FFF),
                                                          fontSize: 13.0))
                                                ])),
                                              ),
                                              Divider(),
                                              Align(
                                                alignment: Alignment.center,
                                                child: RichText(
                                                    text: TextSpan(children: <
                                                        TextSpan>[
                                                  TextSpan(
                                                      text:
                                                          '      Sistema de Proyección ',
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          color:
                                                              Color(0xff007FFF),
                                                          fontSize: 13.0)),
                                                ])),
                                              ),
                                              Divider(),
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: RichText(
                                                    text: TextSpan(children: <
                                                        TextSpan>[
                                                  TextSpan(
                                                      text: 'Proyección\n',
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          color: Colors.black54,
                                                          fontSize: 12.0)),
                                                  TextSpan(
                                                      text:
                                                          'Plano Cartesiano IGAC',
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          color:
                                                              Color(0xff007FFF),
                                                          fontSize: 13.0))
                                                ])),
                                              ),
                                              Divider(),
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: RichText(
                                                    text: TextSpan(children: <
                                                        TextSpan>[
                                                  TextSpan(
                                                      text:
                                                          'Latitud de Origen\n',
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          color: Colors.black54,
                                                          fontSize: 12.0)),
                                                  TextSpan(
                                                      text:
                                                          '${listaOrigenes.LATITUD.toString()}',
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          color:
                                                              Color(0xff007FFF),
                                                          fontSize: 13.0))
                                                ])),
                                              ),
                                              Divider(),
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: RichText(
                                                    text: TextSpan(children: <
                                                        TextSpan>[
                                                  TextSpan(
                                                      text:
                                                          'Longitud de Origen\n',
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          color: Colors.black54,
                                                          fontSize: 12.0)),
                                                  TextSpan(
                                                      text:
                                                          '${listaOrigenes.LONGITUD.toString()}',
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          color:
                                                              Color(0xff007FFF),
                                                          fontSize: 13.0))
                                                ])),
                                              ),
                                              Divider(),
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: RichText(
                                                    text: TextSpan(children: <
                                                        TextSpan>[
                                                  TextSpan(
                                                      text: 'Falso Norte\n',
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          color: Colors.black54,
                                                          fontSize: 12.0)),
                                                  TextSpan(
                                                      text:
                                                          '${listaOrigenes.NORTE.toString()} m',
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          color:
                                                              Color(0xff007FFF),
                                                          fontSize: 13.0))
                                                ])),
                                              ),
                                              Divider(),
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: RichText(
                                                    text: TextSpan(children: <
                                                        TextSpan>[
                                                  TextSpan(
                                                      text: 'Falso Este\n',
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          color: Colors.black54,
                                                          fontSize: 12.0)),
                                                  TextSpan(
                                                      text:
                                                          '${listaOrigenes.ESTE.toString()} m',
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          color:
                                                              Color(0xff007FFF),
                                                          fontSize: 13.0))
                                                ])),
                                              ),
                                              Divider(),
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: RichText(
                                                    text: TextSpan(children: <
                                                        TextSpan>[
                                                  TextSpan(
                                                      text:
                                                          'Altura del Plano\n',
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          color: Colors.black54,
                                                          fontSize: 12.0)),
                                                  TextSpan(
                                                      text:
                                                          '${listaOrigenes.PLANO_PROY} m',
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          color:
                                                              Color(0xff007FFF),
                                                          fontSize: 13.0))
                                                ])),
                                              ),
                                              Divider(),
                                              Align(
                                                alignment: Alignment.center,
                                                child: Center(
                                                  child: Column(
                                                    children: <Widget>[
                                                      FlatButton(
                                                          onPressed: () {
                                                            CartesianasCS
                                                                cartesianasCS =
                                                                CartesianasCS();
                                                            cartesianasCS
                                                                    .NOMBRE =
                                                                listaOrigenes
                                                                    .NOMBRE;
                                                            cartesianasCS.ESTE =
                                                                listaOrigenes
                                                                    .ESTE;
                                                            cartesianasCS
                                                                    .NORTE =
                                                                listaOrigenes
                                                                    .NORTE;
                                                            cartesianasCS
                                                                    .PLANO_PROY =
                                                                listaOrigenes
                                                                    .PLANO_PROY;
                                                            cartesianasCS
                                                                    .LATITUD =
                                                                listaOrigenes
                                                                    .LATITUD;
                                                            cartesianasCS
                                                                    .LONGITUD =
                                                                listaOrigenes
                                                                    .LONGITUD;
                                                            Navigator.pop(
                                                                context);
                                                            setState(() {
                                                              origenCartesian =
                                                                  cartesianasCS;
                                                              origenCartesiano =
                                                                  true;
                                                            });
                                                          },
                                                          child: Column(
                                                            children: <Widget>[
                                                              Image.asset(
                                                                'assets/images/seleccionar.png',
                                                                height: 40,
                                                              ),
                                                              Text(
                                                                  'Seleccionar',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .blueAccent,
                                                                      fontSize:
                                                                          14))
                                                            ],
                                                          )),
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
                          });
                    }
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ));
  }
}
