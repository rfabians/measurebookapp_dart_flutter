import 'package:flutter/material.dart';



class ObservacionGNSSVertice extends StatefulWidget {
  ObservacionGNSSVertice({Key key}) : super(key: key);

  @override
  _ObservacionGNSSVerticeState createState() => _ObservacionGNSSVerticeState();
}

class _ObservacionGNSSVerticeState extends State<ObservacionGNSSVertice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: SafeArea(
         child: SingleChildScrollView(
           child: Column(
             children: <Widget>[
               Text('Hola Mundo')
             ],
           ),
         )
         ),
    );
  }
}