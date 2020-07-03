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
  double _degrees = 0.0;
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
    gyroscopeEvents.listen((event) {
      setState(() {
        dX = event.x;
        dY = event.y;
        dZ = event.z;
      });
    });
    _initApp();
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
        _degrees = value;
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
                  Icon(Icons.assignment, size: 60, color: Colors.black54),
                  Divider(),
                  Text('Diagrama de Obstaculos',
                      style: TextStyle(color: Colors.blueAccent, fontSize: 12)),
                  Divider(),
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
                                        'Azimut: ${roundDouble(_degrees, 1)}',
                                        style: TextStyle(
                                            color: Colors.blueAccent,
                                            fontSize: 12),
                                      ),
                                      Text(
                                        'Angulo Vertical: ${roundDouble(_degrees, 1)}',
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
                  Text('${roundDouble(_degrees, 1)}')
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }
}
