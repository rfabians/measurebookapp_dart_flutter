import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'dart:math' as m;




class ObservacionGNSSVertice extends StatefulWidget {
  ObservacionGNSSVertice({Key key}) : super(key: key);
  
  @override
  _ObservacionGNSSVerticeState createState() => _ObservacionGNSSVerticeState();
}

class _ObservacionGNSSVerticeState extends State<ObservacionGNSSVertice> {




  @override
  Widget build(BuildContext context) {
    List<Widget> redREf = [
      Center(child: Text('Magna Eco', style: TextStyle(fontSize: 12, color: Colors.blueAccent), textAlign: TextAlign.center)),
      Center(child: Text('GeoRED', style: TextStyle(fontSize: 12, color: Colors.blueAccent),textAlign: TextAlign.center)),
      Center(child: Text('Magna Eco & GeoRED', style: TextStyle(fontSize: 12, color: Colors.blueAccent),textAlign: TextAlign.center))
    ];
    List<Widget> normaREF = [
      Center(child: Text('IGAC', style: TextStyle(fontSize: 12, color: Colors.blueAccent), textAlign: TextAlign.center)),
      Center(child: Text('IDU', style: TextStyle(fontSize: 12, color: Colors.blueAccent),textAlign: TextAlign.center)),
      Center(child: Text('EAB', style: TextStyle(fontSize: 12, color: Colors.blueAccent),textAlign: TextAlign.center)),
      Center(child: Text('CAR', style: TextStyle(fontSize: 12, color: Colors.blueAccent),textAlign: TextAlign.center)),
    ];
    return Scaffold(
       body: SafeArea(
           child: SingleChildScrollView(
             child: Container(
               child: Padding(
                 padding: const EdgeInsets.all(10.0),
                 child: Center(
                   child: Column(
                     children: <Widget>[
                       Image.asset('assets/images/gnss.png', height: 70),
                       Divider(),
                       RichText(text: TextSpan(
                        children: <TextSpan> [
                        TextSpan(text: 'Documenta tus', style: TextStyle(
                        fontFamily: 'Roboto', 
                        fontSize: 12.0,
                        color: Color(0xff007FFF),
                        )),
                        TextSpan(text: ' observaciones GNSS ', style: TextStyle(
                        fontFamily: 'Roboto', 
                        fontSize: 12.0,
                        color: Colors.black54,
                          )),
                        ]
                      )),
                      Divider(height: 40,),
                      Text('Determina el Tiempo de rastreo de tus observaciones', style: TextStyle(color: Colors.blueAccent, fontSize: 13, fontFamily: 'Roboto')),
                      Divider(height: 20),
                      Row(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [BoxShadow(
                                blurRadius: 2,
                                offset: Offset(-5, 5),
                                color: Colors.black12
                              )]
                            ),
                            height: 120,
                            width: (MediaQuery.of(context).size.width-20)/2,
                            child: Center(
                              child: Column(
                                children: <Widget>[
                                  SizedBox(height: 5),
                                  Text('Red de referencia', style: TextStyle(color: Colors.black54,fontSize: 12),textAlign: TextAlign.center),
                                  SizedBox(height: 20),
                                  Container(height: 50, child: CupertinoPicker(itemExtent: 20, onSelectedItemChanged: (index){}, children: redREf, squeeze: 1.0,)),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [BoxShadow(
                                blurRadius: 2,
                                offset: Offset(5, 5),
                                color: Colors.black12
                              )]
                            ),
                            height: 120,
                            width: (MediaQuery.of(context).size.width-20)/2,
                            child: Center(
                              child: Column(
                                children: <Widget>[
                                  SizedBox(height: 5),
                                  Text('Norma de Referencia', style: TextStyle(color: Colors.black54,fontSize: 12),textAlign: TextAlign.center),
                                  SizedBox(height: 20),
                                  Container(height: 50, child: CupertinoPicker(itemExtent: 20, onSelectedItemChanged: (index){}, children: normaREF, squeeze: 1.0,)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      FlatButton(
                          shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20.0)),
                          child: Text('Cálcular tiempos de rastreo', style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 12.0,
                            color: Colors.white,
                          ),),
                          color: Color(0xff007FFF),
                          onPressed: (){
                        }),
                        Divider(height: 50),
                        Text('Genera las hojas de Campo de tus Observaciones GNSS', style: TextStyle(color: Colors.blueAccent, fontSize: 13, fontFamily: 'Roboto')),
                        SizedBox(height: 50),
                        ListTile(
                          title: Text('Crear Hoja de Descripción  de vertice GNSS', style: TextStyle(fontSize: 12, color: Colors.blueAccent)),
                          subtitle: Text('Crea y exporta en PDF la descipción de un vertice geodesico, usando el formato del IGAC', style: TextStyle(fontSize: 12, color: Colors.black54)),
                          leading: Icon(Icons.assignment, size: 50, color: Colors.blueAccent,),
                          trailing: Icon(Icons.navigate_next, color: Colors.black54, size: 40),
                        ),
                        Divider(height: 40),
                        ListTile(
                          title: Text('Crear Hoja de Descripción  de vertice GNSS', style: TextStyle(fontSize: 12, color: Colors.blueAccent)),
                          subtitle: Text('Crea y exporta en PDF la descipción de un vertice geodesico, usando el formato del IGAC', style: TextStyle(fontSize: 12, color: Colors.black54)),
                          leading: Icon(Icons.assignment, size: 50, color: Colors.blueAccent,),
                          trailing: Icon(Icons.navigate_next, color: Colors.black54, size: 40),
                        ),
                     ],
                   ),
                 ),
               ),
             )
           )
          )
        );
    }

}