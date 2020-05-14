import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:measurebookapp/pages/conversionCoordenadas/configuracionArchivoImportado.dart';
import 'package:measurebookapp/pages/conversionCoordenadas/conversionPuntoIndividual.dart';
import 'package:measurebookapp/pages/descripcionSC.dart';
import 'package:csv/csv.dart';
import 'package:flutter/services.dart' show rootBundle;


 class CoversionCoordenadas extends StatefulWidget {
   final String nombreProyecto, proyeccionMB, idUser, idProyeccion;
   const CoversionCoordenadas({Key key, this.nombreProyecto, this.proyeccionMB, this.idUser, this.idProyeccion}) : super(key: key);

  @override
  _CoversionCoordenadasState createState() => _CoversionCoordenadasState();
}

class _CoversionCoordenadasState extends State<CoversionCoordenadas> {
  bool check = true;
  bool csvload = false;
  List<DescripcionSistemCoor> listSistemasOrigenPI = List<DescripcionSistemCoor>(4);
  List<DescripcionSistemCoor> listSistemasDestinoPI = List<DescripcionSistemCoor>(4);
  List<DescripcionSistemCoor> listSistemasOrigenArc = List<DescripcionSistemCoor>(4);
  List<DescripcionSistemCoor> listSistemasDestinoArc = List<DescripcionSistemCoor>(4);
  List<DescripcionSistemCoor> listSistemasDestinoPR = List<DescripcionSistemCoor>(4);
   String tipoConversion;
   String sistemaOrigenPI = 'Elipsoidales';
   String sistemadestinoPI = 'Elipsoidales';
   String sistemaOrigenArc = 'Elipsoidales';
   String sistemadestinoArc = 'Elipsoidales';
   String sistemadestinoRef = 'Elipsoidales';
   @override
   Widget build(BuildContext context) {
     return Scaffold(
       body: SafeArea(
         child:  SingleChildScrollView(
            child: Padding(
             padding: const EdgeInsets.all(18.0),
             child: Center(
               child: Column(
                 children: <Widget>[
                   Image.asset('assets/images/conversion.png',height: 80.0),
                   SizedBox(height: 10),
                   RichText(text: TextSpan(
                    children: <TextSpan> [
                      TextSpan(text: 'Conversion de coordenadas ', style: TextStyle(
                      fontFamily: 'Roboto', 
                      fontSize: 13.0,
                      color: Color(0xff007FFF),
                      )),
                      TextSpan(text: 'Convierte tus coordenadas entre los sistemas de coordenadas Elipsoidales, Geocéntricas, Gauss Krüger o Planas Cartesianas', style: TextStyle(
                      fontFamily: 'Roboto', 
                      fontSize: 13.0,
                      color: Colors.black54,
                      )),
                    ]
                  )),
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
                           color: Colors.black54
                         )
                       ]
                     ),
                     child: Column(
                       children: <Widget>[
                         SizedBox(height: 20),
                         Text('Conversión Punto Individual', textAlign: TextAlign.center,style: TextStyle(color: Colors.blueAccent, fontSize: 14)),
                         Padding(
                           padding: const EdgeInsets.all(10.0),
                           child: Text('Convierte las coordenadas de un punto entre los sistemas de Coordenadas Planas Cartesianas, Gauss Krüger, Geocéntricas y Elipsoidales que se encuentren en el Datum MAGNA SIRGAS',style: TextStyle(
                             color: Colors.black54,
                             fontSize: 12,
                           ),),
                         ),
                         Row(
                           children: <Widget>[
                             Container(
                               height: 280,
                               width: MediaQuery.of(context).size.width/2-20,
                               child: Swiper(
                                 onIndexChanged: (int index){
                                   sistemaOrigenPI = listSistemasOrigenPI[index].nombreProyeccion;
                                 },
                                 control: SwiperControl(
                                   size: 15
                                 ),
                                 pagination: SwiperPagination(
                                   builder: SwiperPagination.dots
                                 ),
                                 itemCount: 4,
                                 loop: false,
                                 layout: SwiperLayout.DEFAULT,
                                itemHeight: 200,
                                itemWidth: MediaQuery.of(context).size.width/2,
                                itemBuilder: (BuildContext context, int index) {
                                  DescripcionSistemCoor elipsoidal = DescripcionSistemCoor(
                                  nombreProyeccion: 'Elipsoidales',
                                  imagen: 'assets/images/elipsoidal.png'
                                    );
                                DescripcionSistemCoor geocentrico = DescripcionSistemCoor(
                                  nombreProyeccion: 'Geocentricas',
                                  imagen: 'assets/images/geocentrica.png',
                                    );
                                DescripcionSistemCoor planas_Gauss = DescripcionSistemCoor(
                                  nombreProyeccion: 'Gauss - Krüger',
                                  imagen: 'assets/images/gauss.png',
                                  );
                                DescripcionSistemCoor planas_Cartesianas = DescripcionSistemCoor(
                                  nombreProyeccion: 'Planas Cartesianas',
                                  imagen: 'assets/images/cartesiana.png'
                                    );
                                      listSistemasOrigenPI[0] = elipsoidal;
                                      listSistemasOrigenPI[1] = geocentrico;
                                      listSistemasOrigenPI[2] = planas_Gauss;
                                      listSistemasOrigenPI[3] = planas_Cartesianas;
                                    DescripcionSistemCoor a = listSistemasOrigenPI[index];
                                      
                                return Container(
                                  width: 150,
                                  height: 210,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Column(
                                    children: <Widget>[
                                      Center(
                                        child: Text('Sistema Partida', style: TextStyle(
                                        fontSize: 12.0,
                                        color: Colors.black54,
                                      ),),
                                      ),
                                      Divider(),
                                      Center(
                                      child: Text(a.nombreProyeccion, style: TextStyle(
                                        fontSize: 12.0,
                                        color: Colors.blueAccent,
                                        
                                      ),),
                                    ),
                                    SizedBox(height: 60.0),
                                    Image.asset(a.imagen,height: 160)
                                    ],
                                  ),
                                );
                                }, 
                               ),
                             ),
                             Container(
                               height: 280,
                               width: MediaQuery.of(context).size.width/2-20,
                               child: Swiper(
                                 onIndexChanged: (int index){
                                   sistemadestinoPI = listSistemasDestinoPI[index].nombreProyeccion;
                                 },
                                 control: SwiperControl(
                                   size: 15
                                 ),
                                 loop: false,
                                 itemCount: 4,
                                 pagination: SwiperPagination(
                                   builder: SwiperPagination.dots
                                 ),
                                 layout: SwiperLayout.DEFAULT,
                                itemHeight: 200,
                                itemWidth: MediaQuery.of(context).size.width/2,
                                itemBuilder: (BuildContext context, int index) {
                                  DescripcionSistemCoor elipsoidal = DescripcionSistemCoor(
                                  nombreProyeccion: 'Elipsoidales',
                                  imagen: 'assets/images/elipsoidal.png'
                                    );
                                DescripcionSistemCoor geocentrico = DescripcionSistemCoor(
                                  nombreProyeccion: 'Geocentricas',
                                  imagen: 'assets/images/geocentrica.png',
                                    );
                                DescripcionSistemCoor planas_Gauss = DescripcionSistemCoor(
                                  nombreProyeccion: 'Gauss - Krüger',
                                  imagen: 'assets/images/gauss.png',
                                  );
                                DescripcionSistemCoor planas_Cartesianas = DescripcionSistemCoor(
                                  nombreProyeccion: 'Planas Cartesianas',
                                  imagen: 'assets/images/cartesiana.png'
                                    );
                                    listSistemasDestinoPI[0] = elipsoidal;
                                    listSistemasDestinoPI[1] = geocentrico;
                                    listSistemasDestinoPI[2] = planas_Gauss;
                                    listSistemasDestinoPI[3] = planas_Cartesianas;
                                    DescripcionSistemCoor a = listSistemasDestinoPI[index];
                                      
                                return Container(
                                  width: 150,
                                  height: 200,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Column(
                                    children: <Widget>[
                                      Center(
                                        child: Text('Sistema Destino', style: TextStyle(
                                        fontSize: 12.0,
                                        color: Colors.black54,
                                      ),),
                                      ),
                                      Divider(),
                                      Center(
                                      child: Text(a.nombreProyeccion, style: TextStyle(
                                        fontSize: 12.0,
                                        color: Colors.blueAccent,
                                      ),),
                                    ),
                                    SizedBox(height: 60.0),
                                    Image.asset(a.imagen,height: 160),
                                    ],
                                  ),
                                );
                                }, 
                               ),
                             )
                           ],
                         ),
                         FlatButton(
                           onPressed: (){
                              Navigator.push(context, new MaterialPageRoute(
                              builder: (context) => new ConversionPuntoIndividual(
                              destino: sistemadestinoPI,
                              origen: sistemaOrigenPI,
                              )));
                            }, 
                           child: Column(
                          children: <Widget>[
                          Image.asset('assets/images/seleccionar.png', height: 40,),
                          Text('Seleccionar',style: TextStyle(color: Colors.blueAccent, fontSize: 14))
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
                           color: Colors.black54
                         )
                       ]
                     ),
                     child: Column(
                       children: <Widget>[
                         SizedBox(height: 20),
                         Text('Conversión Archivo', textAlign: TextAlign.center,style: TextStyle(color: Colors.blueAccent, fontSize: 14)),
                         Padding(
                           padding: const EdgeInsets.all(10.0),
                           child: Text('Convierte las coordenadas desde un archivo CSV a los sistemas de Coordenadas Planas Cartesianas, Gauss Krüger, Geocéntricas y Elipsoidales que se encuentren en el Datum MAGNA SIRGAS',style: TextStyle(
                             color: Colors.black54,
                             fontSize: 12,
                           ),),
                         ),
                         Row(
                           children: <Widget>[
                             Container(
                               height: 280,
                               width: MediaQuery.of(context).size.width/2-20,
                               child: Swiper(
                                 onIndexChanged: (int index){
                                   sistemaOrigenArc = listSistemasOrigenArc[index].nombreProyeccion;
                                 },
                                 control: SwiperControl(
                                   size: 15
                                 ),
                                 pagination: SwiperPagination(
                                   builder: SwiperPagination.dots
                                 ),
                                 itemCount: 4,
                                 loop: false,
                                 layout: SwiperLayout.DEFAULT,
                                itemHeight: 200,
                                itemWidth: MediaQuery.of(context).size.width/2,
                                itemBuilder: (BuildContext context, int index) {
                                  DescripcionSistemCoor elipsoidal = DescripcionSistemCoor(
                                  nombreProyeccion: 'Elipsoidales',
                                  imagen: 'assets/images/elipsoidal.png'
                                    );
                                DescripcionSistemCoor geocentrico = DescripcionSistemCoor(
                                  nombreProyeccion: 'Geocentricas',
                                  imagen: 'assets/images/geocentrica.png',
                                    );
                                DescripcionSistemCoor planas_Gauss = DescripcionSistemCoor(
                                  nombreProyeccion: 'Gauss - Krüger',
                                  imagen: 'assets/images/gauss.png',
                                  );
                                DescripcionSistemCoor planas_Cartesianas = DescripcionSistemCoor(
                                  nombreProyeccion: 'Planas Cartesianas',
                                  imagen: 'assets/images/cartesiana.png'
                                    );
                                    listSistemasOrigenArc[0] = elipsoidal;
                                    listSistemasOrigenArc[1] = geocentrico;
                                    listSistemasOrigenArc[2] = planas_Gauss;
                                    listSistemasOrigenArc[3] = planas_Cartesianas;
                                    DescripcionSistemCoor a = listSistemasOrigenArc[index];
                                return Container(
                                  width: 150,
                                  height: 200,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Column(
                                    children: <Widget>[
                                      Center(
                                        child: Text('Sistema Partida', style: TextStyle(
                                        fontSize: 12.0,
                                        color: Colors.black54,
                                      ),),
                                      ),
                                      Divider(),
                                      Center(
                                      child: Text(a.nombreProyeccion, style: TextStyle(
                                        fontSize: 12.0,
                                        color: Colors.blueAccent,
                                        
                                      ),),
                                    ),
                                    SizedBox(height: 60.0),
                                    Image.asset(a.imagen,height: 160)
                                    ],
                                  ),
                                );
                                }, 
                               ),
                             ),
                             Container(
                               height: 280,
                               width: MediaQuery.of(context).size.width/2-20,
                               child: Swiper(
                                 onIndexChanged: (int index){
                                   sistemadestinoArc = listSistemasDestinoArc[index].nombreProyeccion;
                                 },
                                 control: SwiperControl(
                                   size: 15
                                 ),
                                 loop: false,
                                 itemCount: 4,
                                 pagination: SwiperPagination(
                                   builder: SwiperPagination.dots
                                 ),
                                 layout: SwiperLayout.DEFAULT,
                                itemHeight: 200,
                                itemWidth: MediaQuery.of(context).size.width/2,
                                itemBuilder: (BuildContext context, int index) {
                                  DescripcionSistemCoor elipsoidal = DescripcionSistemCoor(
                                  nombreProyeccion: 'Elipsoidales',
                                  imagen: 'assets/images/elipsoidal.png'
                                    );
                                DescripcionSistemCoor geocentrico = DescripcionSistemCoor(
                                  nombreProyeccion: 'Geocentricas',
                                  imagen: 'assets/images/geocentrica.png',
                                    );
                                DescripcionSistemCoor planas_Gauss = DescripcionSistemCoor(
                                  nombreProyeccion: 'Gauss - Krüger',
                                  imagen: 'assets/images/gauss.png',
                                  );
                                DescripcionSistemCoor planas_Cartesianas = DescripcionSistemCoor(
                                  nombreProyeccion: 'Planas Cartesianas',
                                  imagen: 'assets/images/cartesiana.png'
                                    );
                                    listSistemasDestinoArc[0] = elipsoidal;
                                    listSistemasDestinoArc[1] = geocentrico;
                                    listSistemasDestinoArc[2] = planas_Gauss;
                                    listSistemasDestinoArc[3] = planas_Cartesianas;
                                    DescripcionSistemCoor a = listSistemasDestinoArc[index];
                                return Container(
                                  width: 150,
                                  height: 200,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Column(
                                    children: <Widget>[
                                      Center(
                                        child: Text('Sistema Destino', style: TextStyle(
                                        fontSize: 12.0,
                                        color: Colors.black54,
                                      ),),
                                      ),
                                      Divider(),
                                      Center(
                                      child: Text(a.nombreProyeccion, style: TextStyle(
                                        fontSize: 12.0,
                                        color: Colors.blueAccent,
                                      ),),
                                    ),
                                    SizedBox(height: 60.0),
                                    Image.asset(a.imagen,height: 160),
                                    
                                    ],
                                  ),
                                );
                                }, 
                               ),
                             )
                           ],
                         ),
                         FlatButton(
                           onPressed: (){
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
                                    Text('Conversión de coordendas por Archivo', textAlign: TextAlign.center, style: TextStyle(color: Colors.blueAccent, fontSize: 13)),
                                    Divider(),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text('Sistema de Coordenadas Origen', style: TextStyle(color: Colors.black54, fontSize: 12)),
                                    ),
                                    Divider(),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text('${sistemaOrigenArc}', style: TextStyle(color: Colors.blueAccent, fontSize: 13)),
                                    ),
                                    Divider(),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text('Sistema de Coordenadas Destino', style: TextStyle(color: Colors.black54, fontSize: 12)),
                                    ),
                                    Divider(),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text('${sistemadestinoArc}', style: TextStyle(color: Colors.blueAccent, fontSize: 13)),
                                    ),
                                    Container(
                                      height: 120,
                                      width: 250,
                                      child:Container(
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: FlatButton(onPressed: ()async{
                                              String pathCsv = await FilePicker.getFilePath(type: FileType.custom, allowedExtensions: ['csv']); 
                                                String datosCSV = await rootBundle.loadString(pathCsv);
                                                List<List<dynamic>> listaDatosCSV = CsvToListConverter().convert(datosCSV);
                                                if (datosCSV != null){
                                                  setState(() {
                                                  csvload = true;
                                                });
                                                Navigator.push(context, new MaterialPageRoute(
                                                builder: (context) => new ConfiguracionArchivoImportado(
                                                destinoCS: sistemadestinoArc,
                                                origenCS: sistemaOrigenArc,
                                                dataCSV: listaDatosCSV,
                                                )));
                                                Navigator.of(context, rootNavigator: true).pop('dialog');
                                                }
                                            }, 
                                            child: Column(
                                              children: <Widget>[
                                                Image.asset('assets/images/csv_unload.png', height: 80,),
                                                Text('Seleccione el archico CSV con coordenadas ${sistemaOrigenArc}',textAlign: TextAlign.center, style: TextStyle(color: Colors.black54, fontSize: 13)),
                                              ],
                                            ),
                                            )
                                          ),
                                        ),
                                      )
                                    )
                                  ],
                                ),
                              ),
                            ),
                             );
                             showDialog(context: context, barrierDismissible: true, builder: (BuildContext context){
                              return conversionArchivoCSV;
                            });
                           }, 
                           child: Column(
                          children: <Widget>[
                          Image.asset('assets/images/seleccionar.png', height: 20,),
                          Text('Seleccionar',style: TextStyle(color: Colors.blueAccent, fontSize: 14))
                          ],
                         ))
                       ],
                     ),
                  ),
                  SizedBox(height: 25),
                  //Convertir Puntos REF
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
                           color: Colors.black54
                         )
                       ]
                     ),
                     child: Column(
                       children: <Widget>[
                         SizedBox(height: 20),
                         Text('Conversión Puntos de Referencia', textAlign: TextAlign.center,style: TextStyle(color: Colors.blueAccent, fontSize: 14)),
                         Padding(
                           padding: const EdgeInsets.all(10.0),
                           child: Text('Convierte las coordenadas de tus puntos de referencia almacenados dentro del proyecto a los sistemas de Coordenadas Planas Cartesianas, Gauss Krüger, Geocéntricas y Elipsoidales que se encuentren en el Datum MAGNA SIRGAS',style: TextStyle(
                             color: Colors.black54,
                             fontSize: 12,
                           ),),
                         ),
                             Container(
                               height: 280,
                               width: MediaQuery.of(context).size.width/2-20,
                               child: Swiper(
                                 onIndexChanged: (int index){
                                   sistemadestinoRef = listSistemasDestinoPR[index].nombreProyeccion;
                                 },
                                 control: SwiperControl(
                                   size: 15
                                 ),
                                 pagination: SwiperPagination(
                                   builder: SwiperPagination.dots
                                 ),
                                 itemCount: 4,
                                 loop: false,
                                 layout: SwiperLayout.DEFAULT,
                                itemHeight: 200,
                                itemWidth: MediaQuery.of(context).size.width/2,
                                itemBuilder: (BuildContext context, int index) {
                                  DescripcionSistemCoor elipsoidal = DescripcionSistemCoor(
                                  nombreProyeccion: 'Elipsoidales',
                                  imagen: 'assets/images/elipsoidal.png'
                                    );
                                DescripcionSistemCoor geocentrico = DescripcionSistemCoor(
                                  nombreProyeccion: 'Geocentricas',
                                  imagen: 'assets/images/geocentrica.png',
                                    );
                                DescripcionSistemCoor planas_Gauss = DescripcionSistemCoor(
                                  nombreProyeccion: 'Gauss - Krüger',
                                  imagen: 'assets/images/gauss.png',
                                  );
                                DescripcionSistemCoor planas_Cartesianas = DescripcionSistemCoor(
                                  nombreProyeccion: 'Planas Cartesianas',
                                  imagen: 'assets/images/cartesiana.png'
                                    );
                                    listSistemasDestinoPR[0] = elipsoidal;
                                    listSistemasDestinoPR[1] = geocentrico;
                                    listSistemasDestinoPR[2] = planas_Gauss;
                                    listSistemasDestinoPR[3] = planas_Cartesianas;
                                    DescripcionSistemCoor a = listSistemasDestinoPR[index];
                                return Container(
                                  width: 150,
                                  height: 200,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Column(
                                    children: <Widget>[
                                      Center(
                                        child: Text('Sistema Destino', style: TextStyle(
                                        fontSize: 12.0,
                                        color: Colors.black54,
                                      ),),
                                      ),
                                      Divider(),
                                      Center(
                                      child: Text(a.nombreProyeccion, style: TextStyle(
                                        fontSize: 12.0,
                                        color: Colors.blueAccent,
                                        
                                      ),),
                                    ),
                                    SizedBox(height: 60.0),
                                    Image.asset(a.imagen,height: 160)
                                    ],
                                  ),
                                );
                                }, 
                               ),
                             ),
                         FlatButton(
                           onPressed: (){
                              print(
                                sistemadestinoRef
                              );
                           }, 
                           child: Column(
                          children: <Widget>[
                          Image.asset('assets/images/seleccionar.png', height: 40,),
                          Text('Seleccionar',style: TextStyle(color: Colors.blueAccent, fontSize: 14))
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

   // Cargar CSV  Función

   
}

