import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:measurebookapp/clases/conversionCoordenadasMB.dart';
import 'package:measurebookapp/clases/database.dart';
import 'package:measurebookapp/modelos/cartesianasCS.dart';
import 'package:measurebookapp/modelos/coordenadasCartesianas.dart';
import 'package:measurebookapp/modelos/coordenadasElipsoidales.dart';
import 'package:measurebookapp/modelos/coordenadasGeocenticas.dart';
import 'package:measurebookapp/modelos/coordenadasON.dart';
import 'package:measurebookapp/modelos/coordenadasPlanasGauss.dart';
import 'package:measurebookapp/modelos/departamentos.dart';
import 'package:measurebookapp/modelos/gaussCS.dart';
import 'package:measurebookapp/modelos/municipios.dart';
import 'package:measurebookapp/modelos/origenesCartesianos.dart';
import 'package:measurebookapp/modelos/origenesGauss.dart';
import 'package:measurebookapp/pages/conversionPunto.dart';
import 'dart:math' as m;

import 'package:share/share.dart';

class ConversionPuntoIndividual extends StatefulWidget {
  final String origen,destino;
  ConversionPuntoIndividual({Key key, this.origen, this.destino}) : super(key: key);

  @override
  _ConversionPuntoIndividualState createState() => _ConversionPuntoIndividualState();
}

class _ConversionPuntoIndividualState extends State<ConversionPuntoIndividual> {
  bool hexadecimal = true;
  bool origenGauss = false;
  bool origenCartesiano = false;
  String valorNS = 'Norte';
  String valorEO = 'Oeste';
  double latitudepunto, longitudPunto, alturaPunto;
  double gradosLatitudF, minutosLatitudF, segundosLatitudF;
  double gradosLongitudF, minutosLongitudF, segundosLongitudF;
  double altura;
  double xGeocentricaF, yGeocentricaF, zGeocentricaF;
  double norteOn, esteOn, alturaOn;
  double norteCartesianas, esteCartesianas, alturaCartesianas;
  double norteGauss, esteGauss, alturaGauss;
  GaussCS gaussCOrigen = GaussCS();
  CartesianasCS origenCartesian =CartesianasCS();
  CoordenadasGauss coordenadasGaussForm = CoordenadasGauss();
  CoordenadasCartesianas coordenadasCartesianasForm = CoordenadasCartesianas();
  final GlobalKey<FormState> _formKeyElipsoidalHex = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKeyElipsoidalDec = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKeyGeocentricas = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKeyGauss = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKeyPlanasCartesianas = GlobalKey<FormState>();
  double roundDouble(double value, int places){ 
   double mod = m.pow(10.0, places); 
   return ((value * mod).round().toDouble() / mod); 
}
  
  @override
  Widget build(BuildContext context) {
    // Sistema de Coordenadas de Origen Elipsoidales
    if (widget.origen == 'Elipsoidales') {
      return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Center(
                        child: Column(
                        children: <Widget>[
                          SizedBox(height: 0),
                          Image.asset('assets/images/conversion.png',height: 80.0),
                          SizedBox(height: 10),
                          RichText(text: TextSpan(
                            children: <TextSpan> [
                              TextSpan(text: 'Conversion de coordenadas ', style: TextStyle(
                              fontFamily: 'Roboto', 
                              fontSize: 13.0,
                              color: Colors.black54,
                              )),
                              TextSpan(text: '${widget.origen} a ${widget.destino}', style: TextStyle(
                              fontFamily: 'Roboto', 
                              fontSize: 13.0,
                              color: Colors.blueAccent,
                              )),
                            ]
                          )),
                          SizedBox(height: 5.0),
                          Image.asset('assets/images/elipsoidal.png', height: 220,),
                          SizedBox(height: 15),
                          Divider(),
                          Text('Sistema Sexadecimal', style: TextStyle(color: Colors.blueAccent, fontSize: 13)),
                          CupertinoSwitch(
                            value: hexadecimal,
                            activeColor: Colors.blueAccent,
                            onChanged: (hexadecimalS){
                              setState(() {
                                hexadecimal = hexadecimalS;
                                print(hexadecimal);
                              });
                            },
                          ),
                          Divider(),
                          Container(
                            child: hexadecimal
                            ?
                            Form(
                              key: _formKeyElipsoidalHex,
                                child: Column(
                                children: <Widget>[
                                Text('Latitud', style: TextStyle(color: Colors.black54, fontSize: 13)),
                                Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          width: 45,
                                          child: Column(
                                            children: <Widget>[
                                              TextFormField(
                                                textAlign: TextAlign.center,
                                                inputFormatters: [WhitelistingTextInputFormatter(RegExp(r'^(-?[0-9]+([0-9]*)?|0-9]+)$'))],
                                                keyboardType: TextInputType.numberWithOptions(
                                                  decimal: false
                                                ),
                                                validator: (String graLatitud) {
                                                  double gradosLatitud = double.tryParse(graLatitud);
                                                  if(gradosLatitud == null){
                                                    return ' ';
                                                  }else {
                                                    if(gradosLatitud > -90 && gradosLatitud < 90) {
                                                      setState(() {
                                                        gradosLatitudF = gradosLatitud;
                                                      });
                                                      return null;
                                                    }else {
                                                      return ' ';
                                                    }
                                                  }
                                                },
                                              ),
                                              Text('Grados', style: TextStyle(fontSize: 12,color: Colors.blueAccent))
                                            ],
                                          )
                                        ),
                                        SizedBox(width: 15,),
                                        Container(
                                          width: 45,
                                          child: Column(
                                            children: <Widget>[
                                              TextFormField(
                                                textAlign: TextAlign.center,
                                                keyboardType: TextInputType.numberWithOptions(
                                                  decimal: false
                                                ),
                                                inputFormatters: [WhitelistingTextInputFormatter(RegExp(r'^(-?[0-9]+([0-9]*)?|0-9]+)$'))],
                                                validator: (String minLatitud){
                                                  double minutosLatitud = double.tryParse(minLatitud);
                                                  if (minutosLatitud == null) {
                                                    return ' ';
                                                  } else {
                                                    if(minutosLatitud>=0 && minutosLatitud < 60) {
                                                      setState(() {
                                                        minutosLatitudF = minutosLatitud;
                                                      });
                                                      return null;
                                                    } else {return ' ';} 
                                                  }
                                                },
                                              ),
                                              Text("Minutos", style: TextStyle(fontSize: 12,color: Colors.blueAccent))
                                            ],
                                          )
                                        ),
                                        SizedBox(width: 15,),
                                        Container(
                                          width: 100,
                                          child: Column(
                                            children: <Widget>[
                                              TextFormField(
                                                keyboardType: TextInputType.number,
                                                textAlign: TextAlign.center,
                                                inputFormatters: [WhitelistingTextInputFormatter(RegExp(r'^(-?[0-9]+([.][0-9]*)?|[.][0-9]+)$'))],
                                                validator: (String segLatitud){
                                                  double segundosLatitud = double.tryParse(segLatitud);
                                                  if(segundosLatitud == null) {
                                                    return ' ';
                                                  }else {
                                                    if (segundosLatitud>=0 && segundosLatitud<60) {
                                                      setState(() {
                                                        segundosLatitudF = segundosLatitud;
                                                      });
                                                      return null;
                                                    }else{return ' ';}
                                                  }
                                                },
                                              ),
                                              Text('Segundos', style: TextStyle(fontSize: 12,color: Colors.blueAccent)),
                                            ],
                                          )
                                        ),
                                      SizedBox(width: 15,),
                                        Container(
                                          width: 75,
                                          child: Column(
                                            children: <Widget>[
                                              DropdownButton<String> (
                                                hint: Text('Norte'),
                                                value: valorNS,
                                                elevation: 16,
                                                items: <String>['Norte', 'Sur'].map((String valorNS){
                                                  return DropdownMenuItem<String>(
                                                    value: valorNS,
                                                    child: Text(valorNS, ),
                                                  );
                                                }).toList(),
                                                onChanged: (String newValue){
                                                  setState(() {
                                                    valorNS = newValue;
                                                  });
                                                },
                                              ),
                                              Text('Hemisferio', style: TextStyle(fontSize: 12,color: Colors.blueAccent)),
                                            ],
                                          )
                                        ), 
                                      ],
                                    ),
                                  ),
                                Column(
                                  children: <Widget>[
                                    Divider(),
                                    Text('Longitud', style: TextStyle(color: Colors.black54, fontSize: 13),),
                                    Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                            width: 45,
                                            child: Column(
                                              children: <Widget>[
                                                TextFormField(
                                                  textAlign: TextAlign.center,
                                                  keyboardType: TextInputType.number,
                                                  inputFormatters: [WhitelistingTextInputFormatter(RegExp(r'^(-?[0-9]+([0-9]*)?|0-9]+)$'))],
                                                  validator: (String graLongitud){
                                                    double gradosLongitud = double.tryParse(graLongitud);
                                                    if(gradosLongitud == null) {
                                                      return ' ';
                                                    } else {
                                                      if(gradosLongitud>-180 && gradosLongitud<180){
                                                        setState(() {
                                                          gradosLongitudF = gradosLongitud;
                                                        });
                                                        return null;
                                                      }else {
                                                        return ' ';
                                                      }
                                                    }
                                                  },
                                                ),
                                                Text('Grados', style: TextStyle(fontSize: 12,color: Colors.blueAccent))
                                              ],
                                            )
                                          ),
                                          SizedBox(width: 15,),
                                          Container(
                                            width: 45,
                                            child: Column(
                                              children: <Widget>[
                                                TextFormField(
                                                  textAlign: TextAlign.center,
                                                  keyboardType: TextInputType.number,
                                                  inputFormatters: [WhitelistingTextInputFormatter(RegExp(r'^(-?[0-9]+([0-9]*)?|0-9]+)$'))],
                                                  validator: (String minLatitud) {
                                                    double minutosLongitud = double.tryParse(minLatitud);
                                                    if(minutosLongitud == null){
                                                      return ' ';
                                                    }else {
                                                      if(minutosLongitud>= 0 && minutosLongitud <60) {
                                                        setState(() {
                                                          minutosLongitudF = minutosLongitud;
                                                        });
                                                        return null;
                                                      } else { return ' ';}
                                                    }
                                                  },
                                                ),
                                                Text("Minutos", style: TextStyle(fontSize: 12,color: Colors.blueAccent))
                                              ],
                                            )
                                          ),
                                          SizedBox(width: 15,),
                                          Container(
                                            width: 100,
                                            child: Column(
                                              children: <Widget>[
                                                TextFormField(
                                                  textAlign: TextAlign.center,
                                                  keyboardType: TextInputType.number,
                                                  inputFormatters: [WhitelistingTextInputFormatter(RegExp(r'^(-?[0-9]+([.][0-9]*)?|[.][0-9]+)$'))],
                                                  validator: (String segLongitud){
                                                    double segundoLongitud = double.tryParse(segLongitud);
                                                    if(segundoLongitud == null) {
                                                      return ' ';
                                                    } else {
                                                      if(segundoLongitud >= 0 && segundoLongitud <60){
                                                        setState(() {
                                                          segundosLongitudF = segundoLongitud;
                                                        });
                                                        return null;
                                                      }else {return ' ';}
                                                    }
                                                  },
                                                ),
                                                Text('Segundos', style: TextStyle(fontSize: 12,color: Colors.blueAccent)),
                                              ],
                                            )
                                          ),
                                        SizedBox(width: 15,),
                                          Container(
                                            width: 75,
                                            child: Column(
                                              children: <Widget>[
                                                DropdownButton<String> (
                                                  hint: Text('Oeste'),
                                                  value: valorEO,
                                                  elevation: 16,
                                                  items: <String>['Oeste', 'Este'].map((String valorEO){
                                                    return DropdownMenuItem<String>(
                                                      value: valorEO,
                                                      child: Text(valorEO, ),
                                                    );
                                                  }).toList(),
                                                  onChanged: (String newValue){
                                                    setState(() {
                                                      valorEO = newValue;
                                                    });
                                                  },
                                                ),
                                                Text('Hemisferio', style: TextStyle(fontSize: 12,color: Colors.blueAccent)),
                                              ],
                                            )
                                          ), 
                                        ],
                                      ),
                                    ),
                                  ),
                                  ],
                                ),
                                Divider(),
                                Text('Altura', style: TextStyle(color: Colors.black54, fontSize: 13.0)),
                                Container(
                                  width: 100,
                                  child: TextFormField(
                                    inputFormatters: [WhitelistingTextInputFormatter(RegExp(r'^(-?[0-9]+([.][0-9]*)?|[.][0-9]+)$'))],
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    validator: (String alturaPunto) {
                                      double altPunto = double.tryParse(alturaPunto);
                                      if(altPunto == null) {
                                        return ' ';
                                      }else {
                                        setState(() {
                                          altura = altPunto;
                                        });
                                        return null;
                                      }
                                    },
                                  ),
                                ),
                                Divider(),
                                FlatButton(
                                  color: Colors.black54,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0)
                                  ),
                                  onPressed: ()async {
                                    if (_formKeyElipsoidalHex.currentState.validate()){
                                      CoordenadasElipsoidales coordenadasElipsoidales = CoordenadasElipsoidales();
                                      double hNS(String hemisferioNS ) {
                                        if (hemisferioNS == 'Norte'){
                                          return 1;
                                        } else {return -1;}
                                      }
                                      double hEO(String hemisferioNS ) {
                                        if (hemisferioNS == 'Este'){
                                          return 1;
                                        } else {return -1;}
                                      }
                                      coordenadasElipsoidales.latitud = (gradosLatitudF+(minutosLatitudF/60)+(segundosLatitudF/3600))*hNS(valorNS);
                                      coordenadasElipsoidales.longitud = (gradosLongitudF+(minutosLongitudF/60)+(segundosLongitudF/3600))*hEO(valorEO);
                                      coordenadasElipsoidales.altitud = altura;
                                      //Geocentricas 
                                      if(widget.destino == 'Geocentricas'){
                                      ConversionCoordenadasMB conversionCoordenadasMB = ConversionCoordenadasMB();
                                      CoordenadasGeocentricas coordenadasGeocentricas = CoordenadasGeocentricas();
                                      coordenadasGeocentricas = conversionCoordenadasMB.elipsoidales2Geocentricas(coordenadasElipsoidales);
                                      AlertDialog elipsoidales2GeocentricasHex = AlertDialog(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(20)
                                                  ),
                                                  content: Container(
                                                    height: 220,
                                                    width: 200,
                                                    child: Center(
                                                      child: Column(
                                                        children: <Widget>[
                                                          Text('Coordenadas Geocentricas', style: TextStyle(color: Colors.blueAccent, fontSize: 13)),
                                                          Divider(),
                                                          Align(
                                                            alignment: Alignment.centerRight,
                                                            child: Text('Coordenadas X Geocentrica', style: TextStyle(color: Colors.black54, fontSize: 12),),
                                                          ),
                                                          SizedBox(height: 3),
                                                          Align(
                                                            alignment: Alignment.centerRight,
                                                            child: Text(roundDouble(coordenadasGeocentricas.x,3).toString(), style: TextStyle(color: Colors.blueAccent, fontSize: 12),),
                                                          ),
                                                          Divider(),
                                                          Align(
                                                            alignment: Alignment.centerRight,
                                                            child: Text('Coordenadas Y Geocentrica', style: TextStyle(color: Colors.black54, fontSize: 12),),
                                                          ),
                                                          SizedBox(height: 3),
                                                          Align(
                                                            alignment: Alignment.centerRight,
                                                            child: Text(roundDouble(coordenadasGeocentricas.y,3).toString(), style: TextStyle(color: Colors.blueAccent, fontSize: 12),),
                                                          ),
                                                          Divider(),
                                                          Align(
                                                            alignment: Alignment.centerRight,
                                                            child: Text('Coordenadas Z Geocentrica', style: TextStyle(color: Colors.black54, fontSize: 12),),
                                                          ),
                                                          SizedBox(height: 3),
                                                          Align(
                                                            alignment: Alignment.centerRight,
                                                            child: Text(roundDouble(coordenadasGeocentricas.z,3).toString(), style: TextStyle(color: Colors.blueAccent, fontSize: 12),),
                                                          ),
                                                          Divider(height: 10),
                                                          FlatButton(
                                                            onPressed: (){
                                                              Share.share('Conversión de Coordenadas MeasureBookAPP \n\n'+
                                                              'Sistema de Rerencia de Origen: \n'+
                                                              'Coordenadas ${widget.origen} \n'+
                                                              'Latitud: ${coordenadasElipsoidales.latitud}\n'+
                                                              'Latitud: ${coordenadasElipsoidales.longitud}\n'+
                                                              'Latitud: ${coordenadasElipsoidales.altitud}\n\n'+
                                                              'Sistema de Rerencia de Destino: \n'+
                                                              'Coordenadas Geocentricas (GRS80)\n'
                                                              'Geocentrica X: ${roundDouble(coordenadasGeocentricas.x,3)}\n'+
                                                              'Geocentrica Y: ${roundDouble(coordenadasGeocentricas.y,3)}\n'+
                                                              'Geocentrica Z: ${roundDouble(coordenadasGeocentricas.z,3)}\n'
                                                              );
                                                            }, 
                                                            child: Icon(Icons.share, color: Colors.black54, size: 30)
                                                            ),
                                                          Text('Compartir', style: TextStyle(color: Colors.blueAccent, fontSize: 13),)
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                );
                                              showDialog(context: context, barrierDismissible: true, builder: (BuildContext context){
                                            return elipsoidales2GeocentricasHex;
                                          });
                                      }else if (widget.destino == 'Gauss - Krüger'){
                                        _sistemaGauss(context, coordenadasElipsoidales);
                                      }else if (widget.destino == 'Planas Cartesianas'){
                                        _alertDialogoCartesianas (context, coordenadasElipsoidales);
                                      }
                                      else if(widget.destino == 'Elipsoidales'){
                                        alertaIgualSystemCoor();
                                      }else if(widget.destino == 'Magna Origen Nacional'){
                                      ConversionCoordenadasMB conversionCoordenadasMB = ConversionCoordenadasMB();
                                      CoordenadasON coordenadasON = CoordenadasON();
                                      coordenadasON = conversionCoordenadasMB.elipsoidales2GaussNuevo(coordenadasElipsoidales);
                                      AlertDialog elipsoidales2On = AlertDialog(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(20)
                                                  ),
                                                  content: Container(
                                                    height: 220,
                                                    width: 200,
                                                    child: Center(
                                                      child: Column(
                                                        children: <Widget>[
                                                          Text('Magna Origen Nacional', style: TextStyle(color: Colors.blueAccent, fontSize: 13)),
                                                          Divider(),
                                                          Align(
                                                            alignment: Alignment.centerRight,
                                                            child: Text('Norte', style: TextStyle(color: Colors.black54, fontSize: 12),),
                                                          ),
                                                          SizedBox(height: 3),
                                                          Align(
                                                            alignment: Alignment.centerRight,
                                                            child: Text(roundDouble(coordenadasON.norte,3).toString(), style: TextStyle(color: Colors.blueAccent, fontSize: 12),),
                                                          ),
                                                          Divider(),
                                                          Align(
                                                            alignment: Alignment.centerRight,
                                                            child: Text('Este', style: TextStyle(color: Colors.black54, fontSize: 12),),
                                                          ),
                                                          SizedBox(height: 3),
                                                          Align(
                                                            alignment: Alignment.centerRight,
                                                            child: Text(roundDouble(coordenadasON.este,3).toString(), style: TextStyle(color: Colors.blueAccent, fontSize: 12),),
                                                          ),
                                                          Divider(),
                                                          Align(
                                                            alignment: Alignment.centerRight,
                                                            child: Text('Altura', style: TextStyle(color: Colors.black54, fontSize: 12),),
                                                          ),
                                                          SizedBox(height: 3),
                                                          Align(
                                                            alignment: Alignment.centerRight,
                                                            child: Text(roundDouble(coordenadasON.altura,3).toString(), style: TextStyle(color: Colors.blueAccent, fontSize: 12),),
                                                          ),
                                                          Divider(height: 10),
                                                          FlatButton(
                                                            onPressed: (){
                                                              Share.share('Conversión de Coordenadas MeasureBookAPP \n\n'+
                                                              'Sistema de Rerencia de Origen: \n'+
                                                              'Coordenadas ${widget.origen} \n'+
                                                              'Latitud: ${coordenadasElipsoidales.latitud}\n'+
                                                              'Latitud: ${coordenadasElipsoidales.longitud}\n'+
                                                              'Latitud: ${coordenadasElipsoidales.altitud}\n\n'+
                                                              'Sistema de Rerencia de Destino: \n'+
                                                              'Magna Origen Nacional\n'
                                                              'Norte: ${roundDouble(coordenadasON.norte,3)}\n'+
                                                              'Este: ${roundDouble(coordenadasON.este,3)}\n'+
                                                              'Altura: ${roundDouble(coordenadasON.altura,3)}\n'
                                                              );
                                                            }, 
                                                            child: Icon(Icons.share, color: Colors.black54, size: 30)
                                                            ),
                                                          Text('Compartir', style: TextStyle(color: Colors.blueAccent, fontSize: 13),)
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                );
                                              showDialog(context: context, barrierDismissible: true, builder: (BuildContext context){
                                            return elipsoidales2On;
                                          });
                                      }
                                      }
                                      },
                                      child: Text('Convertir a ${widget.destino}', style: TextStyle(fontSize: 14.0, color: Colors.white)),
                                      )
                                      ],
                                      ),
                                    )
                                      // Elispodailes sistema Sexadecimal
                                    :Form(
                                      key: _formKeyElipsoidalDec,
                                        child: Container(
                                        child: Column(
                                          children: <Widget>[
                                            TextFormField(
                                              decoration: InputDecoration(
                                              icon: Icon(Icons.add_location),
                                              labelText: 'Latitud',
                                              ),
                                              keyboardType: TextInputType.numberWithOptions(
                                                signed: true,
                                                decimal: true
                                              ),
                                              validator: (String latitude){
                                                double latitudPuntoII = double.tryParse(latitude);
                                              if (latitudPuntoII == null) {
                                              return 'Ingrese la Latitud en formato Decimal';
                                              } else {
                                                if (double.parse(latitude) > -90 && double.parse(latitude) < 90) {
                                                  double latitudepuntoII = double.parse(latitude);
                                                  latitudepunto = latitudepuntoII;
                                                  return null;
                                                }else {return 'El valor Ingresado esta por fuera del rango  (-90° a 90°)';}
                                              }
                                              },
                                            ),
                                          TextFormField(
                                              decoration: InputDecoration(
                                              icon: Icon(Icons.add_location),
                                              labelText: 'Longitud',
                                              ),
                                              keyboardType: TextInputType.number,
                                              //inputFormatters: [WhitelistingTextInputFormatter(RegExp(r'^(-?[0-9]+([.][0-9]*)?|[.][0-9]+)$'))],
                                              validator: (String longitud){
                                              double longitudPuntoII = double.tryParse(longitud);
                                              if (longitudPuntoII == null) {
                                              return 'Ingrese la Longitud en formato Decimal';
                                              } else {
                                                if (double.parse(longitud) > -90 && double.parse(longitud) < 90) {
                                                  longitudPuntoII = double.parse(longitud);
                                                  longitudPunto = longitudPuntoII;
                                                  return null;
                                                }else {return 'El valor Ingresado esta por fuera del rango  (-180° a 180°)';}
                                              }
                                              },
                                            ),
                                          TextFormField(
                                              decoration: InputDecoration(
                                              icon: Icon(Icons.add_location),
                                              labelText: 'Altura',
                                              ),
                                              keyboardType: TextInputType.numberWithOptions(
                                                signed: true,
                                              ),
                                              inputFormatters: [WhitelistingTextInputFormatter(new RegExp(r'^[+-]?([0-9]+([.][0-9]*)?|[.][0-9]+)$'))],
                                              validator: (String altura){
                                                double heigh = double.tryParse(altura);
                                              if (heigh==null) {
                                              return 'Valor de Altura no valido';
                                              } else {
                                                alturaPunto = heigh;
                                                return null;
                                              }
                                              }
                                            ),
                                            FlatButton(
                                                  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20.0)),
                                                  child: Text('Convertir a ${widget.destino}', style: TextStyle(fontSize: 14.0, color: Colors.white)),
                                              color: Colors.black54,
                                              onPressed: () {
                                                if (_formKeyElipsoidalDec.currentState.validate()){
                                                  CoordenadasElipsoidales coorElipdec = CoordenadasElipsoidales();
                                                  coorElipdec.latitud = latitudepunto;
                                                  coorElipdec.longitud = longitudPunto;
                                                  coorElipdec.altitud = alturaPunto;
                                                  // Geocentricas
                                                  if(widget.destino == 'Geocentricas'){
                                                  ConversionCoordenadasMB conversionCoordenadasMB = ConversionCoordenadasMB();
                                                  CoordenadasGeocentricas coordenadasGeocentricasDec = CoordenadasGeocentricas();
                                                  coordenadasGeocentricasDec = conversionCoordenadasMB.elipsoidales2Geocentricas(coorElipdec);
                                                  AlertDialog elipsoidales2GeocentricasHex = AlertDialog(
                                                              shape: RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.circular(20)
                                                              ),
                                                              content: Container(
                                                                height: 220,
                                                                width: 200,
                                                                child: Center(
                                                                  child: Column(
                                                                    children: <Widget>[
                                                                      Text('Coordenadas Geocentricas', style: TextStyle(color: Colors.blueAccent, fontSize: 13)),
                                                                      Divider(),
                                                                      Align(
                                                                        alignment: Alignment.centerRight,
                                                                        child: Text('Coordenadas X Geocentrica', style: TextStyle(color: Colors.black54, fontSize: 12),),
                                                                      ),
                                                                      SizedBox(height: 3),
                                                                      Align(
                                                                        alignment: Alignment.centerRight,
                                                                        child: Text(roundDouble(coordenadasGeocentricasDec.x,3).toString(), style: TextStyle(color: Colors.blueAccent, fontSize: 12),),
                                                                      ),
                                                                      Divider(),
                                                                      Align(
                                                                        alignment: Alignment.centerRight,
                                                                        child: Text('Coordenadas Y Geocentrica', style: TextStyle(color: Colors.black54, fontSize: 12),),
                                                                      ),
                                                                      SizedBox(height: 3),
                                                                      Align(
                                                                        alignment: Alignment.centerRight,
                                                                        child: Text(roundDouble(coordenadasGeocentricasDec.y,3).toString(), style: TextStyle(color: Colors.blueAccent, fontSize: 12),),
                                                                      ),
                                                                      Divider(),
                                                                      Align(
                                                                        alignment: Alignment.centerRight,
                                                                        child: Text('Coordenadas Z Geocentrica', style: TextStyle(color: Colors.black54, fontSize: 12),),
                                                                      ),
                                                                      SizedBox(height: 3),
                                                                      Align(
                                                                        alignment: Alignment.centerRight,
                                                                        child: Text(roundDouble(coordenadasGeocentricasDec.z,3).toString(), style: TextStyle(color: Colors.blueAccent, fontSize: 12),),
                                                                      ),
                                                                      Divider(height: 10),
                                                                      FlatButton(
                                                                        onPressed: (){
                                                                          Share.share('Conversión de Coordenadas MeasureBookAPP \n\n'+
                                                                          'Sistema de Rerencia de Origen: \n'+
                                                                          'Coordenadas Elipsoidales (GRS80) \n'+
                                                                          'Latitud: ${coorElipdec.latitud}\n'+
                                                                          'Latitud: ${coorElipdec.longitud}\n'+
                                                                          'Latitud: ${coorElipdec.altitud}\n\n'+
                                                                          'Sistema de Rerencia de Destino: \n'+
                                                                          'Coordenadas Geocentricas (GRS80)\n'
                                                                          'Geocentrica X: ${roundDouble(coordenadasGeocentricasDec.x,3)}\n'+
                                                                          'Geocentrica X: ${roundDouble(coordenadasGeocentricasDec.y,3)}\n'+
                                                                          'Geocentrica X: ${roundDouble(coordenadasGeocentricasDec.z,3)}\n'
                                                                          );
                                                                        }, 
                                                                        child: Icon(Icons.share, color: Colors.black54, size: 30)
                                                                        ),
                                                                      Text('Compartir', style: TextStyle(color: Colors.blueAccent, fontSize: 13),)
                                                                    ],
                                                                  ),
                                                                ),
                                                              )
                                                            );
                                                      showDialog(context: context, barrierDismissible: true, builder: (BuildContext context){
                                                      return elipsoidales2GeocentricasHex;
                                                      });
                                                  //Gauss - Krüger    
                                                  }else if (widget.destino == 'Gauss - Krüger'){
                                                  _sistemaGauss(context, coorElipdec);
                                                  }else if (widget.destino == 'Planas Cartesianas'){
                                                    _alertDialogoCartesianas (context, coorElipdec);
                                                  }else if(widget.destino == 'Magna Origen Nacional'){
                                                  ConversionCoordenadasMB conversionCoordenadasMB = ConversionCoordenadasMB();
                                                  CoordenadasON coordenadasON = CoordenadasON();
                                                  coordenadasON = conversionCoordenadasMB.elipsoidales2GaussNuevo(coorElipdec);
                                                  AlertDialog elipsoidales2On = AlertDialog(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(20)
                                                  ),
                                                  content: Container(
                                                    height: 220,
                                                    width: 200,
                                                    child: Center(
                                                      child: Column(
                                                        children: <Widget>[
                                                          Text('Magna Origen Nacional', style: TextStyle(color: Colors.blueAccent, fontSize: 13)),
                                                          Divider(),
                                                          Align(
                                                            alignment: Alignment.centerRight,
                                                            child: Text('Norte', style: TextStyle(color: Colors.black54, fontSize: 12),),
                                                          ),
                                                          SizedBox(height: 3),
                                                          Align(
                                                            alignment: Alignment.centerRight,
                                                            child: Text(roundDouble(coordenadasON.norte,3).toString(), style: TextStyle(color: Colors.blueAccent, fontSize: 12),),
                                                          ),
                                                          Divider(),
                                                          Align(
                                                            alignment: Alignment.centerRight,
                                                            child: Text('Este', style: TextStyle(color: Colors.black54, fontSize: 12),),
                                                          ),
                                                          SizedBox(height: 3),
                                                          Align(
                                                            alignment: Alignment.centerRight,
                                                            child: Text(roundDouble(coordenadasON.este,3).toString(), style: TextStyle(color: Colors.blueAccent, fontSize: 12),),
                                                          ),
                                                          Divider(),
                                                          Align(
                                                            alignment: Alignment.centerRight,
                                                            child: Text('Altura', style: TextStyle(color: Colors.black54, fontSize: 12),),
                                                          ),
                                                          SizedBox(height: 3),
                                                          Align(
                                                            alignment: Alignment.centerRight,
                                                            child: Text(roundDouble(coordenadasON.altura,3).toString(), style: TextStyle(color: Colors.blueAccent, fontSize: 12),),
                                                          ),
                                                          Divider(height: 10),
                                                          FlatButton(
                                                            onPressed: (){
                                                              Share.share('Conversión de Coordenadas MeasureBookAPP \n\n'+
                                                              'Sistema de Rerencia de Origen: \n'+
                                                              'Coordenadas ${widget.origen} \n'+
                                                              'Latitud: ${coorElipdec.latitud}\n'+
                                                              'Latitud: ${coorElipdec.longitud}\n'+
                                                              'Latitud: ${coorElipdec.altitud}\n\n'+
                                                              'Sistema de Rerencia de Destino: \n'+
                                                              'Magna Origen Nacional\n'
                                                              'Norte: ${roundDouble(coordenadasON.norte,3)}\n'+
                                                              'Este: ${roundDouble(coordenadasON.este,3)}\n'+
                                                              'Altura: ${roundDouble(coordenadasON.altura,3)}\n'
                                                              );
                                                            }, 
                                                            child: Icon(Icons.share, color: Colors.black54, size: 30)
                                                            ),
                                                          Text('Compartir', style: TextStyle(color: Colors.blueAccent, fontSize: 13),)
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                );
                                              showDialog(context: context, barrierDismissible: true, builder: (BuildContext context){
                                            return elipsoidales2On;
                                          });
                                      }           
                                    }
                                    })
                                  ],
                                )
                                ),
                              )
                              )
                                ],
                                  ),
                                    ),
                                    ),
                                  )
                                )
                              )
                            ),
                          );
  // Sistema de Coordenadas de Origen Geocentricas
  }else if (widget.origen == 'Geocentricas') {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Form(
                key: _formKeyGeocentricas,
                  child: Column(
                  children: <Widget>[
                    SizedBox(height: 0),
                    Image.asset('assets/images/conversion.png',height: 80.0),
                    SizedBox(height: 10),
                    RichText(text: TextSpan(
                      children: <TextSpan> [
                        TextSpan(text: 'Conversion de coordenadas ', style: TextStyle(
                        fontFamily: 'Roboto', 
                        fontSize: 13.0,
                        color: Colors.black54,
                        )),
                        TextSpan(text: '${widget.origen} a ${widget.destino}', style: TextStyle(
                        fontFamily: 'Roboto', 
                        fontSize: 13.0,
                        color: Colors.blueAccent,
                        )),
                      ]
                    )),
                    SizedBox(height: 5.0),
                    Image.asset('assets/images/geocentrica.png', height: 220,),
                    TextFormField(
                    decoration: InputDecoration(
                    icon: Icon(Icons.add_location),
                    labelText: 'Coordenadas X Geocentrica',
                    ),
                    keyboardType: TextInputType.number,
                    validator: (String xGeo){
                      double xGeocentrica = double.tryParse(xGeo);
                    if (xGeocentrica == null) {
                    return 'La Coordenada X, esta en un formato no valido';
                    } else {
                        setState(() {
                          xGeocentricaF=xGeocentrica;
                      });
                      return null;
                    }
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                    icon: Icon(Icons.add_location),
                    labelText: 'Coordenadas Y Geocentrica',
                    ),
                    keyboardType: TextInputType.number,
                    validator: (String yGeo){
                      double yGeocentrica = double.tryParse(yGeo);
                    if (yGeocentrica == null) {
                    return 'La Coordenada Y, esta en un formato no valido';
                    } else {
                      setState(() {
                        yGeocentricaF = yGeocentrica;
                      });
                    return null;
                    }
                    },
                  ),
                  
                  TextFormField(
                    decoration: InputDecoration(
                    icon: Icon(Icons.add_location),
                    labelText: 'Coordenadas Z Geocentrica',
                    ),
                    keyboardType: TextInputType.number,
                    validator: (String zGeo){
                      double zGeocentrica = double.tryParse(zGeo);
                    if (zGeocentrica == null) {
                    return 'La Coordenada Z, esta en un formato no valido';
                    } else {
                      setState(() {
                        zGeocentricaF=zGeocentrica;
                      });
                      return null;
                    }
                    },
                  ),
                  SizedBox(height: 20,),
                  FlatButton(
                    color: Colors.black54,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)
                    ),
                    onPressed: (){
                      if(_formKeyGeocentricas.currentState.validate()){
                      CoordenadasGeocentricas coordenadasGeocentricas = CoordenadasGeocentricas();
                      coordenadasGeocentricas.x = xGeocentricaF;
                      coordenadasGeocentricas.y = yGeocentricaF;
                      coordenadasGeocentricas.z = zGeocentricaF;
                      ConversionCoordenadasMB conversionCoordenadasMB = ConversionCoordenadasMB();
                      CoordenadasElipsoidales coordenadasElipsoidales = CoordenadasElipsoidales();
                      coordenadasElipsoidales = conversionCoordenadasMB.geocentricas2Elipsoidales(coordenadasGeocentricas);
                      if (widget.destino == 'Elipsoidales'){
                       AlertDialog geocentricas2Elipsoidales = AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)
                        ),
                        content: Container(
                          height: 220,
                          width: 200,
                          child: Center(
                            child: Column(
                              children: <Widget>[
                                Text('Coordenadas Elipsoidales', style: TextStyle(color: Colors.blueAccent, fontSize: 13)),
                                Divider(),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text('Latitud', style: TextStyle(color: Colors.black54, fontSize: 12),),
                                ),
                                SizedBox(height: 3),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(roundDouble(coordenadasElipsoidales.latitud, 8).toString(), style: TextStyle(color: Colors.blueAccent, fontSize: 12),),
                                ),
                                Divider(),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text('Longitud', style: TextStyle(color: Colors.black54, fontSize: 12),),
                                ),
                                SizedBox(height: 3),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(roundDouble(coordenadasElipsoidales.longitud, 8).toString(), style: TextStyle(color: Colors.blueAccent, fontSize: 12),),
                                ),
                                Divider(),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text('Altura', style: TextStyle(color: Colors.black54, fontSize: 12),),
                                ),
                                SizedBox(height: 3),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(roundDouble(coordenadasElipsoidales.altitud, 3).toString(), style: TextStyle(color: Colors.blueAccent, fontSize: 12),),
                                ),
                                Divider(height: 10),
                                FlatButton(
                                  onPressed: (){
                                    Share.share('Conversión de Coordenadas MeasureBookAPP \n\n'+
                                    'Sistema de Rerencia de Origen: \n'+
                                    'Coordenadas ${widget.origen} \n'+
                                    'Geocentrica X: ${roundDouble(coordenadasGeocentricas.x,3)}\n'+
                                    'Geocentrica Y: ${roundDouble(coordenadasGeocentricas.y,3)}\n'+
                                    'Geocentrica Z: ${roundDouble(coordenadasGeocentricas.z,3)}\n\n'+
                                    'Sistema de Rerencia de Destino: \n'+
                                    'Coordenadas ${widget.destino} \n'
                                    'Latitud: ${roundDouble(coordenadasElipsoidales.latitud, 8)}\n'+
                                    'Longitud: ${roundDouble(coordenadasElipsoidales.longitud, 8)}\n'+
                                    'Altura: ${roundDouble(coordenadasElipsoidales.altitud, 3)}\n'
                                    );
                                  }, 
                                  child: Icon(Icons.share, color: Colors.black54, size: 30)
                                  ),
                                Text('Compartir', style: TextStyle(color: Colors.blueAccent, fontSize: 13),)
                              ],
                            ),
                          ),
                        )
                      );
                    showDialog(context: context, barrierDismissible: true, builder: (BuildContext context){
                  return geocentricas2Elipsoidales;
                  });
     
                      }else if (widget.destino == 'Gauss - Krüger'){
                        _sistemaGauss(context, coordenadasElipsoidales);
                      } else if (widget.destino == 'Planas Cartesianas') {
                        _alertDialogoCartesianas (context, coordenadasElipsoidales);
                      }else if(widget.destino == 'Geocentricas'){
                        alertaIgualSystemCoor();
                      }else if (widget.destino == 'Magna Origen Nacional'){
                        CoordenadasON coordenadasON = CoordenadasON();
                        coordenadasON = conversionCoordenadasMB.elipsoidales2GaussNuevo(coordenadasElipsoidales);
                        AlertDialog geocentricas2ON = AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)
                        ),
                        content: Container(
                          height: 220,
                          width: 200,
                          child: Center(
                            child: Column(
                              children: <Widget>[
                                Text('Magna Origen Nacional', style: TextStyle(color: Colors.blueAccent, fontSize: 13)),
                                Divider(),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text('Norte', style: TextStyle(color: Colors.black54, fontSize: 12),),
                                ),
                                SizedBox(height: 3),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(roundDouble(coordenadasON.norte, 3).toString(), style: TextStyle(color: Colors.blueAccent, fontSize: 12),),
                                ),
                                Divider(),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text('Este', style: TextStyle(color: Colors.black54, fontSize: 12),),
                                ),
                                SizedBox(height: 3),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(roundDouble(coordenadasON.este, 3).toString(), style: TextStyle(color: Colors.blueAccent, fontSize: 12),),
                                ),
                                Divider(),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text('Altura', style: TextStyle(color: Colors.black54, fontSize: 12),),
                                ),
                                SizedBox(height: 3),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(roundDouble(coordenadasON.altura, 3).toString(), style: TextStyle(color: Colors.blueAccent, fontSize: 12),),
                                ),
                                Divider(height: 10),
                                FlatButton(
                                  onPressed: (){
                                    Share.share('Conversión de Coordenadas MeasureBookAPP \n\n'+
                                    'Sistema de Rerencia de Origen: \n'+
                                    'Coordenadas ${widget.origen} \n'+
                                    'Geocentrica X: ${roundDouble(coordenadasGeocentricas.x,3)}\n'+
                                    'Geocentrica Y: ${roundDouble(coordenadasGeocentricas.y,3)}\n'+
                                    'Geocentrica Z: ${roundDouble(coordenadasGeocentricas.z,3)}\n\n'+
                                    'Sistema de Rerencia de Destino: \n'+
                                    'Magna Origen Nacional \n'
                                    'Norte: ${roundDouble(coordenadasON.norte, 3)}\n'+
                                    'Este: ${roundDouble(coordenadasON.este, 3)}\n'+
                                    'Altura: ${roundDouble(coordenadasON.altura, 3)}\n'
                                    );
                                  }, 
                                  child: Icon(Icons.share, color: Colors.black54, size: 30)
                                  ),
                                Text('Compartir', style: TextStyle(color: Colors.blueAccent, fontSize: 13),)
                              ],
                            ),
                          ),
                        )
                      );
                    showDialog(context: context, barrierDismissible: true, builder: (BuildContext context){
                  return geocentricas2ON;
                  });
                      }
                      }
                      },
                   child: Text('Convertir a ${widget.destino}', style: TextStyle(fontSize: 14.0, color: Colors.white)),
                   ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  // Sistema de Coordenadas de Origen Gauss
  }else if (widget.origen == 'Gauss - Krüger') {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Form(
              key: _formKeyGauss,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 0),
                    Image.asset('assets/images/conversion.png',height: 80.0),
                    SizedBox(height: 10),
                    RichText(text: TextSpan(
                      children: <TextSpan> [
                        TextSpan(text: 'Conversion de coordenadas ', style: TextStyle(
                        fontFamily: 'Roboto', 
                        fontSize: 13.0,
                        color: Colors.black54,
                        )),
                        TextSpan(text: '${widget.origen} a ${widget.destino}', style: TextStyle(
                        fontFamily: 'Roboto', 
                        fontSize: 13.0,
                        color: Colors.blueAccent,
                        )),
                      ]
                    )),
                    SizedBox(height: 5.0),
                    Image.asset('assets/images/gauss.png', height: 220,),
                    TextFormField(
                  decoration: InputDecoration(
                  icon: Icon(Icons.add_location),
                  labelText: 'Coordenada Norte',
                  ),
                  keyboardType: TextInputType.number,
                  validator: (String nGa){
                    double nGauss = double.tryParse(nGa);
                  if (nGauss == null) {
                  return 'La Coordenada Norte, esta en un formato no valido';
                  } else {
                      setState(() {
                        norteGauss=nGauss;
                    });
                    return null;
                  }
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                  icon: Icon(Icons.add_location),
                  labelText: 'Coordenadas Este',
                  ),
                  keyboardType: TextInputType.number,
                  validator: (String eGa){
                    double eGauss = double.tryParse(eGa);
                  if (eGauss == null) {
                  return 'La Coordenada Este, esta en un formato no valido';
                  } else {
                    setState(() {
                      esteGauss = eGauss;
                    });
                  return null;
                  }
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                  icon: Icon(Icons.add_location),
                  labelText: 'Altura',
                  ),
                  keyboardType: TextInputType.number,
                  validator: (String aGa){
                    double aGausss = double.tryParse(aGa);
                  if (aGausss == null) {
                  return 'La Altura, esta en un formato no valido';
                  } else {
                    setState(() {
                      alturaGauss=aGausss;
                    });
                    return null;
                  }
                  },
                ),
                SizedBox(height: 20),
                Container(
                  child: origenGauss
                  ?Container(
                     child: ListTile(
                      leading: Icon(Icons.add_location, color: Colors.blueAccent, size: 50,),
                      title: Text('Origen de Cordenadas Seleccionado',style: TextStyle(
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
                FlatButton(
                    color: Colors.black54,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)
                    ),
                    onPressed: (){
                      if (origenGauss == true){
                        if(_formKeyGauss.currentState.validate()){
                        coordenadasGaussForm.norte = norteGauss;
                        coordenadasGaussForm.este = esteGauss;
                        coordenadasGaussForm.altura = alturaGauss;
                        ConversionCoordenadasMB conversionCoordenadasMB = ConversionCoordenadasMB();
                        CoordenadasElipsoidales coordenadasElipsoidales = CoordenadasElipsoidales();
                        coordenadasElipsoidales  = conversionCoordenadasMB.gauss2Elipsoidales(gaussCOrigen, coordenadasGaussForm);
                      if (widget.destino == 'Elipsoidales'){
                       AlertDialog gauss2Elip = AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)
                        ),
                        content: Container(
                          height: 230,
                          width: 200,
                          child: Center(
                            child: Column(
                              children: <Widget>[
                                Text('Coordenadas Elipsoidales', style: TextStyle(color: Colors.blueAccent, fontSize: 13)),
                                Divider(),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text('Latitud', style: TextStyle(color: Colors.black54, fontSize: 12),),
                                ),
                                SizedBox(height: 3),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(roundDouble(coordenadasElipsoidales.latitud, 8).toString(), style: TextStyle(color: Colors.blueAccent, fontSize: 12),),
                                ),
                                Divider(),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text('Longitud', style: TextStyle(color: Colors.black54, fontSize: 12),),
                                ),
                                SizedBox(height: 3),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(roundDouble(coordenadasElipsoidales.longitud, 8).toString(), style: TextStyle(color: Colors.blueAccent, fontSize: 12),),
                                ),
                                Divider(),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text('Altura', style: TextStyle(color: Colors.black54, fontSize: 12),),
                                ),
                                SizedBox(height: 3),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(roundDouble(coordenadasElipsoidales.altitud, 3).toString(), style: TextStyle(color: Colors.blueAccent, fontSize: 12),),
                                ),
                                Divider(height: 10),
                                FlatButton(
                                  onPressed: (){
                                    Share.share('Conversión de Coordenadas MeasureBookAPP \n\n'+
                                    'Sistema de Rerencia de Origen: \n'+
                                    'Coordenadas Gauss - Krüger Origen ${gaussCOrigen.NOMBRE} \n'+
                                    'Norte: ${roundDouble(coordenadasGaussForm.norte,3)}\n'+
                                    'Este: ${roundDouble(coordenadasGaussForm.este,3)}\n'+
                                    'Altura: ${roundDouble(coordenadasGaussForm.altura,3)}\n\n'+
                                    'Sistema de Rerencia de Destino: \n'+
                                    'Coordenadas ${widget.destino} \n'
                                    'Latitud: ${roundDouble(coordenadasElipsoidales.latitud, 8)}\n'+
                                    'Longitud: ${roundDouble(coordenadasElipsoidales.longitud, 8)}\n'+
                                    'Altura: ${roundDouble(coordenadasElipsoidales.altitud, 3)}\n'
                                    );
                                  }, 
                                  child: Icon(Icons.share, color: Colors.black54, size: 30)
                                  ),
                                Text('Compartir', style: TextStyle(color: Colors.blueAccent, fontSize: 13),)
                              ],
                            ),
                          ),
                        )
                      );
                        showDialog(context: context, barrierDismissible: true, builder: (BuildContext context){
                      return gauss2Elip;
                      });
                      }else if (widget.destino == 'Gauss - Krüger'){
                        _sistemaGauss(context, coordenadasElipsoidales);
                      } else if (widget.destino == 'Planas Cartesianas') {
                        _alertDialogoCartesianas (context, coordenadasElipsoidales);
                      }else if(widget.destino == 'Geocentricas'){
                        CoordenadasGeocentricas coordenadasGeocentricas = CoordenadasGeocentricas();
                        coordenadasGeocentricas = conversionCoordenadasMB.elipsoidales2Geocentricas(coordenadasElipsoidales);
                        AlertDialog gaussGeocen = AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)
                          ),
                          content: Container(
                            height: 250,
                            width: 200,
                            child: Center(
                              child: Column(
                                children: <Widget>[
                                  Text('Coordenadas Geocentricas', style: TextStyle(color: Colors.blueAccent, fontSize: 13)),
                                  Divider(),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Text('Coordenadas X Geocentrica', style: TextStyle(color: Colors.black54, fontSize: 12),),
                                  ),
                                  SizedBox(height: 3),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(roundDouble(coordenadasGeocentricas.x,3).toString(), style: TextStyle(color: Colors.blueAccent, fontSize: 12),),
                                  ),
                                  Divider(),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Text('Coordenadas Y Geocentrica', style: TextStyle(color: Colors.black54, fontSize: 12),),
                                  ),
                                  SizedBox(height: 3),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(roundDouble(coordenadasGeocentricas.y,3).toString(), style: TextStyle(color: Colors.blueAccent, fontSize: 12),),
                                  ),
                                  Divider(),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Text('Coordenadas Z Geocentrica', style: TextStyle(color: Colors.black54, fontSize: 12),),
                                  ),
                                  SizedBox(height: 3),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(roundDouble(coordenadasGeocentricas.z,3).toString(), style: TextStyle(color: Colors.blueAccent, fontSize: 12),),
                                  ),
                                  Divider(height: 10),
                                  FlatButton(
                                    onPressed: (){
                                      Share.share('Conversión de Coordenadas MeasureBookAPP \n\n'+
                                      'Sistema de Rerencia de Origen: \n'+
                                      'Coordenadas Gauss - Krüger Origen ${gaussCOrigen.NOMBRE} \n'+
                                      'Norte: ${roundDouble(coordenadasGaussForm.norte,3)}\n'+
                                      'Este: ${roundDouble(coordenadasGaussForm.este,3)}\n'+
                                      'Altura: ${roundDouble(coordenadasGaussForm.altura,3)}\n\n'+
                                      'Sistema de Rerencia de Destino: \n'+
                                      'Coordenadas Geocentricas\n'
                                      'Geocentrica X: ${roundDouble(coordenadasGeocentricas.x,3)}\n'+
                                      'Geocentrica Y: ${roundDouble(coordenadasGeocentricas.y,3)}\n'+
                                      'Geocentrica Z: ${roundDouble(coordenadasGeocentricas.z,3)}\n'
                                      );
                                    }, 
                                    child: Icon(Icons.share, color: Colors.black54, size: 30)
                                    ),
                                  Text('Compartir', style: TextStyle(color: Colors.blueAccent, fontSize: 13),)
                                ],
                              ),
                            ),
                          )
                        );
                      showDialog(context: context, barrierDismissible: true, builder: (BuildContext context){
                    return gaussGeocen;
                  });
                      }else if(widget.destino == 'Magna Origen Nacional'){
                        CoordenadasON coordenadasON = CoordenadasON();
                        coordenadasON = conversionCoordenadasMB.elipsoidales2GaussNuevo(coordenadasElipsoidales);
                        AlertDialog gauss2ON = AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)
                          ),
                          content: Container(
                            height: 250,
                            width: 200,
                            child: Center(
                              child: Column(
                                children: <Widget>[
                                  Text('Magna Origen Nacioanl', style: TextStyle(color: Colors.blueAccent, fontSize: 13)),
                                  Divider(),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Text('Norte: ', style: TextStyle(color: Colors.black54, fontSize: 12),),
                                  ),
                                  SizedBox(height: 3),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(roundDouble(coordenadasON.norte,3).toString(), style: TextStyle(color: Colors.blueAccent, fontSize: 12),),
                                  ),
                                  Divider(),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Text('Este: ', style: TextStyle(color: Colors.black54, fontSize: 12),),
                                  ),
                                  SizedBox(height: 3),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(roundDouble(coordenadasON.este,3).toString(), style: TextStyle(color: Colors.blueAccent, fontSize: 12),),
                                  ),
                                  Divider(),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Text('Altura: ', style: TextStyle(color: Colors.black54, fontSize: 12),),
                                  ),
                                  SizedBox(height: 3),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(roundDouble(coordenadasON.altura,3).toString(), style: TextStyle(color: Colors.blueAccent, fontSize: 12),),
                                  ),
                                  Divider(height: 10),
                                  FlatButton(
                                    onPressed: (){
                                      Share.share('Conversión de Coordenadas MeasureBookAPP \n\n'+
                                      'Sistema de Rerencia de Origen: \n'+
                                      'Coordenadas Gauss - Krüger Origen ${gaussCOrigen.NOMBRE} \n'+
                                      'Norte: ${roundDouble(coordenadasGaussForm.norte,3)}\n'+
                                      'Este: ${roundDouble(coordenadasGaussForm.este,3)}\n'+
                                      'Altura: ${roundDouble(coordenadasGaussForm.altura,3)}\n\n'+
                                      'Sistema de Rerencia de Destino: \n'+
                                      'Magna Origen Nacional\n'
                                      'Norte: ${roundDouble(coordenadasON.norte,3)}\n'+
                                      'Este: ${roundDouble(coordenadasON.este,3)}\n'+
                                      'Altura: ${roundDouble(coordenadasON.altura,3)}\n'
                                      );
                                    }, 
                                    child: Icon(Icons.share, color: Colors.black54, size: 30)
                                    ),
                                  Text('Compartir', style: TextStyle(color: Colors.blueAccent, fontSize: 13),)
                                ],
                              ),
                            ),
                          )
                        );
                      showDialog(context: context, barrierDismissible: true, builder: (BuildContext context){
                    return gauss2ON;
                  });
                      }
                      }
                      }
                      },
                   child: Text('Convertir a ${widget.destino}', style: TextStyle(fontSize: 14.0, color: Colors.white)),
                   ),
                ],
              ),
            )
          ),
        ),
      ),
    );
  }else if (widget.origen == 'Planas Cartesianas') {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key:  _formKeyPlanasCartesianas,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 0),
                    Image.asset('assets/images/conversion.png',height: 80.0),
                    SizedBox(height: 10),
                    RichText(text: TextSpan(
                      children: <TextSpan> [
                        TextSpan(text: 'Conversion de coordenadas ', style: TextStyle(
                        fontFamily: 'Roboto', 
                        fontSize: 13.0,
                        color: Colors.black54,
                        )),
                        TextSpan(text: '${widget.origen} a ${widget.destino}', style: TextStyle(
                        fontFamily: 'Roboto', 
                        fontSize: 13.0,
                        color: Colors.blueAccent,
                        )),
                      ]
                    )),
                    SizedBox(height: 5.0),
                    Image.asset('assets/images/elipsoidal.png', height: 220,),
                    SizedBox(height: 15),
                    Divider(),
                    TextFormField(
                    decoration: InputDecoration(
                    icon: Icon(Icons.add_location),
                    labelText: 'Coordenada Norte',
                    ),
                    keyboardType: TextInputType.number,
                    validator: (String nCarte){
                      double nCartesiana = double.tryParse(nCarte);
                    if (nCartesiana == null) {
                    return 'La Coordenada Norte, esta en un formato no valido';
                    } else {
                        setState(() {
                          norteCartesianas=nCartesiana;
                      });
                      return null;
                    }
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                    icon: Icon(Icons.add_location),
                    labelText: 'Coordenadas Este',
                    ),
                    keyboardType: TextInputType.number,
                    validator: (String eCarte){
                      double eCartesiana = double.tryParse(eCarte);
                    if (eCartesiana == null) {
                    return 'La Coordenada Este, esta en un formato no valido';
                    } else {
                      setState(() {
                        esteCartesianas = eCartesiana;
                      });
                    return null;
                    }
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                    icon: Icon(Icons.add_location),
                    labelText: 'Altura',
                    ),
                    keyboardType: TextInputType.number,
                    validator: (String aCar){
                      double aCartesiana = double.tryParse(aCar);
                    if (aCartesiana == null) {
                    return 'La Altura, esta en un formato no valido';
                    } else {
                      setState(() {
                        alturaCartesianas=aCartesiana;
                      });
                      return null;
                    }
                    },
                  ),
                  Divider(height: 10.0),
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
                  FlatButton(
                    color: Colors.black54,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)
                    ),
                    onPressed: (){
                      if (origenCartesiano == true){
                        if(_formKeyPlanasCartesianas.currentState.validate()){
                        coordenadasCartesianasForm.norte = norteCartesianas;
                        coordenadasCartesianasForm.este = esteCartesianas;
                        coordenadasCartesianasForm.altura = alturaCartesianas;
                        ConversionCoordenadasMB conversionCoordenadasMB = ConversionCoordenadasMB();
                        CoordenadasElipsoidales coordenadasElipsoidales = CoordenadasElipsoidales();
                        coordenadasElipsoidales  = conversionCoordenadasMB.cartesianas2Elipoidales(coordenadasCartesianasForm, origenCartesian);
                      if (widget.destino == 'Elipsoidales'){
                       AlertDialog cartesian2Elip = AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)
                        ),
                        content: Container(
                          height: 230,
                          width: 200,
                          child: Center(
                            child: Column(
                              children: <Widget>[
                                Text('Coordenadas Elipsoidales', style: TextStyle(color: Colors.blueAccent, fontSize: 13)),
                                Divider(),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text('Latitud', style: TextStyle(color: Colors.black54, fontSize: 12),),
                                ),
                                SizedBox(height: 3),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(roundDouble(coordenadasElipsoidales.latitud, 8).toString(), style: TextStyle(color: Colors.blueAccent, fontSize: 12),),
                                ),
                                Divider(),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text('Longitud', style: TextStyle(color: Colors.black54, fontSize: 12),),
                                ),
                                SizedBox(height: 3),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(roundDouble(coordenadasElipsoidales.longitud, 8).toString(), style: TextStyle(color: Colors.blueAccent, fontSize: 12),),
                                ),
                                Divider(),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text('Altura', style: TextStyle(color: Colors.black54, fontSize: 12),),
                                ),
                                SizedBox(height: 3),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(roundDouble(coordenadasElipsoidales.altitud, 3).toString(), style: TextStyle(color: Colors.blueAccent, fontSize: 12),),
                                ),
                                Divider(height: 10),
                                FlatButton(
                                  onPressed: (){
                                    Share.share('Conversión de Coordenadas MeasureBookAPP \n\n'+
                                    'Sistema de Rerencia de Origen: \n'+
                                    'Coordenadas Planas Cartesianas Origen ${origenCartesian.NOMBRE} \n'+
                                    'Norte: ${roundDouble(coordenadasCartesianasForm.norte,3)}\n'+
                                    'Este: ${roundDouble(coordenadasCartesianasForm.este,3)}\n'+
                                    'Altura: ${roundDouble(coordenadasCartesianasForm.altura,3)}\n\n'+
                                    'Sistema de Rerencia de Destino: \n'+
                                    'Coordenadas ${widget.destino} \n'
                                    'Latitud: ${roundDouble(coordenadasElipsoidales.latitud, 8)}\n'+
                                    'Longitud: ${roundDouble(coordenadasElipsoidales.longitud, 8)}\n'+
                                    'Altura: ${roundDouble(coordenadasElipsoidales.altitud, 3)}\n'
                                    );
                                  }, 
                                  child: Icon(Icons.share, color: Colors.black54, size: 30)
                                  ),
                                Text('Compartir', style: TextStyle(color: Colors.blueAccent, fontSize: 13),)
                              ],
                            ),
                          ),
                        )
                      );
                        showDialog(context: context, barrierDismissible: true, builder: (BuildContext context){
                      return cartesian2Elip;
                      });
                      }else if (widget.destino == 'Gauss - Krüger'){
                        _sistemaGauss(context, coordenadasElipsoidales);
                      } else if (widget.destino == 'Planas Cartesianas') {
                        _alertDialogoCartesianas (context, coordenadasElipsoidales);
                      }else if(widget.destino == 'Geocentricas'){
                            CoordenadasGeocentricas coordenadasGeocentricas = CoordenadasGeocentricas();
                            coordenadasGeocentricas = conversionCoordenadasMB.elipsoidales2Geocentricas(coordenadasElipsoidales);
                            AlertDialog cartesian2Geocen = AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)
                              ),
                              content: Container(
                                height: 250,
                                width: 200,
                                child: Center(
                                  child: Column(
                                    children: <Widget>[
                                      Text('Coordenadas Geocentricas', style: TextStyle(color: Colors.blueAccent, fontSize: 13)),
                                      Divider(),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Text('Coordenadas X Geocentrica', style: TextStyle(color: Colors.black54, fontSize: 12),),
                                      ),
                                      SizedBox(height: 3),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(roundDouble(coordenadasGeocentricas.x,3).toString(), style: TextStyle(color: Colors.blueAccent, fontSize: 12),),
                                      ),
                                      Divider(),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Text('Coordenadas Y Geocentrica', style: TextStyle(color: Colors.black54, fontSize: 12),),
                                      ),
                                      SizedBox(height: 3),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(roundDouble(coordenadasGeocentricas.y,3).toString(), style: TextStyle(color: Colors.blueAccent, fontSize: 12),),
                                      ),
                                      Divider(),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Text('Coordenadas Z Geocentrica', style: TextStyle(color: Colors.black54, fontSize: 12),),
                                      ),
                                      SizedBox(height: 3),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(roundDouble(coordenadasGeocentricas.z,3).toString(), style: TextStyle(color: Colors.blueAccent, fontSize: 12),),
                                      ),
                                      Divider(height: 10),
                                      FlatButton(
                                        onPressed: (){
                                          Share.share('Conversión de Coordenadas MeasureBookAPP \n\n'+
                                          'Sistema de Referencia de Origen: \n'+
                                          'Coordenadas Planas Cartesianas Origen ${origenCartesian.NOMBRE} \n'+
                                          'Norte: ${roundDouble(coordenadasCartesianasForm.norte,3)}\n'+
                                          'Este: ${roundDouble(coordenadasCartesianasForm.este,3)}\n'+
                                          'Altura: ${roundDouble(coordenadasCartesianasForm.altura,3)}\n\n'+
                                          'Sistema de Rerencia de Destino: \n'+
                                          'Coordenadas Geocentricas\n'
                                          'Geocentrica X: ${roundDouble(coordenadasGeocentricas.x,3)}\n'+
                                          'Geocentrica Y: ${roundDouble(coordenadasGeocentricas.y,3)}\n'+
                                          'Geocentrica Z: ${roundDouble(coordenadasGeocentricas.z,3)}\n'
                                          );
                                        }, 
                                        child: Icon(Icons.share, color: Colors.black54, size: 30)
                                        ),
                                      Text('Compartir', style: TextStyle(color: Colors.blueAccent, fontSize: 13),)
                                    ],
                                  ),
                                ),
                              )
                            );
                          showDialog(context: context, barrierDismissible: true, builder: (BuildContext context){
                        return cartesian2Geocen;
                      });
                      }else if(widget.destino == 'Magna Origen Nacional'){
                        CoordenadasON coordenadasON = CoordenadasON();
                            coordenadasON = conversionCoordenadasMB.elipsoidales2GaussNuevo(coordenadasElipsoidales);
                            AlertDialog cartesian2ON = AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)
                              ),
                              content: Container(
                                height: 250,
                                width: 200,
                                child: Center(
                                  child: Column(
                                    children: <Widget>[
                                      Text('Magna Origen Nacional', style: TextStyle(color: Colors.blueAccent, fontSize: 13)),
                                      Divider(),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Text('Norte', style: TextStyle(color: Colors.black54, fontSize: 12),),
                                      ),
                                      SizedBox(height: 3),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(roundDouble(coordenadasON.norte,3).toString(), style: TextStyle(color: Colors.blueAccent, fontSize: 12),),
                                      ),
                                      Divider(),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Text('Este', style: TextStyle(color: Colors.black54, fontSize: 12),),
                                      ),
                                      SizedBox(height: 3),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(roundDouble(coordenadasON.este,3).toString(), style: TextStyle(color: Colors.blueAccent, fontSize: 12),),
                                      ),
                                      Divider(),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Text('Altura', style: TextStyle(color: Colors.black54, fontSize: 12),),
                                      ),
                                      SizedBox(height: 3),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(roundDouble(coordenadasON.altura,3).toString(), style: TextStyle(color: Colors.blueAccent, fontSize: 12),),
                                      ),
                                      Divider(height: 10),
                                      FlatButton(
                                        onPressed: (){
                                          Share.share('Conversión de Coordenadas MeasureBookAPP \n\n'+
                                          'Sistema de Referencia de Origen: \n'+
                                          'Coordenadas Planas Cartesianas Origen ${origenCartesian.NOMBRE} \n'+
                                          'Norte: ${roundDouble(coordenadasCartesianasForm.norte,3)}\n'+
                                          'Este: ${roundDouble(coordenadasCartesianasForm.este,3)}\n'+
                                          'Altura: ${roundDouble(coordenadasCartesianasForm.altura,3)}\n\n'+
                                          'Sistema de Rerencia de Destino: \n'+
                                          'Magna Origen Nacional\n'
                                          'Norte: ${roundDouble(coordenadasON.norte,3)}\n'+
                                          'Este: ${roundDouble(coordenadasON.este,3)}\n'+
                                          'Altura: ${roundDouble(coordenadasON.altura,3)}\n'
                                          );
                                        }, 
                                        child: Icon(Icons.share, color: Colors.black54, size: 30)
                                        ),
                                      Text('Compartir', style: TextStyle(color: Colors.blueAccent, fontSize: 13),)
                                    ],
                                  ),
                                ),
                              )
                            );
                          showDialog(context: context, barrierDismissible: true, builder: (BuildContext context){
                        return cartesian2ON;
                      });
                      }
                      }
                      }else {
                        origenGaussSelect();
                      }
                      },
                   child: Text('Convertir a ${widget.destino}', style: TextStyle(fontSize: 14.0, color: Colors.white)),
                   ),
                  ],
                ),
              ),
            )
          ),
        ),
      ),
    );
  }else if(widget.origen == 'Magna Origen Nacional'){
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Form(
                key: _formKeyGeocentricas,
                  child: Column(
                  children: <Widget>[
                    SizedBox(height: 0),
                    Image.asset('assets/images/conversion.png',height: 80.0),
                    SizedBox(height: 10),
                    RichText(text: TextSpan(
                      children: <TextSpan> [
                        TextSpan(text: 'Conversion de coordenadas ', style: TextStyle(
                        fontFamily: 'Roboto', 
                        fontSize: 13.0,
                        color: Colors.black54,
                        )),
                        TextSpan(text: '${widget.origen} a ${widget.destino}', style: TextStyle(
                        fontFamily: 'Roboto', 
                        fontSize: 13.0,
                        color: Colors.blueAccent,
                        )),
                      ]
                    )),
                    SizedBox(height: 5.0),
                    Image.asset('assets/images/nacional.png', height: 220,),
                    TextFormField(
                    decoration: InputDecoration(
                    icon: Icon(Icons.add_location),
                    labelText: 'Norte',
                    ),
                    keyboardType: TextInputType.number,
                    validator: (String nOn){
                      double nOrN = double.tryParse(nOn);
                    if (nOrN == null) {
                    return 'La Coordenada Norte, esta en un formato no valido';
                    } else {
                        setState(() {
                          norteOn=nOrN;
                      });
                      return null;
                    }
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                    icon: Icon(Icons.add_location),
                    labelText: 'Este',
                    ),
                    keyboardType: TextInputType.number,
                    validator: (String eOrn){
                      double eOrNac = double.tryParse(eOrn);
                    if (eOrn == null) {
                    return 'La Coordenada Este, esta en un formato no valido';
                    } else {
                      setState(() {
                        esteOn = eOrNac;
                      });
                    return null;
                    }
                    },
                  ),
                  
                  TextFormField(
                    decoration: InputDecoration(
                    icon: Icon(Icons.add_location),
                    labelText: 'Altura',
                    ),
                    keyboardType: TextInputType.number,
                    validator: (String aOn){
                      double altON = double.tryParse(aOn);
                    if (altON == null) {
                    return 'La Altura, esta en un formato no valido';
                    } else {
                      setState(() {
                        alturaOn=altON;
                      });
                      return null;
                    }
                    },
                  ),
                  SizedBox(height: 20,),
                  FlatButton(
                    color: Colors.black54,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)
                    ),
                    onPressed: (){
                      if(_formKeyGeocentricas.currentState.validate()){
                      CoordenadasON coordenadasOn = CoordenadasON();
                      coordenadasOn.norte = norteOn;
                      coordenadasOn.este = esteOn;
                      coordenadasOn.altura = alturaOn;
                      ConversionCoordenadasMB conversionCoordenadasMB = ConversionCoordenadasMB();
                      CoordenadasElipsoidales coordenadasElipsoidales = CoordenadasElipsoidales();
                      coordenadasElipsoidales = conversionCoordenadasMB.origenNacional2Elipsoidales(coordenadasOn);
                      if (widget.destino == 'Elipsoidales'){
                       AlertDialog orNacional2Elipsodiales = AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)
                        ),
                        content: Container(
                          height: 220,
                          width: 200,
                          child: Center(
                            child: Column(
                              children: <Widget>[
                                Text('Coordenadas Elipsoidales', style: TextStyle(color: Colors.blueAccent, fontSize: 13)),
                                Divider(),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text('Latitud', style: TextStyle(color: Colors.black54, fontSize: 12),),
                                ),
                                SizedBox(height: 3),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(roundDouble(coordenadasElipsoidales.latitud, 8).toString(), style: TextStyle(color: Colors.blueAccent, fontSize: 12),),
                                ),
                                Divider(),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text('Longitud', style: TextStyle(color: Colors.black54, fontSize: 12),),
                                ),
                                SizedBox(height: 3),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(roundDouble(coordenadasElipsoidales.longitud, 8).toString(), style: TextStyle(color: Colors.blueAccent, fontSize: 12),),
                                ),
                                Divider(),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text('Altura', style: TextStyle(color: Colors.black54, fontSize: 12),),
                                ),
                                SizedBox(height: 3),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(roundDouble(coordenadasElipsoidales.altitud, 3).toString(), style: TextStyle(color: Colors.blueAccent, fontSize: 12),),
                                ),
                                Divider(height: 10),
                                FlatButton(
                                  onPressed: (){
                                    Share.share('Conversión de Coordenadas MeasureBookAPP \n\n'+
                                    'Sistema de Rerencia de Origen: \n'+
                                    'Magna Origen Nacioanl \n'+
                                    'Norte: ${roundDouble(coordenadasOn.norte,3)}\n'+
                                    'Este: ${roundDouble(coordenadasOn.este,3)}\n'+
                                    'Altura: ${roundDouble(coordenadasOn.altura,3)}\n\n'+
                                    'Sistema de Rerencia de Destino: \n'+
                                    'Coordenadas ${widget.destino} \n'
                                    'Latitud: ${roundDouble(coordenadasElipsoidales.latitud, 8)}\n'+
                                    'Longitud: ${roundDouble(coordenadasElipsoidales.longitud, 8)}\n'+
                                    'Altura: ${roundDouble(coordenadasElipsoidales.altitud, 3)}\n'
                                    );
                                  }, 
                                  child: Icon(Icons.share, color: Colors.black54, size: 30)
                                  ),
                                Text('Compartir', style: TextStyle(color: Colors.blueAccent, fontSize: 13),)
                              ],
                            ),
                          ),
                        )
                      );
                    showDialog(context: context, barrierDismissible: true, builder: (BuildContext context){
                  return orNacional2Elipsodiales;
                  });
     
                      }else if (widget.destino == 'Gauss - Krüger'){
                        _sistemaGauss(context, coordenadasElipsoidales);
                      } else if (widget.destino == 'Planas Cartesianas') {
                        _alertDialogoCartesianas (context, coordenadasElipsoidales);
                      }else if(widget.destino == 'Magna Origen Nacional'){
                        alertaIgualSystemCoor();
                      }else if (widget.destino == 'Geocentricas'){
                        CoordenadasGeocentricas coordenadasGeocentricas = CoordenadasGeocentricas();
                        coordenadasGeocentricas = conversionCoordenadasMB.elipsoidales2Geocentricas(coordenadasElipsoidales);
                        AlertDialog on2Geocentricas = AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)
                        ),
                        content: Container(
                          height: 220,
                          width: 200,
                          child: Center(
                            child: Column(
                              children: <Widget>[
                                Text('Coordenadas Geocentricas (WGS 80)', style: TextStyle(color: Colors.blueAccent, fontSize: 13)),
                                Divider(),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text('Coordenadas X: ', style: TextStyle(color: Colors.black54, fontSize: 12),),
                                ),
                                SizedBox(height: 3),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(roundDouble(coordenadasGeocentricas.x, 3).toString(), style: TextStyle(color: Colors.blueAccent, fontSize: 12),),
                                ),
                                Divider(),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text('Coordenadas Y:', style: TextStyle(color: Colors.black54, fontSize: 12),),
                                ),
                                SizedBox(height: 3),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(roundDouble(coordenadasGeocentricas.y, 3).toString(), style: TextStyle(color: Colors.blueAccent, fontSize: 12),),
                                ),
                                Divider(),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text('Coordenada Z: ', style: TextStyle(color: Colors.black54, fontSize: 12),),
                                ),
                                SizedBox(height: 3),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(roundDouble(coordenadasGeocentricas.z, 3).toString(), style: TextStyle(color: Colors.blueAccent, fontSize: 12),),
                                ),
                                Divider(height: 10),
                                FlatButton(
                                  onPressed: (){
                                    Share.share('Conversión de Coordenadas MeasureBookAPP \n\n'+
                                    'Sistema de Rerencia de Origen: \n'+
                                    'Magna Origen Nacional \n'+
                                    'Norte: ${roundDouble(coordenadasOn.norte,3)}\n'+
                                    'Este: ${roundDouble(coordenadasOn.este,3)}\n'+
                                    'Altura: ${roundDouble(coordenadasOn.altura,3)}\n\n'+
                                    'Sistema de Rerencia de Destino: \n'+
                                    'Coordenadas Geocentricas \n'
                                    'Norte: ${roundDouble(coordenadasGeocentricas.x, 3)}\n'+
                                    'Este: ${roundDouble(coordenadasGeocentricas.y, 3)}\n'+
                                    'Altura: ${roundDouble(coordenadasGeocentricas.z, 3)}\n'
                                    );
                                  }, 
                                  child: Icon(Icons.share, color: Colors.black54, size: 30)
                                  ),
                                Text('Compartir', style: TextStyle(color: Colors.blueAccent, fontSize: 13),)
                              ],
                            ),
                          ),
                        )
                      );
                    showDialog(context: context, barrierDismissible: true, builder: (BuildContext context){
                  return on2Geocentricas;
                  });
                      }
                      }
                      },
                   child: Text('Convertir a ${widget.destino}', style: TextStyle(fontSize: 14.0, color: Colors.white)),
                   ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
// Obtener listado de departamentos para filtrar planos cartesianos por Municipio
void _alertDialogoCartesianas(BuildContext context, CoordenadasElipsoidales elipCoor) {
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
                          _alertDialogoCartesianasMunicipio(context, listaDepartamentos.PK_DEPARTAMENTO, elipCoor);
                          
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
//Obtener Planos Cartesianos por municipio seleccionado
  void _alertDialogoCartesianasMunicipio(BuildContext context, int fk_Departamento, CoordenadasElipsoidales elipCoor) {
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
                           _sistemas2Cartesianos(context, listaMun.PK_MUNICIPIOS,elipCoor);
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

// Obtener Datos Origen Coordenadas Planas Cartesianas
void _sistemas2Cartesianos (BuildContext context, int fk_Muninipio, CoordenadasElipsoidales elipCoor) {
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
                                            _conversionPlanasCartesianas(context, cartesianasCS, elipCoor);
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
                                            cartesianasCS.ESTE = listaOrigenes.ESTE;
                                            cartesianasCS.NORTE = listaOrigenes.NORTE;
                                            cartesianasCS.PLANO_PROY = listaOrigenes.PLANO_PROY;
                                            cartesianasCS.LATITUD = listaOrigenes.LATITUD;
                                            cartesianasCS.LONGITUD = listaOrigenes.LONGITUD;
                                            Navigator.pop(context);
                                            _conversionPlanasCartesianas(context, cartesianasCS, elipCoor);
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
 
 _sistemaGauss (BuildContext context, CoordenadasElipsoidales coorelipso){
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
                                              _conversionGauss(context, gaussC, coorelipso);
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
  //Conversion de Coordenadas Elipsoidales a Gauss
  void _conversionGauss(BuildContext context, GaussCS gaussCS, CoordenadasElipsoidales coordenadasElp) {
    ConversionCoordenadasMB conversionCoordenadasMB = ConversionCoordenadasMB();
    CoordenadasGauss coordenadasGauss = CoordenadasGauss();
    coordenadasGauss = conversionCoordenadasMB.elipsoidales2Gauss(coordenadasElp, gaussCS);
    AlertDialog elipsoidales2Gauss = AlertDialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20)
    ),
    content: Container(
      height: 240,
      width: 200,
      child: Center(
        child: Column(
          children: <Widget>[
            Text('Coordenadas Gauss Krüger origen ${gaussCS.NOMBRE}', style: TextStyle(color: Colors.blueAccent, fontSize: 13)),
            Divider(),
            Align(
              alignment: Alignment.centerRight,
              child: Text('Norte', style: TextStyle(color: Colors.black54, fontSize: 12),),
            ),
            SizedBox(height: 3),
            Align(
              alignment: Alignment.centerRight,
              child: Text(roundDouble(coordenadasGauss.norte,3).toString(), style: TextStyle(color: Colors.blueAccent, fontSize: 12),),
            ),
            Divider(),
            Align(
              alignment: Alignment.centerRight,
              child: Text('Este', style: TextStyle(color: Colors.black54, fontSize: 12),),
            ),
            SizedBox(height: 3),
            Align(
              alignment: Alignment.centerRight,
              child: Text(roundDouble(coordenadasGauss.este,3).toString(), style: TextStyle(color: Colors.blueAccent, fontSize: 12),),
            ),
            Divider(),
            Align(
              alignment: Alignment.centerRight,
              child: Text('Altura', style: TextStyle(color: Colors.black54, fontSize: 12),),
            ),
            SizedBox(height: 3),
            Align(
              alignment: Alignment.centerRight,
              child: Text(roundDouble(coordenadasGauss.altura,3).toString(), style: TextStyle(color: Colors.blueAccent, fontSize: 12),),
            ),
            Divider(height: 10),
            FlatButton(
              onPressed: (){
                if(widget.origen == 'Elipsoidales'){
                Share.share('Conversión de Coordenadas MeasureBookAPP \n\n'+
                'Sistema de Referencia de Origen: \n'+
                'Coordenadas ${widget.origen} \n'+
                'Latitud: ${coordenadasElp.latitud}\n'+
                'Latitud: ${coordenadasElp.longitud}\n'+
                'Latitud: ${coordenadasElp.altitud}\n\n'+
                'Sistema de Rerencia de Destino: \n'+
                'Coordenadas Gauss Krüger Origen ${gaussCS.NOMBRE}\n'
                'Norte: ${roundDouble(coordenadasGauss.norte,3)}\n'+
                'Este: ${roundDouble(coordenadasGauss.este,3)}\n'+
                'Altura: ${roundDouble(coordenadasGauss.altura,3)}\n'
                );
                }else if(widget.origen == 'Geocentricas'){
                Share.share('Conversión de Coordenadas MeasureBookAPP \n\n'+
                'Sistema de Referencia de Origen: \n'+
                'Coordenadas ${widget.origen} \n'+
                'Coordenada X: ${xGeocentricaF}\n'+
                'Coordenada Y: ${yGeocentricaF}\n'+
                'Coordenada Z: ${zGeocentricaF}\n\n'+
                'Sistema de Rerencia de Destino: \n'+
                'Coordenadas Gauss Krüger Origen ${gaussCS.NOMBRE}\n'
                'Norte: ${roundDouble(coordenadasGauss.norte,3)}\n'+
                'Este: ${roundDouble(coordenadasGauss.este,3)}\n'+
                'Altura: ${roundDouble(coordenadasGauss.altura,3)}\n'
                );
                }else if(widget.origen == 'Gauss - Krüger'){
                  Share.share('Conversión de Coordenadas MeasureBookAPP \n\n'+
                'Sistema de Referencia de Origen: \n'+
                'Coordenadas Gauss Krüger Origen ${gaussCOrigen.NOMBRE}\n'+
                'Norte: ${coordenadasGaussForm.norte}\n'+
                'Este: ${coordenadasGaussForm.este}\n'+
                'Altura: ${coordenadasGaussForm.altura}\n\n'+
                'Sistema de Rerencia de Destino: \n'+
                'Coordenadas Gauss Krüger Origen ${gaussCS.NOMBRE}\n'+
                'Norte: ${roundDouble(coordenadasGauss.norte,3)}\n'+
                'Este: ${roundDouble(coordenadasGauss.este,3)}\n'+
                'Altura: ${roundDouble(coordenadasGauss.altura,3)}\n'
                );
                }else if(widget.origen == 'Magna Origen Nacional'){
                
                 Share.share('Conversión de Coordenadas MeasureBookAPP \n\n'+
                'Sistema de Referencia de Origen: \n'+
                'Magna Origen Nacional\n'+
                'Norte: ${norteOn}\n'+
                'Este: ${esteOn}\n'+
                'Altura: ${alturaOn}\n\n'+
                'Sistema de Rerencia de Destino: \n'+
                'Coordenadas Gauss Krüger Origen ${gaussCS.NOMBRE}\n'+
                'Norte: ${roundDouble(coordenadasGauss.norte,3)}\n'+
                'Este: ${roundDouble(coordenadasGauss.este,3)}\n'+
                'Altura: ${roundDouble(coordenadasGauss.altura,3)}\n'
                );
                }
                
              }, 
              child: Icon(Icons.share, color: Colors.black54, size: 30)
              ),
            Text('Compartir', style: TextStyle(color: Colors.blueAccent, fontSize: 13),)
          ],
        ),
      ),
    )
  );
  showDialog(context: context, barrierDismissible: true, builder: (BuildContext context){
      return elipsoidales2Gauss;
    });
  }
    //Conversión de Coordenadas Elipsoidales a Cartesianas  
  void _conversionPlanasCartesianas(BuildContext context, CartesianasCS cartesianasCS, CoordenadasElipsoidales elipCoor) {
    ConversionCoordenadasMB conversionCoordenadasMB = ConversionCoordenadasMB();
    CoordenadasCartesianas coordenadasCartesianas = CoordenadasCartesianas();
    coordenadasCartesianas = conversionCoordenadasMB.elipsoidales2Cartesianas(cartesianasCS, elipCoor);
    AlertDialog elipsoidales2Cartesianas = AlertDialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20)
    ),
    content: Container(
      height: 250,
      width: 200,
      child: Center(
        child: Column(
          children: <Widget>[
            Text('Coordenadas Planas Cartesianas Origen ${cartesianasCS.NOMBRE}',textAlign: TextAlign.center ,style: TextStyle(color: Colors.blueAccent, fontSize: 13)),
            Divider(),
            Align(
              alignment: Alignment.centerRight,
              child: Text('Norte', style: TextStyle(color: Colors.black54, fontSize: 12),),
            ),
            SizedBox(height: 3),
            Align(
              alignment: Alignment.centerRight,
              child: Text(roundDouble(coordenadasCartesianas.norte,3).toString(), style: TextStyle(color: Colors.blueAccent, fontSize: 12),),
            ),
            Divider(),
            Align(
              alignment: Alignment.centerRight,
              child: Text('Este', style: TextStyle(color: Colors.black54, fontSize: 12),),
            ),
            SizedBox(height: 3),
            Align(
              alignment: Alignment.centerRight,
              child: Text(roundDouble(coordenadasCartesianas.este,3).toString(), style: TextStyle(color: Colors.blueAccent, fontSize: 12),),
            ),
            Divider(),
            Align(
              alignment: Alignment.centerRight,
              child: Text('Altura', style: TextStyle(color: Colors.black54, fontSize: 12),),
            ),
            SizedBox(height: 3),
            Align(
              alignment: Alignment.centerRight,
              child: Text(roundDouble(coordenadasCartesianas.altura,3).toString(), style: TextStyle(color: Colors.blueAccent, fontSize: 12),),
            ),
            Divider(height: 10),
            FlatButton(
              onPressed: (){
                if(widget.origen == 'Elipsoidales'){
                Share.share('Conversión de Coordenadas MeasureBookAPP \n\n'+
                'Sistema de Referencia de Origen: \n'+
                'Coordenadas ${widget.origen} \n'+
                'Latitud: ${elipCoor.latitud}\n'+
                'Latitud: ${elipCoor.longitud}\n'+
                'Latitud: ${elipCoor.altitud}\n\n'+
                'Sistema de Referencia de Destino: \n'+
                'Coordenadas Planas Cartesianas Origen ${cartesianasCS.NOMBRE}\n'
                'Norte: ${roundDouble(coordenadasCartesianas.norte,3)}\n'+
                'Este: ${roundDouble(coordenadasCartesianas.este,3)}\n'+
                'Altura: ${roundDouble(coordenadasCartesianas.altura,3)}\n'
                );
                }else if(widget.origen == 'Geocentricas'){
                Share.share('Conversión de Coordenadas MeasureBookAPP \n\n'+
                'Sistema de Referencia de Origen: \n'+
                'Coordenadas ${widget.origen} \n'+
                'Coordenada X: ${xGeocentricaF}\n'+
                'Coordenada Y: ${yGeocentricaF}\n'+
                'Coordenada Z: ${zGeocentricaF}\n\n'+
                'Sistema de Referencia de Destino: \n'+
                'Coordenadas Planas Cartesianas Origen ${cartesianasCS.NOMBRE}\n'
                'Norte: ${roundDouble(coordenadasCartesianas.norte,3)}\n'+
                'Este: ${roundDouble(coordenadasCartesianas.este,3)}\n'+
                'Altura: ${roundDouble(coordenadasCartesianas.altura,3)}\n'
                );
                }else if(widget.origen =='Gauss - Krüger'){
                Share.share('Conversión de Coordenadas MeasureBookAPP \n\n'+
                'Sistema de Referencia de Origen: \n'+
                'Coordenadas Gauss - Krüger Origen ${gaussCOrigen.NOMBRE} \n'+
                'Norte: ${coordenadasGaussForm.norte}\n'+
                'Este: ${coordenadasGaussForm.este}\n'+
                'Altura: ${coordenadasGaussForm.altura}\n\n'+
                'Sistema de Referencia de Destino: \n'+
                'Coordenadas Planas Cartesianas Origen ${cartesianasCS.NOMBRE}\n'
                'Norte: ${roundDouble(coordenadasCartesianas.norte,3)}\n'+
                'Este: ${roundDouble(coordenadasCartesianas.este,3)}\n'+
                'Altura: ${roundDouble(coordenadasCartesianas.altura,3)}\n'
                );
                }else if(widget.origen == 'Magna Origen Nacional'){
                Share.share('Conversión de Coordenadas MeasureBookAPP \n\n'+
                'Sistema de Referencia de Origen: \n'+
                'Magna Origen Nacional \n'+
                'Norte: ${norteOn}\n'+
                'Este: ${esteOn}\n'+
                'Altura: ${alturaOn}\n\n'+
                'Sistema de Referencia de Destino: \n'+
                'Coordenadas Planas Cartesianas Origen ${cartesianasCS.NOMBRE}\n'
                'Norte: ${roundDouble(coordenadasCartesianas.norte,3)}\n'+
                'Este: ${roundDouble(coordenadasCartesianas.este,3)}\n'+
                'Altura: ${roundDouble(coordenadasCartesianas.altura,3)}\n'
                );
                }               
              }, 
              child: Icon(Icons.share, color: Colors.black54, size: 30)
              ),
            Text('Compartir', style: TextStyle(color: Colors.blueAccent, fontSize: 13),)
          ],
        ),
      ),
    )
  );
  showDialog(context: context, barrierDismissible: true, builder: (BuildContext context){
      return elipsoidales2Cartesianas;
    });
  }                                 
// Mostrar Dialogo cuando se tiene el mismo Sistema de destino y Origen
  void alertaIgualSystemCoor(){
    Fluttertoast.showToast(
    msg: "El sistema de Partida es igual al de destino ",
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 1
    );
  }
  //Alerta de no selección de origen de coordenadas
  void origenGaussSelect(){
    Fluttertoast.showToast(
    msg: "Seleccione el origen del sistema de Coordenadas",
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 1
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
