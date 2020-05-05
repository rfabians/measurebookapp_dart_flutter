import 'package:flutter/material.dart';

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
           padding: const EdgeInsets.all(15.0),
           child: SingleChildScrollView(
             child: Center(
               child: Column(
                 children: <Widget>[
                   Image.asset('assets/images/delta.png', height: 60.0, alignment: Alignment.center),
                   SizedBox(height: 5.0),
                   Text('Observaciones GNSS de vertices geodesicos', style: TextStyle(fontFamily: 'Roboto',color: Colors.black54 ,fontSize: 14,)),
                   Divider(height: 20),
                   ListTile(
                      leading: Image.asset('assets/images/puntos.png'),
                      title: Text('Tiempos de Rastreo red MAGNA ECO',style: TextStyle(
                      fontFamily: 'Roboto', 
                      fontSize: 13.0,
                      color: Color(0xff007FFF),
                      )),
                      subtitle: Text('Cálcula los tiempos de rastreo utilizando como puntos de referencia las estaciones de rastreo continuo del IGAC', style: 
                      TextStyle(
                        fontFamily: 'Roboto', 
                        fontSize: 12.0,
                        color: Colors.black54,
                      )),
                      trailing: Icon(Icons.chevron_right, size: 30.0, color: Colors.blueAccent,),
                      onTap: () {/*
                        Navigator.push(context, MaterialPageRoute(
                        builder: (context) => GestosPuntos(
                          idUser: widget.id_usuario,
                          idProyeccion: widget.id_proyeccion,
                          nombreProyecto: widget.nombreProyectoMB,
                          proyeccionMB: widget.proyeccionMB,
                        )));*/
                      },
                    ),
                    Divider(height: 20),
                   ListTile(
                      leading: Image.asset('assets/images/puntos.png'),
                      title: Text('Tiempos de Rastreo red GEORED',style: TextStyle(
                      fontFamily: 'Roboto', 
                      fontSize: 13.0,
                      color: Color(0xff007FFF),
                      )),
                      subtitle: Text('Cálcula los tiempos de rastreo utilizando como puntos de referencia las estaciones de rastreo continuo del Servicio Geologico Nacional', style: 
                      TextStyle(
                        fontFamily: 'Roboto', 
                        fontSize: 12.0,
                        color: Colors.black54,
                      )),
                      trailing: Icon(Icons.chevron_right, size: 30.0, color: Colors.blueAccent,),
                      onTap: () {/*
                        Navigator.push(context, MaterialPageRoute(
                        builder: (context) => GestosPuntos(
                          idUser: widget.id_usuario,
                          idProyeccion: widget.id_proyeccion,
                          nombreProyecto: widget.nombreProyectoMB,
                          proyeccionMB: widget.proyeccionMB,
                        )));*/
                      },
                    ),
                    Divider(height: 20),
                   ListTile(
                      leading: Image.asset('assets/images/puntos.png'),
                      title: Text('Tiempos de Rastreo red Pasiva IGAC',style: TextStyle(
                      fontFamily: 'Roboto', 
                      fontSize: 13.0,
                      color: Color(0xff007FFF),
                      )),
                      subtitle: Text('Cálcula los tiempos de rastreo utilizando como puntos de referencia los puntos pertenecientes a la red pasiva del IGAC', style: 
                      TextStyle(
                        fontFamily: 'Roboto', 
                        fontSize: 12.0,
                        color: Colors.black54,
                      )),
                      trailing: Icon(Icons.chevron_right, size: 30.0, color: Colors.blueAccent,),
                      onTap: () {/*
                        Navigator.push(context, MaterialPageRoute(
                        builder: (context) => GestosPuntos(
                          idUser: widget.id_usuario,
                          idProyeccion: widget.id_proyeccion,
                          nombreProyecto: widget.nombreProyectoMB,
                          proyeccionMB: widget.proyeccionMB,
                        )));*/
                      },
                    ),
                    Divider(height: 20),
                    ListTile(
                      leading: Image.asset('assets/images/puntos.png'),
                      title: Text('Tiempos de Rastreo puntos de Referencia',style: TextStyle(
                      fontFamily: 'Roboto', 
                      fontSize: 13.0,
                      color: Color(0xff007FFF),
                      )),
                      subtitle: Text('Cálcula los tiempos de rastreo utilizando como puntos de referencia los puntos guardados dentro de tu proyecto', style: 
                      TextStyle(
                        fontFamily: 'Roboto', 
                        fontSize: 12.0,
                        color: Colors.black54,
                      )),
                      trailing: Icon(Icons.chevron_right, size: 30.0, color: Colors.blueAccent,),
                      onTap: () {/*
                        Navigator.push(context, MaterialPageRoute(
                        builder: (context) => GestosPuntos(
                          idUser: widget.id_usuario,
                          idProyeccion: widget.id_proyeccion,
                          nombreProyecto: widget.nombreProyectoMB,
                          proyeccionMB: widget.proyeccionMB,
                        )));*/
                      },
                    ),
                    Divider(height: 20),
                    ListTile(
                      leading: Image.asset('assets/images/puntos.png'),
                      title: Text('Ocupación de Punto',style: TextStyle(
                      fontFamily: 'Roboto', 
                      fontSize: 13.0,
                      color: Color(0xff007FFF),
                      )),
                      subtitle: Text('Genera la hoja de campo de la ocupación de un punto', style: 
                      TextStyle(
                        fontFamily: 'Roboto', 
                        fontSize: 12.0,
                        color: Colors.black54,
                      )),
                      trailing: Icon(Icons.chevron_right, size: 30.0, color: Colors.blueAccent,),
                      onTap: () {/*
                        Navigator.push(context, MaterialPageRoute(
                        builder: (context) => GestosPuntos(
                          idUser: widget.id_usuario,
                          idProyeccion: widget.id_proyeccion,
                          nombreProyecto: widget.nombreProyectoMB,
                          proyeccionMB: widget.proyeccionMB,
                        )));*/
                      },
                    ),
                    Divider(height: 20),
                    ListTile(
                      leading: Image.asset('assets/images/puntos.png'),
                      title: Text('Descripción de Punto',style: TextStyle(
                      fontFamily: 'Roboto', 
                      fontSize: 13.0,
                      color: Color(0xff007FFF),
                      )),
                      subtitle: Text('Genera la desripción de un vertice posicionado', style: 
                      TextStyle(
                        fontFamily: 'Roboto', 
                        fontSize: 12.0,
                        color: Colors.black54,
                      )),
                      trailing: Icon(Icons.chevron_right, size: 30.0, color: Colors.blueAccent,),
                      onTap: () {/*
                        Navigator.push(context, MaterialPageRoute(
                        builder: (context) => GestosPuntos(
                          idUser: widget.id_usuario,
                          idProyeccion: widget.id_proyeccion,
                          nombreProyecto: widget.nombreProyectoMB,
                          proyeccionMB: widget.proyeccionMB,
                        )));*/
                      },
                    )
                 ],
               ),
             )
             ),
         )
         )
    );
  }
}