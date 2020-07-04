import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';
import 'package:flutter_sensor_compass/flutter_sensor_compass.dart';
import 'dart:math' as m;

class DescripcionVerticeII extends StatefulWidget {
  DescripcionVerticeII({Key key}) : super(key: key);

  @override
  _DescripcionVerticeIIState createState() => _DescripcionVerticeIIState();
}

class _DescripcionVerticeIIState extends State<DescripcionVerticeII> {
  //Brujula
  bool _compassEnabled = false;
  int _degrees = 0;
  List<Offset> obstaculosGrafica = List<Offset>();
  StreamSubscription _compassSubscription;

  //Camara
  CameraController _controller;
  Future<void> _initCamFuture;
  //Sensores
  double dX, dY, dZ;
  //Lista obstaculos
  List<Widget> obstaculos = List<Widget>();
  int contadorObstaculos = 0;
  // On Init
  @override
  void initState() {
    _checkCompassAvailability();
    _startCompass();
    super.initState();
    accelerometerEvents.listen((event) {
      setState(() {
        dX = event.x;
        dY = event.y;
        dZ = event.z;
      });
    });
    _initApp();
  }

  // VAriables pocisión Texto Diagrama de Obstaculos
  double escalador = 1.5;
  double centrox = 185.0;
  double centroy = 135.0;
//Normalización Vecrtor del Acelerometro
  int anguloVertical(double dx, dy, dz) {
    double longitudVector = m.sqrt(dx * dx + dy * dy + dz * dz);
    double x = dx / longitudVector;
    double y = dy / longitudVector;
    double z = dz / longitudVector;
    int anguloVertical = (m.acos(y) * 180 / m.pi).toInt();
    if (z <= 0) {
      if (anguloVertical >= 90) {
        anguloVertical = 90;
      }
    } else {
      anguloVertical = 0;
    }
    return anguloVertical;
  }

  Offset coodenadasGrafica(int azimutObservado, verticalObservado) {
    double componenteX = m.sin(azimutObservado * (m.pi / 180)) *
            escalador *
            (90 - verticalObservado) +
        centrox;
    double componenteY = m.cos(azimutObservado * (m.pi / 180)) *
            escalador *
            (90 - verticalObservado) +
        centroy;
    Offset coordenadasGraf = Offset(componenteX, componenteY);
    return coordenadasGraf;
  }

  void _checkCompassAvailability() async {
    Compass().isCompassAvailable().then((value) {
      setState(() {
        _compassEnabled = value;
      });
    });
  }

  double roundDouble(double value, int places) {
    double mod = m.pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }

  void _startCompass() {
    if (_compassSubscription != null) return;
    _compassSubscription = Compass()
        .compassUpdates(interval: Duration(milliseconds: 200))
        .listen((value) {
      setState(() {
        _degrees = value.toInt();
      });
    });
  }

  void _stopCompass() {
    if (_compassSubscription == null) return;
    _compassSubscription.cancel();
    _compassSubscription = null;
  }

  _initApp() async {
    //Camara
    final cameras = await availableCameras();
    final firstCam = cameras.first;
    _controller = CameraController(
      firstCam,
      ResolutionPreset.medium,
    );
    _initCamFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    _stopCompass();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(
            child: Center(
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.assignment, size: 40, color: Colors.black54),
                      SizedBox(width: 20),
                      Text('Diagrama de Obstaculos',
                          style: TextStyle(
                              color: Colors.blueAccent, fontSize: 12)),
                    ],
                  ),
                  Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: <Widget>[
                          SingleChildScrollView(
                            child: Row(
                              children: <Widget>[
                                Stack(
                                  children: <Widget>[
                                    SizedBox(height: 20),
                                    Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                        width: 200,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: AspectRatio(
                                              aspectRatio:
                                                  _controller.value.aspectRatio,
                                              child:
                                                  CameraPreview(_controller)),
                                        )),
                                    Positioned(
                                        left: (200 / 2) - 25,
                                        top: 200 * (2 / 3) - 25,
                                        child: Icon(
                                          Icons.add_circle_outline,
                                          size: 50,
                                          color: Colors.black54,
                                        )),
                                  ],
                                ),
                                SizedBox(width: 10),
                                Center(
                                  child: Container(
                                    height: 300,
                                    width: 150,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: [
                                          BoxShadow(
                                              blurRadius: 5.0,
                                              color: Colors.black12)
                                        ]),
                                    child: SingleChildScrollView(
                                      child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Center(
                                          child: Column(children: obstaculos),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          FlatButton(
                              onPressed: () {
                                setState(() {
                                  obstaculosGrafica.add(coodenadasGrafica(
                                      _degrees, anguloVertical(dX, dY, dZ)));
                                });
                                contadorObstaculos = contadorObstaculos + 1;
                                obstaculos.add(Container(
                                  height: 42,
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                        'Obstaculo ${contadorObstaculos}',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 12),
                                      ),
                                      Text(
                                        'Azimut: ${_degrees}',
                                        style: TextStyle(
                                            color: Colors.blueAccent,
                                            fontSize: 12),
                                      ),
                                      Text(
                                        'Angulo Vertical: ${anguloVertical(dX, dY, dZ)}',
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 12),
                                      ),
                                      Divider(
                                        height: 5,
                                      ),
                                    ],
                                  ),
                                ));
                              },
                              child: Icon(
                                Icons.add_circle_outline,
                                size: 40,
                                color: Colors.blueAccent,
                              ))
                        ],
                      )),
                  Divider(),
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                    child: Container(
                        width: 400,
                        height: 280,
                        color: Colors.white,
                        child: Stack(
                          children: [
                            Container(
                                height: 400,
                                width: 300,
                                child: CustomPaint(
                                    painter: FaceOutlinePainter(
                                        listaInportada: obstaculosGrafica))),
                            Positioned(
                              top: centroy + escalador * 10 * m.cos(m.pi / 6),
                              left: centrox + escalador * 10 * m.sin(m.pi / 6),
                              child: Text('70°',
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.blueAccent)),
                            ),
                            Positioned(
                              top: centroy + escalador * 20 * m.cos(m.pi / 6),
                              left: centrox + escalador * 20 * m.sin(m.pi / 6),
                              child: Text('60°',
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.blueAccent)),
                            ),
                            Positioned(
                              top: centroy + escalador * 30 * m.cos(m.pi / 6),
                              left: centrox + escalador * 30 * m.sin(m.pi / 6),
                              child: Text('50°',
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.blueAccent)),
                            ),
                            Positioned(
                              top: centroy + escalador * 40 * m.cos(m.pi / 6),
                              left: centrox + escalador * 40 * m.sin(m.pi / 6),
                              child: Text('40°',
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.blueAccent)),
                            ),
                            Positioned(
                              top: centroy + escalador * 50 * m.cos(m.pi / 6),
                              left: centrox + escalador * 50 * m.sin(m.pi / 6),
                              child: Text('30°',
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.blueAccent)),
                            ),
                            Positioned(
                              top: centroy + escalador * 60 * m.cos(m.pi / 6),
                              left: centrox + escalador * 60 * m.sin(m.pi / 6),
                              child: Text('20°',
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.blueAccent)),
                            ),
                            Positioned(
                              top: centroy + escalador * 70 * m.cos(m.pi / 6),
                              left: centrox + escalador * 70 * m.sin(m.pi / 6),
                              child: Text('10°',
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.blueAccent)),
                            ),
                            Positioned(
                              top: centroy - 5,
                              left: centrox - escalador * 80 - 30,
                              child: Text('270°',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.blueAccent)),
                            ),
                            Positioned(
                              top: centroy - 5,
                              left: centrox + escalador * 80,
                              child: Text('90°',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.blueAccent)),
                            ),
                            Positioned(
                              top: centroy - 15 - escalador * 80,
                              left: centrox - 13,
                              child: Text('360°',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.blueAccent)),
                            ),
                            Positioned(
                              top: centroy + escalador * 80,
                              left: centrox - 13,
                              child: Text('180°',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.blueAccent)),
                            )
                          ],
                        )),
                  ),
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }
}

class FaceOutlinePainter extends CustomPainter {
  List<Offset> listaInportada;
  FaceOutlinePainter({this.listaInportada});
  @override
  void paint(Canvas canvas, Size size) {
    // Define a paint object
    //Lista Vertices Poligonos
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..color = Colors.black54;
    final paintPolygon = Paint();
    paintPolygon.color = Colors.blueAccent;
    final paintBorder = Paint();
    paintBorder.color = Colors.blueAccent;
    paintBorder.strokeWidth = 1.0;
    paintBorder.style = PaintingStyle.stroke;
    double escalador = 1.5;
    double centrox = 180.0;
    double centroy = 135.0;
    List<Offset> puntosPolygono = listaInportada;

    var path = Path();
    path.addPolygon(puntosPolygono, true);
    canvas.drawPath(path, paintPolygon);
    canvas.drawCircle(Offset(centrox, centroy), 10.0 * escalador, paint);
    canvas.drawCircle(Offset(centrox, centroy), 20.0 * escalador, paint);
    canvas.drawCircle(Offset(centrox, centroy), 30.0 * escalador, paint);
    canvas.drawCircle(Offset(centrox, centroy), 40.0 * escalador, paint);
    canvas.drawCircle(Offset(centrox, centroy), 50.0 * escalador, paint);
    canvas.drawCircle(Offset(centrox, centroy), 60.0 * escalador, paint);
    canvas.drawCircle(Offset(centrox, centroy), 70.0 * escalador, paint);
    canvas.drawCircle(Offset(centrox, centroy), 80.0 * escalador, paint);
    canvas.drawLine(Offset(60.0, centroy), Offset(centrox, centroy),
        paint); //Linea lateral izquierdo a centro

    canvas.drawLine(
        Offset(centrox, centroy),
        Offset(centrox + escalador * 80, centroy),
        paint); //Linea centro a Arriba
    canvas.drawLine(Offset(centrox, centroy - 80 * escalador),
        Offset(centrox, centroy), paint);
    // linea arriba a centro
    canvas.drawLine(
        Offset(centrox, centroy),
        Offset(centrox, centroy + 80 * escalador),
        paint); //linea centro a abajo
    canvas.drawLine(
        Offset(centrox, centroy),
        Offset(centrox + 80 * escalador * m.cos(m.pi / 6),
            centroy + 80 * escalador * m.sin(m.pi / 6)),
        paint);
    canvas.drawLine(
        Offset(centrox, centroy),
        Offset(centrox + 80 * escalador * m.cos(2 * m.pi / 6),
            centroy + 80 * escalador * m.sin(2 * m.pi / 6)),
        paint);
    canvas.drawLine(
        Offset(centrox, centroy),
        Offset(centrox + 80 * escalador * m.cos(4 * m.pi / 6),
            centroy + 80 * escalador * m.sin(4 * m.pi / 6)),
        paint);
    canvas.drawLine(
        Offset(centrox, centroy),
        Offset(centrox + 80 * escalador * m.cos(5 * m.pi / 6),
            centroy + 80 * escalador * m.sin(5 * m.pi / 6)),
        paint);
    canvas.drawLine(
        Offset(centrox, centroy),
        Offset(centrox + 80 * escalador * m.cos(-m.pi / 6),
            centroy + 80 * escalador * m.sin(-m.pi / 6)),
        paint);
    canvas.drawLine(
        Offset(centrox, centroy),
        Offset(centrox + 80 * escalador * m.cos(-2 * m.pi / 6),
            centroy + 80 * escalador * m.sin(-2 * m.pi / 6)),
        paint);
    canvas.drawLine(
        Offset(centrox, centroy),
        Offset(centrox + 80 * escalador * m.cos(-4 * m.pi / 6),
            centroy + 80 * escalador * m.sin(-4 * m.pi / 6)),
        paint);
    canvas.drawLine(
        Offset(centrox, centroy),
        Offset(centrox + 80 * escalador * m.cos(-5 * m.pi / 6),
            centroy + 80 * escalador * m.sin(-5 * m.pi / 6)),
        paint);
  }

  @override
  bool shouldRepaint(FaceOutlinePainter oldDelegate) => false;
}
