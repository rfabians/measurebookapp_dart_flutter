import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';

class PuntoNuevo extends StatefulWidget {
  PuntoNuevo({Key key}) : super(key: key);

  @override
  _PuntoNuevoState createState() => _PuntoNuevoState();
}

class _PuntoNuevoState extends State<PuntoNuevo> {
  bool alturaOrtometrica = true;
  double nortePuntoNuevo;
  double estePuntoNuevo;
  double alturaPuntoNuevo;
  String nombrePuntoNuevo;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: SafeArea(
         child: SingleChildScrollView(
           child: Padding(
             padding: const EdgeInsets.all(15.0),
             child: Center(
               child: Column(
                 children: <Widget>[
                   Icon(Icons.add_location,size: 80, color: Colors.blueAccent,),
                    Text('Nuevo Punto de Referencia', style: TextStyle(
                    fontFamily: 'Roboto',
                    color: Color(0xff007FFF),
                    fontSize: 18,)),
                    Divider(height: 20),
                    TextFormField(
                    decoration: InputDecoration(
                    icon: Icon(Icons.add_location),
                    labelText: 'Nombre del Punto',
                    ),
                    validator: (String nombrePunto){
                      if (nombrePunto.isEmpty) {
                        return 'Nombre del Punto Invalido';
                      } else {
                        nombrePuntoNuevo = nombrePunto;
                        return null;
                      }
                      },
                    ),
                    TextFormField(
                    decoration: InputDecoration(
                      icon: Icon(Icons.add_location),
                      labelText: 'Coordenada Norte',
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [WhitelistingTextInputFormatter(new RegExp(r'^[+]?([0-9]+([.][0-9]*)?|[.][0-9]+)$'))],
                    validator: (String nortePunto){
                      if (nortePunto.isEmpty) {
                        return 'Coordenadas Norte Invalida';
                      } else {
                        nortePuntoNuevo = double.parse(nortePunto);
                        return null;
                      }
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        icon: Icon(Icons.add_location),
                        labelText: 'Coordenada Este',
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [WhitelistingTextInputFormatter(new RegExp(r'^[+]?([0-9]+([.][0-9]*)?|[.][0-9]+)$'))],
                      validator: (String estePunto){
                        if (estePunto.isEmpty) {
                        return 'Coordenadas Este Invalida';
                      } else {
                        estePuntoNuevo = double.parse(estePunto);
                        return null;
                      }
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      icon: Icon(Icons.add_location),
                      labelText: 'Altura del Punto',
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [WhitelistingTextInputFormatter(new RegExp(r'^[+]?([0-9]+([.][0-9]*)?|[.][0-9]+)$'))],
                    validator: (String alturaPunto){
                      if (alturaPunto.isEmpty) {
                        return 'Altura del Punto invalida';
                      } else {
                        alturaPuntoNuevo = double.parse(alturaPunto);
                        return null;
                      }
                    },
                  ),
                  Divider(height: 20.0),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                            Text('Altura Ortométrica'),
                            Align(
                            alignment: Alignment.centerLeft,
                            child: CupertinoSwitch(
                            value: alturaOrtometrica,
                            activeColor: Colors.blueAccent,
                            onChanged: (altOrtometrico){
                            alturaOrtometrica = altOrtometrico;
                            },
                          ),
                        ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    leading: Image.asset('assets/images/foto.png'),
                    title: Text('Registro Fotográfico',style: TextStyle(
                    fontFamily: 'Roboto', 
                    fontSize: 16.0,
                    color: Color(0xff007FFF),
                    )),
                    subtitle: Text('Agrega un registro fotográfico del punto'),
                    trailing: Icon(Icons.chevron_right, size: 30.0, color: Colors.blueAccent,),
                  )
                 ],
               ),
             )
           ),
         ),
       ),
    );
  }
}