import 'package:flutter/material.dart';
import 'package:measurebookapp/pages/poligonales/poligonalAbierta.dart';
import 'package:measurebookapp/pages/poligonales/poligonalCerrada.dart';

class PoligonalesMain extends StatefulWidget {
  final String nombreProyecto, proyeccionMB, idUser, idProyeccion;
  PoligonalesMain(
      {Key key,
      this.nombreProyecto,
      this.proyeccionMB,
      this.idUser,
      this.idProyeccion})
      : super(key: key);

  @override
  _PoligonalesMainState createState() => _PoligonalesMainState();
}

class _PoligonalesMainState extends State<PoligonalesMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Container(
            child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                    child: Column(children: <Widget>[
                  Image.asset('assets/images/poligonal_.png', height: 70),
                  RichText(
                      text: TextSpan(children: <TextSpan>[
                    TextSpan(
                        text: 'Almacena y Cálcula',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 12.0,
                          color: Color(0xff007FFF),
                        )),
                    TextSpan(
                        text: ' tus poligonales abiertas y cerradas ',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 12.0,
                          color: Colors.black54,
                        )),
                  ])),
                  Divider(
                    height: 3,
                  ),
                  Divider(height: 20),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(blurRadius: 3.0, color: Colors.black12)
                        ]),
                    height: 400,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: <Widget>[Text('Listado de Poligonales')],
                    ),
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FlatButton(
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(20.0)),
                          child: Text(
                            'Nueva Poligonal Cerrada',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 12.0,
                              color: Colors.white,
                            ),
                          ),
                          color: Color(0xff007FFF),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PoligonalCerrada(
                                          idProyeccion: widget.idProyeccion,
                                          idUser: widget.idUser,
                                          nombreProyecto: widget.nombreProyecto,
                                          proyeccionMB: widget.proyeccionMB,
                                        )));
                          }),
                      SizedBox(width: 30.0),
                      FlatButton(
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(20.0)),
                          child: Text(
                            'Nueva Poligonal Abierta',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 12.0,
                              color: Colors.white,
                            ),
                          ),
                          color: Color(0xff007FFF),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PoligonalAbierta()));
                          }),
                    ],
                  ),
                  FlatButton(
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(20.0)),
                      child: Text(
                        'Eliminar Poligonal',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 12.0,
                          color: Colors.white,
                        ),
                      ),
                      color: Color(0xff007FFF),
                      onPressed: () {}),
                ])))),
      ),
    ));
  }
}
