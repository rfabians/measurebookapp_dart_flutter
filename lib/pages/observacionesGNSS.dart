import 'package:flutter/material.dart';
import 'package:measurebookapp/pages/observacionesGNSS/observacionGNSSVertice.dart';


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
                        fontSize: 12.0,
                        color: Color(0xff007FFF),
                        )),
                        TextSpan(text: 'y gestiona tus observaciones GNSS ', style: TextStyle(
                        fontFamily: 'Roboto', 
                        fontSize: 12.0,
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
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) => ObservacionGNSSVertice(
                              )));
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