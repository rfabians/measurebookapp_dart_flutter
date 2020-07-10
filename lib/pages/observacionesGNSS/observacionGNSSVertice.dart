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
          child: Text('EAB NS-030',
              style: TextStyle(fontSize: 12, color: Colors.blueAccent),
              textAlign: TextAlign.center)),
    ];
    List<Widget> listNavegacion = [
      //Menu Principal
      FlatButton(
          onPressed: () {},
          child: ListTile(
            dense: true,
            leading: Image.asset('assets/images/measure.png'),
            title: Text(
              'Menu de Principal',
              style: TextStyle(fontSize: 14, color: Colors.blueAccent),
            ),
            subtitle: Text(
              'Navega el menu principal',
              style: TextStyle(fontSize: 12, color: Colors.black54),
            ),
            trailing: Icon(
              Icons.navigate_next,
              color: Colors.blueAccent,
              size: 50,
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MenuPrincipalMB(
                            datosProyecto: widget.datosProyecto,
                          )));
            },
          )),
      //Gestor de Puntos
      FlatButton(
          onPressed: () {},
          child: ListTile(
            dense: true,
            leading: Image.asset('assets/images/puntos.png'),
            title: Text(
              'Gestor de Puntos',
              style: TextStyle(fontSize: 14, color: Colors.blueAccent),
            ),
            subtitle: Text(
              'Navega al gestor de Puntos',
              style: TextStyle(fontSize: 12, color: Colors.black54),
            ),
            trailing: Icon(
              Icons.navigate_next,
              color: Colors.blueAccent,
              size: 50,
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => GestosPuntos(
                            datosProyecto: widget.datosProyecto,
                          )));
            },
          )),
      //Conversión de Coordenadas
      FlatButton(
          onPressed: () {},
          child: ListTile(
            dense: true,
            leading: Image.asset('assets/images/conversion.png'),
            title: Text(
              'Conversión Coordenadas',
              style: TextStyle(fontSize: 14, color: Colors.blueAccent),
            ),
            subtitle: Text(
              'Navega a la conversion de coordenadas',
              style: TextStyle(fontSize: 12, color: Colors.black54),
            ),
            trailing: Icon(
              Icons.navigate_next,
              color: Colors.blueAccent,
              size: 50,
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CoversionCoordenadas(
                            datosProyecto: widget.datosProyecto,
                          )));
            },
          )),
      //Tiempos de Rastreo
      FlatButton(
          onPressed: () {},
          child: ListTile(
            dense: true,
            leading: Image.asset('assets/images/gnss.png'),
            title: Text(
              'Tiempos de Rastreo',
              style: TextStyle(fontSize: 14, color: Colors.blueAccent),
            ),
            subtitle: Text(
              'Calcular tiempos de rastreo',
              style: TextStyle(fontSize: 12, color: Colors.black54),
            ),
            trailing: Icon(
              Icons.navigate_next,
              color: Colors.blueAccent,
              size: 50,
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ObservacionGNSSVertice()));
            },
          )),
      //Poligonales
      FlatButton(
          onPressed: () {},
          child: ListTile(
            dense: true,
            leading: Image.asset('assets/images/poligonal_.png'),
            title: Text(
              'Poligonales',
              style: TextStyle(fontSize: 14, color: Colors.blueAccent),
            ),
            subtitle: Text(
              'Navega al menu principal de Poligonales',
              style: TextStyle(fontSize: 12, color: Colors.black54),
            ),
            trailing: Icon(
              Icons.navigate_next,
              color: Colors.blueAccent,
              size: 50,
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PoligonalesMain(
                            datosProyecto: widget.datosProyecto,
                          )));
            },
          )),
      //Nivelaciones
      FlatButton(
          onPressed: () {},
          child: ListTile(
            dense: true,
            leading: Image.asset('assets/images/nivelacion_.png'),
            title: Text(
              'Nivelaciones',
              style: TextStyle(fontSize: 14, color: Colors.blueAccent),
            ),
            subtitle: Text(
              'Navega al menu principal de Nivelaciones',
              style: TextStyle(fontSize: 12, color: Colors.black54),
            ),
            trailing: Icon(
              Icons.navigate_next,
              color: Colors.blueAccent,
              size: 50,
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Nivelaciones(
                            datosproyecto: widget.datosProyecto,
                          )));
            },
          )),
    ];

    return Scaffold(
        floatingActionButton: FloatingActionButton(
          hoverColor: Colors.blueAccent,
          child: IconButton(
              icon: Icon(Icons.menu),
              onPressed: () => showModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.transparent,
                  builder: (BuildContext context) => Container(
                      height: 100,
                      decoration: BoxDecoration(color: Colors.transparent),
                      child: PageView.builder(
                          itemCount: listNavegacion.length,
                          controller: PageController(viewportFraction: 0.75),
                          onPageChanged: (int index) =>
                              setState(() => _index = index),
                          itemBuilder: (_, i) {
                            return Transform.scale(
                                scale: 0.9,
                                child: Card(
                                  elevation: 6,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: listNavegacion[i]),
                                ));
                          })))),
          mini: true,
          onPressed: () {
            print('Boton Navegación');
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        bottomNavigationBar: this._barraNavegacionMB(context),
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
                        text: 'Documenta tus',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 12.0,
                          color: Color(0xff007FFF),
                        )),
                    TextSpan(
                        text: ' observaciones GNSS ',
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
