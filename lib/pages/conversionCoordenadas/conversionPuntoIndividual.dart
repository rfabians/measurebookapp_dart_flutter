import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:measurebookapp/clases/conversionCoordenadasMB.dart';
import 'package:measurebookapp/modelos/coordenadasElipsoidales.dart';
import 'package:measurebookapp/modelos/coordenadasGeocenticas.dart';
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
  String valorNS = 'Norte';
  String valorEO = 'Oeste';
  double latitudepunto, longitudPunto, alturaPunto;
  double gradosLatitudF, minutosLatitudF, segundosLatitudF;
  double gradosLongitudF, minutosLongitudF, segundosLongitudF;
  double altura;
  double xGeocentricaF, yGeocentricaF, zGeocentricaF;
  double norteCartesianas, esteCartesianas, alturaCartesianas;
double norteGauss, esteGauss, alturaGauss;
  final GlobalKey<FormState> _formKeyElipsoidalHex = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKeyElipsoidalDec = GlobalKey<FormState>();

  double roundDouble(double value, int places){ 
   double mod = m.pow(10.0, places); 
   return ((value * mod).round().toDouble() / mod); 
}
  
  @override
  Widget build(BuildContext context) {
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
                          Text('Sistema Hexadecimal', style: TextStyle(color: Colors.blueAccent, fontSize: 13)),
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
                                  onPressed: (){
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
                                                              'Coordenadas Elipsoidales (GRS80) \n'+
                                                              'Latitud: ${coordenadasElipsoidales.latitud}\n'+
                                                              'Latitud: ${coordenadasElipsoidales.longitud}\n'+
                                                              'Latitud: ${coordenadasElipsoidales.altitud}\n\n'+
                                                              'Sistema de Rerencia de Destino: \n'+
                                                              'Coordenadas Geocentricas (GRS80)\n'
                                                              'Geocentrica X: ${roundDouble(coordenadasGeocentricas.x,3)}\n'+
                                                              'Geocentrica X: ${roundDouble(coordenadasGeocentricas.y,3)}\n'+
                                                              'Geocentrica X: ${roundDouble(coordenadasGeocentricas.z,3)}\n'
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
                                                }
                                              },
                                              child: Text('Convertir a ${widget.destino}', style: TextStyle(fontSize: 14.0, color: Colors.white)),
                                                )
                                          ],
                                          ),
                                        )
                                                  :Container(
                                                    child: Text('Decimal'),
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
                                          }else if (widget.origen == 'Geocentricas') {
                                            return Scaffold(
                                              body: SafeArea(
                                                child: SingleChildScrollView(
                                                  child: Center(
                                                    child: Text('Geocentricas'),
                                                  ),
                                                ),
                                              ),
                                            );
                                          }else if (widget.origen == 'Gauss - Krüger') {
                                            return Scaffold(
                                              body: SafeArea(
                                                child: SingleChildScrollView(
                                                  child: Center(
                                                    child: Text('Gauss - Krüger'),
                                                  ),
                                                ),
                                              ),
                                            );
                                          }else if (widget.origen == 'Planas Cartesianas') {
                                            return Scaffold(
                                              body: SafeArea(
                                                child: SingleChildScrollView(
                                                  child: Center(
                                                    child: Text('Planas Cartesianas'),
                                                  ),
                                                ),
                                              ),
                                            );
                                          }
                                        }
                                      
}