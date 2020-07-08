import 'package:flutter/material.dart';

class PoligonalCerradaDatos extends StatefulWidget {
  PoligonalCerradaDatos({Key key}) : super(key: key);

  @override
  _PoligonalCerradaDatosState createState() => _PoligonalCerradaDatosState();
}

class _PoligonalCerradaDatosState extends State<PoligonalCerradaDatos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        hoverColor: Colors.blueAccent,
        child: Icon(Icons.menu, color: Colors.white),
        mini: true,
        onPressed: () {
          print('Boton Navegación');
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: this._barraNavegacionMB(context),
      body: SafeArea(
          child: Container(
        child: Column(
          children: <Widget>[Text('Datos Poligonal Cerrada')],
        ),
      )),
    );
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
              child: Text('      Lecturas poligonal cerrada',
                  style: TextStyle(fontSize: 12, color: Colors.white)),
            ),
          )
        ],
      ),
    );
  }
}
