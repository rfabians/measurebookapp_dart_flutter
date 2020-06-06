import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'dart:math' as m;




class ObservacionGNSSVertice extends StatefulWidget {
  ObservacionGNSSVertice({Key key}) : super(key: key);
  

  @override
  _ObservacionGNSSVerticeState createState() => _ObservacionGNSSVerticeState();
}

class _ObservacionGNSSVerticeState extends State<ObservacionGNSSVertice> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DateTime fecha;
  bool validarFecha = false;
  final formatoFecha = DateFormat("yyyy-MM-dd");
  String latitud = 'LAtitud';
  String longitud = 'Longitud';
  String altitud = 'Altitud';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: SafeArea(
         child: SingleChildScrollView(
           child: Form(
             key: _formKey,
             child: Padding(
               padding: const EdgeInsets.all(10.0),
               child: Column(
                 children: <Widget>[
                   SizedBox(height: 15),
                   Image.asset('assets/images/gnss.png',height: 60,),
                   Divider(),
                   Text('Nueva Obsevación', style: TextStyle(
                   fontFamily: 'Roboto',
                   color: Colors.black54,
                   fontSize: 14,)),
                   Text('Datos Básicos', style: TextStyle(
                   fontFamily: 'Roboto',
                   color: Color(0xff007FFF),
                   fontSize: 14,)),
                   Divider(),
                   TextFormField(
                   decoration: InputDecoration(
                   icon: Icon(Icons.location_searching),
                   labelText: 'Nombre del Punto'
                   ),
                   validator: (String nPunto) {
                   
                   }
                   ),
                   Row(

                     children: <Widget>[
                       Icon(Icons.date_range),
                       Padding(
                         padding: const EdgeInsets.only(left: 15),
                         child: Container(
                            width: MediaQuery.of(context).size.width-65,
                            child: DateTimeField(
                              format: formatoFecha,
                              initialValue: DateTime.now(),
                              autovalidate: false,
                              onShowPicker: (context, currentValue) async{
                              final time = await showDatePicker(
                              context: context, 
                              initialDate: DateTime.now(), 
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2050),
                            );
                            //Revisar aqui validador de Fecha
                      }
                   ),
                         ),
                       )
                     ],
                   ),
                   TextFormField(
                   decoration: InputDecoration(
                   icon: Icon(Icons.map),
                   labelText: 'Departamento'
                   ),
                   validator: (String nDepartamento) {
                   }
                   ),
                   TextFormField(
                   decoration: InputDecoration(
                   icon: Icon(Icons.location_city),
                   labelText: 'Municipio'
                   ),
                   validator: (String nMunicipio) {
                   }
                   ),
                   TextFormField(
                   decoration: InputDecoration(
                   icon: Icon(Icons.add_location),
                   labelText: 'Vereda/Barrio'
                   ),
                   validator: (String nBarrio) {
                   }
                   ),
                   TextFormField(
                   decoration: InputDecoration(
                   icon: Icon(Icons.add_location),
                   labelText: 'Sitio'
                   ),
                   validator: (String nSitio) {
                   }
                   ),
                   Divider(),
                   Text('Coordenadas Navegadas', style: TextStyle(
                        fontFamily: 'Roboto',
                        color: Color(0xff007FFF),
                        fontSize: 14,)),
                   Divider(),
                   TextFormField(
                   decoration: InputDecoration(
                   icon: Icon(Icons.add_location),
                   labelText: latitud
                   ),
                   validator: (String nLatitud) {
                   }
                   ),
                   TextFormField(
                   decoration: InputDecoration(
                   icon: Icon(Icons.add_location),
                   labelText: longitud
                   ),
                   validator: (String nLongitud) {
                   }
                   ),
                   TextFormField(
                   decoration: InputDecoration(
                  
                   icon: Icon(Icons.add_location),
                   labelText: altitud,
                   ),
                   validator: (String nAltitud) {
                   }
                   ),
                   Divider(),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: <Widget>[
                       FlatButton(onPressed: ()async{
                         Position posicionActual = await Geolocator().getLastKnownPosition(desiredAccuracy: LocationAccuracy.high);
                         setState(() {
                           latitud = grados2Sexadecimal(posicionActual.latitude);
                           longitud = grados2Sexadecimal(posicionActual.longitude);
                           altitud = roundDouble(posicionActual.altitude, 1).toString();
                         });
                       }, 
                       child: Icon(Icons.location_searching, color: Colors.blueAccent, size: 40,)
                       ),
                       FlatButton(onPressed: null, 
                       child: Icon(Icons.navigate_next, color: Colors.blueAccent, size: 60,)
                       ),
                     ],
                   )
                 ],
               ),
             ),
           ),
         )
         ),
    );
  }
  double roundDouble(double value, int places){ 
   double mod = m.pow(10.0, places); 
   return ((value * mod).round().toDouble() / mod); 
}
  String grados2Sexadecimal(double grados){
    String hexadecimal;
    if (grados>=0){
      double seg;
      int grad, min;
      grad = grados.toInt();
      min = ((grados-grad)*60).toInt();
      seg = roundDouble((grados-grad-min/60)*3600, 4);
      hexadecimal = '${grad}°${min}"${seg}"';
      return hexadecimal;
    }else {
      double seg;
      int grad, min;
      grados = grados*-1;
      grad = grados.toInt();
      min = ((grados-grad)*60).toInt();
      seg = roundDouble((grados-grad-min/60)*3600, 4);
      hexadecimal = '-${grad}°${min}"${seg}"';
      return hexadecimal;
    }

  }
}