import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class ObservacionGNSSVertica extends StatefulWidget {
  ObservacionGNSSVertica({Key key}) : super(key: key);

  @override
  _ObservacionGNSSVerticaState createState() => _ObservacionGNSSVerticaState();
}

class _ObservacionGNSSVerticaState extends State<ObservacionGNSSVertica> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              children: <Widget>[
                Image.asset('assets/images/gnss.png'),
                SizedBox(height: 10),
                  RichText(text: TextSpan(
                    children: <TextSpan> [
                    TextSpan(text: 'Crea, continua ', style: TextStyle(
                    fontFamily: 'Roboto', 
                    fontSize: 13.0,
                    color: Color(0xff007FFF),
                    )),
                    TextSpan(text: 'y gestiona tus observaciones GNSS ', style: TextStyle(
                    fontFamily: 'Roboto', 
                    fontSize: 13.0,
                    color: Colors.black54,
                    )),
                  ]
                )),
                SizedBox(height: 20),
                Container(
                    height: 300,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          spreadRadius: 5,
                          blurRadius: 7,
                          color: Colors.black.withOpacity(.05),
                        )
                      ]
                    ),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 10),
                        Text('Determinar Tiempos de Rastreo', style: TextStyle(fontSize: 14.0, color: Color(0xff007FFF),
                        ),),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Image.asset('images/assets/magna-eco.png')
                          ],
                        )
                      ],
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
