import 'package:flutter/material.dart';

class NuevoProyecto extends StatelessWidget {
  const NuevoProyecto({Key key}) : super(key: key);
// Git
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FlatButton(
          child: Text('Nuevo Proyecto')
        )
      )
    );
  }
}