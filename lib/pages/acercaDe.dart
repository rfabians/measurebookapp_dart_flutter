import 'package:flutter/material.dart';

class AcercaDe extends StatefulWidget {
  AcercaDe({Key key}) : super(key: key);

  @override
  _AcercaDeState createState() => _AcercaDeState();
}

class _AcercaDeState extends State<AcercaDe> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Image.asset(
                  'assets/images/ud.png',
                  height: 200.0,
                ),
                Divider(),
                Text(
                  'Facultad de Medio Ambiente y Recursos Naturales',
                  style: TextStyle(fontSize: 14),
                ),
                Divider(),
                Text(
                  'Ingenería Topográfica',
                  style: TextStyle(fontSize: 14),
                ),
                Divider(),
                Text(
                  'Proyecto de Grado para Optar por el titulo de Ingeniero Topográfico',
                  style: TextStyle(fontSize: 14),
                ),
                Divider(
                  height: 50,
                ),
                Text(
                  'Director: MSc. Ing. Evelio Madera Arteaga',
                  style: TextStyle(fontSize: 14),
                ),
                Divider(),
                Text(
                  'elmaderaa@correo.udistrital.edu.co',
                  style: TextStyle(fontSize: 14, color: Colors.blueAccent),
                ),
                Divider(),
                Text(
                  'Estudiante: Layda Yaneth Gil Angel',
                  style: TextStyle(fontSize: 14),
                ),
                Divider(),
                Text(
                  'lygila@correo.udistrital.edu.co',
                  style: TextStyle(fontSize: 14, color: Colors.blueAccent),
                ),
                Text(
                  'Estudiante: Rafael Fabian Sanchez Osorio',
                  style: TextStyle(fontSize: 14),
                ),
                Divider(),
                Text(
                  'rfsanchezo@correo.udistrital.edu.co',
                  style: TextStyle(fontSize: 14, color: Colors.blueAccent),
                ),
                Divider(
                  height: 50,
                ),
                Text(
                  'OCTUBRE 2020',
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
