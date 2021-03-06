import 'package:flutter/material.dart';
import 'package:measurebookapp/modelos/proyectos.dart';

class Nivelaciones extends StatefulWidget {
  final proyectos datosproyecto;
  Nivelaciones({Key key, this.datosproyecto}) : super(key: key);

  @override
  _NivelacionesState createState() => _NivelacionesState();
}

class _NivelacionesState extends State<Nivelaciones> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Column(
                children: <Widget>[
                  Image.asset('assets/images/nivelacion.png', height: 100),
                  SizedBox(height: 10),
                  Text(
                    'Nivelaciones',
                    style: TextStyle(color: Colors.blueAccent, fontSize: 16),
                  ),
                  Divider(
                    height: 10,
                  ),
                  ListTile(
                    title: Text(
                      'Alturas Niveladas IGAC',
                      style: TextStyle(color: Colors.blueAccent, fontSize: 16),
                    ),
                    subtitle: Text(
                      'Visualiza los puntos que poseen altura nivelada por IGAC',
                      style: TextStyle(color: Colors.black54),
                    ),
                    leading: Image.asset('assets/images/measure.png'),
                    trailing: Icon(Icons.chevron_right,
                        color: Colors.blueAccent, size: 40.0),
                    onTap: () {},
                  ),
                  Divider(height: 10),
                  ListTile(
                    title: Text(
                      'Nivelación Geométrica',
                      style: TextStyle(color: Colors.blueAccent, fontSize: 16),
                    ),
                    subtitle: Text(
                      'Realiza nivelaciones geométricas',
                      style: TextStyle(color: Colors.black54),
                    ),
                    leading: Image.asset('assets/images/nivelacion_.png'),
                    trailing: Icon(Icons.chevron_right,
                        color: Colors.blueAccent, size: 40.0),
                  ),
                  ListTile(
                    title: Text(
                      'Nivelación Trigonométrica',
                      style: TextStyle(color: Colors.blueAccent, fontSize: 16),
                    ),
                    subtitle: Text(
                      'Realiza nivelaciones trigonométricas',
                      style: TextStyle(color: Colors.black54),
                    ),
                    leading: Image.asset('assets/images/nivelacion_.png'),
                    trailing: Icon(Icons.chevron_right,
                        color: Colors.blueAccent, size: 40.0),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
