import 'package:flutter/material.dart';

class MenuPrincipalMB extends StatefulWidget {

final String nombreProyectoMB,ubicacionMB, clienteMB, empresaMB, proyeccionMB, decripcionMB, id_usuario, id_proyeccion;

MenuPrincipalMB({Key key, this.id_usuario, this.nombreProyectoMB, this.proyeccionMB,
this.id_proyeccion, this.ubicacionMB, this.empresaMB, this.clienteMB, this.decripcionMB}) : super (key: key);

  @override
  _MenuPrincipalMBState createState() => _MenuPrincipalMBState();
  }

class _MenuPrincipalMBState extends State<MenuPrincipalMB> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
          children: <Widget>[
            SizedBox(height: 75.0),
            Center(
              child: Image.asset('assets/images/measure.png', height: 80.0,),
            ),
            SizedBox(height: 10,),
            RichText(text: TextSpan(
              children: <TextSpan> [
                TextSpan(text: 'Selecciona ', style: TextStyle(
                fontFamily: 'Roboto', 
                fontSize: 16.0,
                color: Color(0xff007FFF),
                )),
                TextSpan(text: 'el tipo de Actividad que deseas realizar ', style: TextStyle(
                fontFamily: 'Roboto', 
                fontSize: 16.0,
                color: Colors.black54,
                )),
              ]
            )),
            //Gestor de Puntos
            Container(
              padding: EdgeInsets.all(20.0),
              height: 100,
              child: MediaQuery.removePadding(context: context, 
              removeTop: true,
              child: ListView(
                children: <Widget>[
                  ListTile(
                    leading: Image.asset('assets/images/puntos.png'),
                    title: Text('Gestor de Puntos',style: TextStyle(
                    fontFamily: 'Roboto', 
                    fontSize: 16.0,
                    color: Color(0xff007FFF),
                    )),
                    subtitle: Text('Crea y edita los puntos que utilizaras como control en tus mediciones', style: 
                    TextStyle(
                      fontFamily: 'Roboto', 
                      fontSize: 14.0,
                      color: Colors.black54,
                    )),
                    trailing: Icon(Icons.chevron_right, size: 30.0, color: Colors.blueAccent,),
                  )
                ],
              )
              ),
            ),
            //Conversión de Coordenadas
            Container(
              padding: EdgeInsets.all(20.0),
              height: 100,
              child: MediaQuery.removePadding(context: context, 
              removeTop: true,
              child: ListView(
                children: <Widget>[
                  ListTile(
                    leading: Image.asset('assets/images/conversion.png'),
                    title: Text('Conversión de Coordenadas',style: TextStyle(
                    fontFamily: 'Roboto', 
                    fontSize: 16.0,
                    color: Color(0xff007FFF),
                    )),
                    subtitle: Text('Importa y convierte coordenadas en otros sistemas diferentes al de tu proyectos', style: 
                    TextStyle(
                      fontFamily: 'Roboto', 
                      fontSize: 14.0,
                      color: Colors.black54,
                    )),
                    trailing: Icon(Icons.chevron_right, size: 30.0, color: Colors.blueAccent,),
                  )
                ],
              )
              ),
            ),
            // Observaciones GNSS
            Container(
              padding: EdgeInsets.all(20.0),
              height: 100,
              child: MediaQuery.removePadding(context: context, 
              removeTop: true,
              child: ListView(
                children: <Widget>[
                  ListTile(
                    leading: Image.asset('assets/images/gnss.png'),
                    title: Text('Observaciones GNSS',style: TextStyle(
                    fontFamily: 'Roboto', 
                    fontSize: 16.0,
                    color: Color(0xff007FFF),
                    )),
                    subtitle: Text('Crea, Continua y gestionas tus Observaciones GNSS', style: 
                    TextStyle(
                      fontFamily: 'Roboto', 
                      fontSize: 14.0,
                      color: Colors.black54,
                    )),
                    trailing: Icon(Icons.chevron_right, size: 30.0, color: Colors.blueAccent,),
                  )
                ],
              )
              ),
            ),
            // Poligonales
            Container(
              padding: EdgeInsets.all(20.0),
              height: 100,
              child: MediaQuery.removePadding(context: context, 
              removeTop: true,
              child: ListView(
                children: <Widget>[
                  ListTile(
                    leading: Image.asset('assets/images/poligonal.png'),
                    title: Text('Poligonales',style: TextStyle(
                    fontFamily: 'Roboto', 
                    fontSize: 16.0,
                    color: Color(0xff007FFF),
                    )),
                    subtitle: Text('Crea, Continua y gestionas tus Poligonales', style: 
                    TextStyle(
                      fontFamily: 'Roboto', 
                      fontSize: 14.0,
                      color: Colors.black54,
                    )),
                    trailing: Icon(Icons.chevron_right, size: 30.0, color: Colors.blueAccent,),
                  )
                ],
              )
              )
            ),
            //Nivelaciones
            Container(
              padding: EdgeInsets.all(20.0),
              height: 200,
              child: MediaQuery.removePadding(context: context, 
              removeTop: true,
              child: ListView(
                children: <Widget>[
                  ListTile(
                    leading: Image.asset('assets/images/nivelacion.png'),
                    title: Text('Nivelaciones',style: TextStyle(
                    fontFamily: 'Roboto', 
                    fontSize: 16.0,
                    color: Color(0xff007FFF),
                    )),
                    subtitle: Text('Crea, Continua y gestionas tus Nivelaciones geométricas', style: 
                    TextStyle(
                      fontFamily: 'Roboto', 
                      fontSize: 14.0,
                      color: Colors.black54,
                    )),
                    trailing: Icon(Icons.chevron_right, size: 30.0, color: Colors.blueAccent,),
                  )
                ],
              )
              ),
            )
          ],
        ),
        ),
      ),
    );
  }
}