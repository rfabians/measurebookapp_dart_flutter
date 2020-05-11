import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:measurebookapp/pages/conversionCoordenadas/conversionPuntoIndividual.dart';
import 'package:measurebookapp/pages/descripcionSC.dart';


 class CoversionCoordenadas extends StatefulWidget {
   final String nombreProyecto, proyeccionMB, idUser, idProyeccion;
   const CoversionCoordenadas({Key key, this.nombreProyecto, this.proyeccionMB, this.idUser, this.idProyeccion}) : super(key: key);

  @override
  _CoversionCoordenadasState createState() => _CoversionCoordenadasState();
}

class _CoversionCoordenadasState extends State<CoversionCoordenadas> {
   String tipoConversion, sistemaOrigenPI, sistemadestinoPI,sistemaOrigenArc, sistemadestinoArc, sistemadestinoRef;
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
                      TextSpan(text: 'Convierte tus coordenadas entre los sistemas de coordenadas Elipsoidales, Geocentricas, Gauss Krüger o Planas Cartesianas', style: TextStyle(
                      fontFamily: 'Roboto', 
                      fontSize: 13.0,
                      color: Colors.black54,
                      )),
                    ]
                  )),
                  SizedBox(height: 25),
                  //Convertir Punto Individual
                  Container(
                     height: 430,
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
                           child: Text('Convierte las coordenadas de un punto entre los sistemas de Coordenadas Planas Cartesianas, Gauss Krüger, Geocentricas y Elipsoidales que se encuentren en el Datum MAGNA SIRGAS',style: TextStyle(
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
                                    List<DescripcionSistemCoor> listSistemas = List<DescripcionSistemCoor>(4);
                                    listSistemas[0] = elipsoidal;
                                    listSistemas[1] = geocentrico;
                                    listSistemas[2] = planas_Gauss;
                                    listSistemas[3] = planas_Cartesianas;
                                    DescripcionSistemCoor a = listSistemas[index];
                                      sistemaOrigenPI = a.nombreProyeccion;
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
                                    List<DescripcionSistemCoor> listSistemas = List<DescripcionSistemCoor>(4);
                                    listSistemas[0] = elipsoidal;
                                    listSistemas[1] = geocentrico;
                                    listSistemas[2] = planas_Gauss;
                                    listSistemas[3] = planas_Cartesianas;
                                    DescripcionSistemCoor a = listSistemas[index];
                                      sistemadestinoPI = a.nombreProyeccion;
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
                             )
                           ],
                         ),
                         FlatButton(
                           onPressed: (){
                              Navigator.push(context, MaterialPageRoute(
                              builder: (context) => ConversionPuntoIndividual(
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
                     height: 430,
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
                           child: Text('Convierte las coordenadas desde un archivo CSV a los sistemas de Coordenadas Planas Cartesianas, Gauss Krüger, Geocentricas y Elipsoidales que se encuentren en el Datum MAGNA SIRGAS',style: TextStyle(
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
                                    List<DescripcionSistemCoor> listSistemas = List<DescripcionSistemCoor>(4);
                                    listSistemas[0] = elipsoidal;
                                    listSistemas[1] = geocentrico;
                                    listSistemas[2] = planas_Gauss;
                                    listSistemas[3] = planas_Cartesianas;
                                    DescripcionSistemCoor a = listSistemas[index];
                                      sistemaOrigenArc = a.nombreProyeccion;
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
                                    List<DescripcionSistemCoor> listSistemas = List<DescripcionSistemCoor>(4);
                                    listSistemas[0] = elipsoidal;
                                    listSistemas[1] = geocentrico;
                                    listSistemas[2] = planas_Gauss;
                                    listSistemas[3] = planas_Cartesianas;
                                    DescripcionSistemCoor a = listSistemas[index];
                                      sistemadestinoArc = a.nombreProyeccion;
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
                  //Convertir Puntos REF
                  Container(
                     height: 430,
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
                           child: Text('Convierte las coordenadas de tus puntos de referencia almacenados dentro del proyecto a los sistemas de Coordenadas Planas Cartesianas, Gauss Krüger, Geocentricas y Elipsoidales que se encuentren en el Datum MAGNA SIRGAS',style: TextStyle(
                             color: Colors.black54,
                             fontSize: 12,
                           ),),
                         ),
                             Container(
                               height: 280,
                               width: MediaQuery.of(context).size.width/2-20,
                               child: Swiper(
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
                                    List<DescripcionSistemCoor> listSistemas = List<DescripcionSistemCoor>(4);
                                    listSistemas[0] = elipsoidal;
                                    listSistemas[1] = geocentrico;
                                    listSistemas[2] = planas_Gauss;
                                    listSistemas[3] = planas_Cartesianas;
                                    DescripcionSistemCoor a = listSistemas[index];
                                      sistemadestinoRef = a.nombreProyeccion;
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
}