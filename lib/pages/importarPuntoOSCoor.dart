import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:measurebookapp/clases/conversionCoordenadasMB.dart';
import 'package:measurebookapp/clases/database.dart';
import 'package:measurebookapp/modelos/cPlanasGenerico.dart';
import 'package:measurebookapp/modelos/cartesianasCS.dart';
import 'package:measurebookapp/modelos/coordenadasCartesianas.dart';
import 'package:measurebookapp/modelos/coordenadasElipsoidales.dart';
import 'package:measurebookapp/modelos/coordenadasPlanasGauss.dart';
import 'package:measurebookapp/modelos/gaussCS.dart';
import 'package:measurebookapp/pages/conversionPunto.dart';
import 'package:measurebookapp/pages/descripcionSC.dart';
import 'dart:math' as m;


class ImportarPuntoOSCoor extends StatefulWidget {
  final String idusuario, idProyeccion, idProyecto, proyeccion; 
  ImportarPuntoOSCoor({Key key, this.proyeccion, this.idusuario, this.idProyecto, this.idProyeccion}) : super(key: key);

  @override
  _ImportarPuntoOSCoorState createState() => _ImportarPuntoOSCoorState();
  List<DescripcionSistemCoor> sistemasCoordenadas = List<DescripcionSistemCoor>(4);


}

class _ImportarPuntoOSCoorState extends State<ImportarPuntoOSCoor> {
   Future<CPlanasGenerico>  coordenadasInportadas (double latitud, double longitud, double alturaPunto) async {
  if (widget.proyeccion == 'Gauss-Krüger')  {
    GaussCS gaussCS = await gestorMBDatabase.db.getOrigenGaussData(widget.idProyeccion);
    CoordenadasElipsoidales coordenadasElipsoidales = CoordenadasElipsoidales();
    coordenadasElipsoidales.latitud = latitud;
    coordenadasElipsoidales.longitud = longitud;
    coordenadasElipsoidales.altitud = alturaPunto;
    ConversionCoordenadasMB conversionCoordenadasMB = ConversionCoordenadasMB();
    CoordenadasGauss coordenadasGauss = CoordenadasGauss();
    coordenadasGauss = conversionCoordenadasMB.elipsoidales2Gauss(coordenadasElipsoidales,gaussCS);
    CPlanasGenerico cPlanasGenerico = CPlanasGenerico();
    cPlanasGenerico.norte = coordenadasGauss.norte;
    cPlanasGenerico.este = coordenadasGauss.este;
    cPlanasGenerico.altura = alturaPunto;
    return cPlanasGenerico;
    
  }else {
    CartesianasCS cartesianasCS = await gestorMBDatabase.db.getOrigenCartesianoData(widget.idProyeccion);
    CoordenadasElipsoidales coordenadasElipsoidales = CoordenadasElipsoidales();
    coordenadasElipsoidales.latitud = latitud;
    coordenadasElipsoidales.longitud = longitud;
    coordenadasElipsoidales.altitud = alturaPunto;
    ConversionCoordenadasMB conversionCoordenadasMB = ConversionCoordenadasMB();
    CoordenadasCartesianas coordenadasCartesianas = conversionCoordenadasMB.elipsoidales2Cartesianas(cartesianasCS, coordenadasElipsoidales);
    CPlanasGenerico cPlanasGenerico = CPlanasGenerico();
    cPlanasGenerico.norte = coordenadasCartesianas.norte;
    cPlanasGenerico.este = coordenadasCartesianas.este;
    cPlanasGenerico.altura = alturaPunto;
    return cPlanasGenerico;
  }

   double roundDouble(double value, int places){ 
   double mod = m.pow(10.0, places); 
   return ((value * mod).round().toDouble() / mod); 
}}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: SafeArea(
         child: Center(
           child: Column(
             children: <Widget>[
               Padding(
                 padding: const EdgeInsets.all(10.0),
                 child: Image.asset('assets/images/conversion.png', height: 80.0),
               ),
               Padding(
                 padding: const EdgeInsets.all(10.0),
                 child: RichText(text: TextSpan(
                    children: <TextSpan> [
                    TextSpan(text: 'Seleccione el sistema de Coordenadas del punto a Importar', style: TextStyle(
                    fontFamily: 'Roboto', 
                    fontSize: 14.0,
                    color: Color(0xff007FFF),
                   )),
                  ]
              )),
               ),
               Divider(height: 30.0),
              Container(
                height: 550,
                width: 350,
                decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.5,0.9,1],
                  colors: [Colors.white, Colors.white70, Colors.white38]
                  ),
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black45,
                    blurRadius: 10.0,
                    offset: Offset(10.0, 10.0)
                  )
                ]
                ),
                child: Swiper(
                  pagination: SwiperPagination(
                    builder: SwiperPagination.dots
                  ),
                  itemCount: 4,
                  layout: SwiperLayout.DEFAULT,
                  itemHeight: 300.0,
                  itemWidth: 450.0,
                  itemBuilder: (BuildContext context, int index) {
                    DescripcionSistemCoor elipsoidal = DescripcionSistemCoor(
                        nombreProyeccion: 'Coordenadas Elipsoidales',
                        imagen: 'assets/images/elipsoidal.png'
                          );
                      DescripcionSistemCoor geocentrico = DescripcionSistemCoor(
                        nombreProyeccion: 'Coordenadas Geocentricas',
                        imagen: 'assets/images/geocentrica.png',
                          );
                      DescripcionSistemCoor planas_Gauss = DescripcionSistemCoor(
                        nombreProyeccion: 'Coordenadas Gauss - Krüger',
                        imagen: 'assets/images/gauss.png',
                         );
                      DescripcionSistemCoor planas_Cartesianas = DescripcionSistemCoor(
                        nombreProyeccion: 'Cooordenadas Planas Cartesianas',
                        imagen: 'assets/images/cartesiana.png'
                          );
                          List<DescripcionSistemCoor> listSistemas = List<DescripcionSistemCoor>(4);
                          listSistemas[0] = elipsoidal;
                          listSistemas[1] = geocentrico;
                          listSistemas[2] = planas_Gauss;
                          listSistemas[3] = planas_Cartesianas;

                          DescripcionSistemCoor a = listSistemas[index];

                          if (a.nombreProyeccion == 'Coordenadas Elipsoidales') {
                              return Center(
                                child: Container(
                                width: 300.0,
                                height: 480.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Column(
                                  children: <Widget>[
                                    Center(
                                      child: Text(a.nombreProyeccion, style: TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.blueAccent,
                                        
                                      ),),
                                    ),
                                    SizedBox(height: 60.0),
                                    Image.asset(a.imagen),
                                    SizedBox(height: 50.0),
                                    ListTile(
                                      title: Text('Sistema Decimal', style: TextStyle(color: Colors.blueAccent),),
                                      trailing: Icon(Icons.chevron_right, color: Colors.blueAccent, size: 30.0,),
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(
                                        builder: (context) => ConversionPunto(
                                          idProyeccion: widget.idProyeccion,
                                          idProyecto: widget.idProyecto,
                                          idusuario: widget.idusuario,
                                          proyeccion: widget.proyeccion,
                                          sistemaOrigen: a.nombreProyeccion,
                                        )));
                                      },
                                    ),
                                    ListTile(
                                        title:  Text('Sistema Hexadecimal', style: TextStyle(color: Colors.blueAccent),),
                                        trailing: Icon(Icons.chevron_right, color: Colors.blueAccent, size: 30,),
                                        onTap: (){
                                          Navigator.push(context, MaterialPageRoute(
                                          builder: (context) => ConversionPunto(
                                          idProyeccion: widget.idProyeccion,
                                          idProyecto: widget.idProyecto,
                                          idusuario: widget.idusuario,
                                          proyeccion: widget.proyeccion,
                                          sistemaOrigen: 'Hexa',
                                          )));
                                        },
                                      )
                                  ],
                                ),
                              )
                            );
                          } else {
                              return Center(
                                child: Container(
                                width: 300.0,
                                height: 480.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Column(
                                  children: <Widget>[
                                    Center(
                                      child: Text(a.nombreProyeccion, style: TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.blueAccent,
                                        
                                      ),),
                                    ),
                                    SizedBox(height: 60.0),
                                    Image.asset(a.imagen),
                                    SizedBox(height: 100.0),
                                    FlatButton(
                                      onPressed: (){
                                        Navigator.push(context, MaterialPageRoute(
                                        builder: (context) => ConversionPunto(
                                          idProyeccion: widget.idProyeccion,
                                          idProyecto: widget.idProyecto,
                                          idusuario: widget.idusuario,
                                          proyeccion: widget.proyeccion,
                                          sistemaOrigen: a.nombreProyeccion,
                                        )));
                                      }, 
                                      child: Icon(Icons.arrow_forward_ios, size: 30.0,color: Colors.blueAccent)
                                      )
                                  ],
                                ),
                              )
                            );
                          }
                  },
                  ),
              )
             ],
           ),
         )
         ),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }