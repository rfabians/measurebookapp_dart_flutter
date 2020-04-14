import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:measurebookapp/clases/conversionCoordenadasMB.dart';
import 'package:measurebookapp/clases/database.dart';
import 'package:measurebookapp/modelos/cPlanasGenerico.dart';
import 'package:measurebookapp/modelos/cartesianasCS.dart';
import 'package:measurebookapp/modelos/coordenadasCartesianas.dart';
import 'package:measurebookapp/modelos/coordenadasElipsoidales.dart';
import 'package:measurebookapp/modelos/coordenadasPlanasGauss.dart';
import 'package:measurebookapp/modelos/gaussCS.dart';
import 'package:measurebookapp/pages/puntoIgacImportado.dart';
import 'dart:math' as m;

class ConversionPunto extends StatefulWidget {
  final String idusuario, idProyeccion, idProyecto, proyeccion, sistemaOrigen; 
  ConversionPunto({Key key, this.idProyeccion, this.idProyecto, this.idusuario, this.proyeccion, this.sistemaOrigen}) : super(key: key);
  @override
  _ConversionPuntoState createState() => _ConversionPuntoState();
}
final GlobalKey<FormState> _formElipsoidales = GlobalKey<FormState>();
final GlobalKey<FormState> _formElipsoidalesHexa = GlobalKey<FormState>();
String valorNS = 'Norte';
String valorEO = 'Oeste';
double latitudepunto, longitudPunto, alturaPunto;
double gradosLatitudF, minutosLatitudF, segundosLatitudF;
double gradosLongitudF, minutosLongitudF, segundosLongitudF;
double altura;
class _ConversionPuntoState extends State<ConversionPunto> {
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
  
}
  double roundDouble(double value, int places){ 
   double mod = m.pow(10.0, places); 
   return ((value * mod).round().toDouble() / mod); 
}

  @override
  Widget build(BuildContext context) {
    if (widget.sistemaOrigen == 'Coordenadas Elipsoidales') {

      if (widget.proyeccion == 'Plano Cartesiano') {
        return Scaffold(
          body: SafeArea(child:SingleChildScrollView(
            child: Form(
              key: _formElipsoidales,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20.0,),
                    Text('Coordenadas Elispoidales', style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 16.0,
                    ),),
                    Image.asset('assets/images/elipsoidal.png'),
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
                          child: Text('Importar', style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 12.0,
                          color: Colors.white,
                        ),),
                       color: Color(0xff007FFF),
                       onPressed: () async {
                        if (_formElipsoidales.currentState.validate()){
                       CPlanasGenerico planasGenerico = await  coordenadasInportadas(latitudepunto, longitudPunto, alturaPunto);
                       Navigator.push(context, MaterialPageRoute(
                       builder: (context) => PuntoIgacImportado(
                       altura: planasGenerico.altura,
                       nombreProyecto: widget.idProyecto,
                       idUsuario: widget.idusuario,
                       este: roundDouble(planasGenerico.este,3),
                       nombrePunto: 'SIN NOMBRAR',
                       ondulacion: 0,
                       norte: roundDouble(planasGenerico.norte, 3),
                       pkSistemaCoordenadas: widget.idProyeccion,
                       sistemaCoordenadas: widget.proyeccion,
                      ),
                      ));}
                    })
                  ],
                ),
              ),
            ),
          )),
        );}
        else {
          return Scaffold(
          body: SafeArea(child:SingleChildScrollView(
            child: Form(
              key: _formElipsoidales,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20.0,),
                    Text('Coordenadas Elispoidales', style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 16.0,
                    ),),
                    Image.asset('assets/images/elipsoidal.png'),
                    TextFormField(
                      decoration: InputDecoration(
                      icon: Icon(Icons.add_location),
                      labelText: 'Latitud',
                      ),
                      keyboardType: TextInputType.numberWithOptions(
                        signed: true,
                        decimal: true
                      ),
                      //inputFormatters: [WhitelistingTextInputFormatter(RegExp(r'^[+-]?:-?([0-9]+([.][0-9]*)?|[.][0-9]+)$'))],
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
                          child: Text('Importar', style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 12.0,
                          color: Colors.white,
                        ),),
                       color: Color(0xff007FFF),
                       onPressed: () async {
                        if (_formElipsoidales.currentState.validate()){
                       CPlanasGenerico planasGenerico = await  coordenadasInportadas(latitudepunto, longitudPunto, alturaPunto);
                       Navigator.push(context, MaterialPageRoute(
                       builder: (context) => PuntoIgacImportado(
                       altura: planasGenerico.altura,
                       nombreProyecto: widget.idProyecto,
                       idUsuario: widget.idusuario,
                       este: roundDouble(planasGenerico.este,3),
                       nombrePunto: 'SIN NOMBRAR',
                       ondulacion: 0,
                       norte: roundDouble(planasGenerico.norte, 3),
                       pkSistemaCoordenadas: widget.idProyeccion,
                       sistemaCoordenadas: widget.proyeccion,
                      ),
                      ));}
                    })
                  ],
                ),
              ),
            ),
          )),
        );
        }
    } else if(widget.sistemaOrigen == 'Coordenadas Geocentricas'){
      if (widget.proyeccion == 'Plano Cartesiano') {
        return Scaffold(
          body: SafeArea(child:Center(
            child: Column(
              children: <Widget>[
                Text('Coordenadas Geocentricas'),
                Text('Plano Cartesiano')
              ],
            ),
          )),
        );}
        else {
          return Scaffold(
          body: SafeArea(child:Center(
            child: Column(
              children: <Widget>[
                Text('Coordenadas Geocentricas'),
                Text('Gauss Krüger')
              ],
            ),
          )),
        );
        }
    } else if(widget.sistemaOrigen == 'Coordenadas Gauss - Krüger'){
      if (widget.proyeccion == 'Plano Cartesiano') {
        return Scaffold(
          body: SafeArea(child:Center(
            child: Column(
              children: <Widget>[
                Text('Coordenadas Gauss - Krüger'),
                Text('Plano Cartesiano')
              ],
            ),
          )),
        );}
        else {
          return Scaffold(
          body: SafeArea(child:Center(
            child: Column(
              children: <Widget>[
                Text('Coordenadas Gauss - Krüger'),
                Text('Gauss Krüger')
              ],
            ),
          )),
        );
        }
  } else if(widget.sistemaOrigen == 'Hexa'){
    if (widget.proyeccion == 'Plano Cartesiano') {
        return Scaffold(
          body: SafeArea(child:Container(
            child: SingleChildScrollView(
              child: Form(
                key: _formElipsoidalesHexa,
                child: Column(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Center(
                          child: Column(
                            children: <Widget>[
                              SizedBox(height: 20.0,),
                              Text('Coordenadas Elispoidales', style: TextStyle(
                              color: Colors.blueAccent,
                              fontSize: 16.0,
                              ),),
                              Divider(height: 20,),
                              Image.asset('assets/images/elipsoidal.png', height: 300,alignment: Alignment.center, ),
                              Divider(),
                              Text('Latitud', style: TextStyle(color: Colors.blueAccent, fontSize: 16),),
                            ],
                          ),
                        ),
                      ],
                    ),
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
                    Divider(height: 10,),
                    Text('Longitud', style: TextStyle(color: Colors.blueAccent, fontSize: 16),),
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
                    SizedBox(height: 15,),
                    Text('Altura', style: TextStyle(color: Colors.blueAccent, fontSize: 16.0)),
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
                    SizedBox(height: 20.0),
                    FlatButton(
                          shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20.0)),
                          child: Text('Importar', style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 12.0,
                          color: Colors.white,
                        ),),
                       color: Color(0xff007FFF),
                       onPressed: () async {
                        if (_formElipsoidalesHexa.currentState.validate()){
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
                       CPlanasGenerico planasGenerico = await  coordenadasInportadas(coordenadasElipsoidales.latitud, coordenadasElipsoidales.longitud, altura);
                       Navigator.push(context, MaterialPageRoute(
                       builder: (context) => PuntoIgacImportado(
                       altura: planasGenerico.altura,
                       nombreProyecto: widget.idProyecto,
                       idUsuario: widget.idusuario,
                       este: roundDouble(planasGenerico.este,3),
                       nombrePunto: 'SIN NOMBRAR',
                       ondulacion: 0,
                       norte: roundDouble(planasGenerico.norte, 3),
                       pkSistemaCoordenadas: widget.idProyeccion,
                       sistemaCoordenadas: widget.proyeccion,
                      ),
                      ));}
                    })
                  ],
                ),
              ),
            ),
          )),
        );}
        else {
          return Scaffold(
          body: SafeArea(child:Container(
            child: SingleChildScrollView(
              child: Form(
                key: _formElipsoidalesHexa,
                child: Column(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Center(
                          child: Column(
                            children: <Widget>[
                              SizedBox(height: 20.0,),
                              Text('Coordenadas Elispoidales', style: TextStyle(
                              color: Colors.blueAccent,
                              fontSize: 16.0,
                              ),),
                              Divider(height: 20,),
                              Image.asset('assets/images/elipsoidal.png', height: 300,alignment: Alignment.center, ),
                              Divider(),
                              Text('Latitud', style: TextStyle(color: Colors.blueAccent, fontSize: 16),),
                            ],
                          ),
                        ),
                      ],
                    ),
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
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [WhitelistingTextInputFormatter(RegExp(r'^(-?[0-9]+([0-9]*)?|0-9]+)$'))],
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
                                  keyboardType: TextInputType.number,
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
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.number,
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
                    Divider(height: 10,),
                    Text('Longitud', style: TextStyle(color: Colors.blueAccent, fontSize: 16),),
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
                                        minutosLongitudF = minutosLongitud;
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
                    SizedBox(height: 15,),
                    Text('Altura', style: TextStyle(color: Colors.blueAccent, fontSize: 16.0)),
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
                    SizedBox(height: 20.0),
                    FlatButton(
                          shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20.0)),
                          child: Text('Importar', style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 12.0,
                          color: Colors.white,
                        ),),
                       color: Color(0xff007FFF),
                       onPressed: () async {
                        if (_formElipsoidalesHexa.currentState.validate()){
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
                       CPlanasGenerico planasGenerico = await  coordenadasInportadas(coordenadasElipsoidales.latitud, coordenadasElipsoidales.longitud, altura);
                       Navigator.push(context, MaterialPageRoute(
                       builder: (context) => PuntoIgacImportado(
                       altura: planasGenerico.altura,
                       nombreProyecto: widget.idProyecto,
                       idUsuario: widget.idusuario,
                       este: roundDouble(planasGenerico.este,3),
                       nombrePunto: 'SIN NOMBRAR',
                       ondulacion: 0,
                       norte: roundDouble(planasGenerico.norte, 3),
                       pkSistemaCoordenadas: widget.idProyeccion,
                       sistemaCoordenadas: widget.proyeccion,
                      ),
                      ));}
                    })
                  ],
                ),
              ),
            ),
          )),
        );
        }
  } else {
    if (widget.proyeccion == 'Plano Cartesiano') {
        return Scaffold(
          body: SafeArea(child:Center(
            child: Column(
              children: <Widget>[
                Text('Plano Cartesiano'),
                Text('Plano Cartesiano')
              ],
            ),
          )),
        );}
        else {
          return Scaffold(
          body: SafeArea(child:Center(
            child: Column(
              children: <Widget>[
                Text('Plano Cartesiano'),
                Text('Gauss Krüger')
              ],
            ),
          )),
        );
        }
  }
  }
}