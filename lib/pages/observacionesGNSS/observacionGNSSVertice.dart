import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:measurebookapp/modelos/proyectos.dart';
import 'package:measurebookapp/pages/conversionCoordenadas.dart';
import 'package:measurebookapp/pages/gestorPuntos.dart';
import 'package:measurebookapp/pages/menuPrincipal.dart';
import 'package:measurebookapp/pages/nivelaciones.dart';
import 'package:measurebookapp/pages/observacionesGNSS/tiemposRastreo.dart';
import 'package:measurebookapp/pages/poligonales/poligonalesMain.dart';

class ObservacionGNSSVertice extends StatefulWidget {
  final proyectos datosProyecto;
  ObservacionGNSSVertice({Key key, this.datosProyecto}) : super(key: key);

  @override
  _ObservacionGNSSVerticeState createState() => _ObservacionGNSSVerticeState();
}

class _ObservacionGNSSVerticeState extends State<ObservacionGNSSVertice> {
  double latitudCentroMap = 0;
  double longitudCentroMap = 0;
  int indeNorma = 0;
  int indicered = 0;
  int _index = 0;
  @override
  Widget build(BuildContext context) {
    List<Widget> redREf = [
      Center(
          child: Text('Magna Eco',
              style: TextStyle(fontSize: 12, color: Colors.blueAccent),
              textAlign: TextAlign.center)),
      Center(
          child: Text('GeoRED',
              style: TextStyle(fontSize: 12, color: Colors.blueAccent),
              textAlign: TextAlign.center)),
    ];
    List<Widget> normaREF = [
      Center(
          child: Text('IGAC RES 643 30/05/2018',
              style: TextStyle(fontSize: 12, color: Colors.blueAccent),
              textAlign: TextAlign.center)),
      Center(
          child: Text('IDU Elab. Estudios Top.',
              style: TextStyle(fontSize: 12, color: Colors.blueAccent),
              textAlign: TextAlign.center)),
      Center(
          child: Text('EAAB NS-030',
              style: TextStyle(fontSize: 12, color: Colors.blueAccent),
              textAlign: TextAlign.center)),
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
              RichText(
                  text: TextSpan(children: <TextSpan>[
                TextSpan(
                    text: 'Cálcula ',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 12.0,
                      color: Color(0xff007FFF),
                    )),
                TextSpan(
                    text: 'tiempos de rastreo ',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 12.0,
                      color: Colors.black54,
                    )),
              ])),
              Divider(
                height: 40,
              ),
              Text('Determina el Tiempo de rastreo de tus observaciones',
                  style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 13,
                      fontFamily: 'Roboto')),
              Divider(height: 20),
              Row(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 2,
                              offset: Offset(-5, 5),
                              color: Colors.black12)
                        ]),
                    height: 120,
                    width: (MediaQuery.of(context).size.width - 20) / 2,
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 5),
                          Text('Red de referencia',
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 12),
                              textAlign: TextAlign.center),
                          SizedBox(height: 20),
                          Container(
                              height: 50,
                              child: CupertinoPicker(
                                itemExtent: 20,
                                onSelectedItemChanged: (index) {
                                  setState(() {
                                    indicered = index;
                                    print(indicered);
                                  });
                                },
                                children: redREf,
                                squeeze: 1.0,
                              )),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 2,
                              offset: Offset(5, 5),
                              color: Colors.black12)
                        ]),
                    height: 120,
                    width: (MediaQuery.of(context).size.width - 20) / 2,
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 5),
                          Text('Norma de Referencia',
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 12),
                              textAlign: TextAlign.center),
                          SizedBox(height: 20),
                          Container(
                              height: 50,
                              child: CupertinoPicker(
                                itemExtent: 20,
                                onSelectedItemChanged: (index) {
                                  setState(() {
                                    indeNorma = index;
                                    print(indeNorma);
                                  });
                                },
                                children: normaREF,
                                squeeze: 1.0,
                              )),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              FlatButton(
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(20.0)),
                  child: Text(
                    'Cálcular tiempos de rastreo',
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
                            builder: (context) => TiemposRastreoGNSS(
                                  norma: indeNorma,
                                  estaciones: indicered,
                                )));
                  }),
              Divider(height: 50),
            ],
          ),
        ),
      ),
    ))));
  }

  BottomAppBar _barraNavegacionMB(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      color: Colors.black87,
      child: Row(
        children: <Widget>[
          Container(
            height: 40,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text('      Cálcular Tiempos de Rastreo',
                  style: TextStyle(fontSize: 12, color: Colors.white)),
            ),
          )
        ],
      ),
    );
  }
}
