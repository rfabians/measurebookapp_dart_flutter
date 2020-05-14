import 'package:flutter/material.dart';
import 'package:measurebookapp/pages/observacionGNSSVertice.dart';
import 'observacionGNSSFotocontrol.dart';

class ObservacionesGNSS extends StatefulWidget {
  ObservacionesGNSS({Key key}) : super(key: key);

  @override
  _ObservacionesGNSSState createState() => _ObservacionesGNSSState();
}

class _ObservacionesGNSSState extends State<ObservacionesGNSS> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Image.asset('assets/images/gnss.png', height: 80.0),
                      SizedBox(height: 10),
                      RichText(text: TextSpan(
                        children: <TextSpan> [
                        TextSpan(text: 'Crea, continua ', style: TextStyle(
                        fontFamily: 'Roboto', 
                        fontSize: 16.0,
                        color: Color(0xff007FFF),
                        )),
                        TextSpan(text: 'y gestiona tus observaciones GNSS ', style: TextStyle(
                        fontFamily: 'Roboto', 
                        fontSize: 16.0,
                        color: Colors.black54,
                        )),
                      ]
                    )),
                    SizedBox(height: 10),
                    Divider(height: 5.0),
                    Container(
                      height: MediaQuery.of(context).size.height*0.68,
                      child: SingleChildScrollView(
                      child: Text('Hola Mundo')
                      ),
                    ),
                    Divider(height: 5.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        FlatButton(
                          shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20.0)),
                          child: Text('Nueva Observación', style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 12.0,
                            color: Colors.white,
                          ),),
                          color: Color(0xff007FFF),
                          onPressed: (){
                            AlertDialog opcionesObservacionGNSS = AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)
                              ),
                              content: Container(
                                height: MediaQuery.of(context).size.height*.3,
                                width: MediaQuery.of(context).size.width,
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: <Widget>[
                                      Text('Seleccione el tipo de \n Observación que desea realizar', style: TextStyle(color: Colors.blueAccent, fontSize: 13), textAlign: TextAlign.center,),
                                      Divider(height: 20),
                                      ListTile(
                                        leading: Image.asset('assets/images/puntos.png'),
                                        title: Text('Vertice Geodésico',style: TextStyle(
                                        fontFamily: 'Roboto', 
                                        fontSize: 13.0,
                                        color: Color(0xff007FFF),
                                        )),
                                        subtitle: Text('Descripción de vertices Geodésicos', style: 
                                        TextStyle(
                                          fontFamily: 'Roboto', 
                                          fontSize: 12.0,
                                          color: Colors.black54,
                                        )),
                                        trailing: Icon(Icons.chevron_right, size: 30.0, color: Colors.blueAccent,),
                                        onTap: () {
                                          Navigator.push(context, MaterialPageRoute(
                                          builder: (context) => ObservacionGNSSVertica(
                                          )));
                                          Navigator.of(context, rootNavigator: true).pop();
                                        },
                                      ),
                                      Divider(height: 20),
                                      ListTile(
                                        leading: Image.asset('assets/images/puntos.png'),
                                        title: Text('Punto de Fotocontrol',style: TextStyle(
                                        fontFamily: 'Roboto', 
                                        fontSize: 13.0,
                                        color: Color(0xff007FFF),
                                        )),
                                        subtitle: Text('Descripción de Puntos de Fotocontrol', style: 
                                        TextStyle(
                                          fontFamily: 'Roboto', 
                                          fontSize: 12.0,
                                          color: Colors.black54,
                                        )),
                                        trailing: Icon(Icons.chevron_right, size: 30.0, color: Colors.blueAccent,),
                                        onTap: () {
                                          Navigator.push(context, MaterialPageRoute(
                                          builder: (context) => ObservacionGNSSFotocontrol(
                                          )));
                                          Navigator.of(context, rootNavigator: true).pop();
                                        },
                                      )
                                    ],
                                  )
                                ),
                              ),
                            );
                          showDialog(context: context, barrierDismissible: true, builder: (BuildContext context){
                            return opcionesObservacionGNSS;
                            });
                        }),
                        SizedBox(width: 20),
                        FlatButton(
                          shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20.0)),
                          child: Text('Borrar Observación', style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 12.0,
                            color: Colors.white,
                          ),),
                          color: Color(0xff007FFF),
                          onPressed: (){
                            
                        }),
                      ],
                    ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
    );
  }
}