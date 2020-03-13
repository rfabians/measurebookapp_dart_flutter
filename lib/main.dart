import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:measurebookapp/clases/database.dart';
import 'package:path_provider/path_provider.dart';
import 'pages/proyecto_nuevo.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() => runApp(MeasureBookAPP());

gestorMBDatabase datos = datos.mbBasedeDatos();

class MeasureBookAPP extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Iniciar Sesion',
      home: IniciarSesion(),
    );
  }
}

class IniciarSesion extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}
// Importación de base de Datos

class _MyAppState extends State<IniciarSesion> {
  bool _isLoggedIn = false;
  String idUser = '/*/';

  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  _login() async{
    try{
      await _googleSignIn.signIn();
      setState(() {
        _isLoggedIn = true;
        idUser = _googleSignIn.currentUser.id;
        //print(idUser);

      });
    } catch (err){
      print(err);
    }
  }

  _logout(){
    _googleSignIn.signOut();
    setState(() {
      _isLoggedIn = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SingleChildScrollView(
            child: _isLoggedIn
                ? Center(

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    // Implementación de Interfaz cuando el usuario ya está logeado
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox (width: 30.0),
                          Image.network(_googleSignIn.currentUser.photoUrl, height: 75.0,),
                          SizedBox(width: 20.0,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(_googleSignIn.currentUser.displayName, style: TextStyle(
                                fontFamily: 'Roboto',
                                color: Color(0xff007FFF),
                                fontSize: 15.0,
                              ),),
                              SizedBox(height: 5.0,),
                              Text(_googleSignIn.currentUser.email, style: TextStyle(
                                fontFamily: 'Roboto',
                                color: Colors.black54,
                                fontSize: 14.0,
                              ),
                              )
                            ],
                          )
                      ]),

                      SizedBox(height: 5.0,),
                      Divider(),
                      Container(
                        child: Container(
                        height: 400,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        child: Swiper(

                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),

                                image: new DecorationImage(image: new AssetImage("assets/images/fondoblackbogota.jpg"), fit: BoxFit.cover,),
                              ),
                              child: Center(
                                child: Column(
                                  children: <Widget>[
                                    Text('NombreProyecto', style: TextStyle(
                                      fontFamily: 'Roboto',
                                      color: Color(0xff007FFF),
                                      fontSize: 20.0,
                                    ),
                                    ),

                                  ],
                                ),
                              ),
                            );
                          },
                          itemCount: 10,
                          viewportFraction: 0.8,
                          scale: 0.9,
                        ),
                      ),
                      ),
                      Divider(),
                      FlatButton(
                        shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                        child: Text('Cerrar Sesión', style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 13.0,
                          color: Colors.white,
                        ),),
                        color: Color(0xff007FFF),
                        onPressed: (){
                        _logout();
                      }),
                      FlatButton(
                        shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                        child: Text('Nuevo proyecto', style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 13.0,
                          color: Colors.white,
                        ),),
                        color: Color(0xff007FFF),
                        onPressed: (){

                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) => NuevoProyecto(),
                          ));
                      })
                    ],
                    
                  ),
                )
              :Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  // Implementación de Interfaz para Login
                  children: <Widget>[
                    Image.asset('assets/images/logo.png', height: 100,),
                    SizedBox(height: 40.0,),
                    RichText(text: TextSpan(
                      children: <TextSpan> [
                        TextSpan(text: 'Tu Cartera de ', style: TextStyle(
                          fontFamily: 'Roboto',
                          height: 12.0,
                          color: Colors.black54,
                        )),
                        TextSpan(text: 'Topografía', style: TextStyle(
                          fontFamily: 'Roboto',
                          color: Color(0xff007FFF),
                          height: 12.0,
                        )),
                        TextSpan(text: ', ahora en tu dispositivo ', style: TextStyle(
                          fontFamily: 'Roboto',
                          color: Colors.black54,
                          height: 12.0,
                        )),
                        TextSpan(text: 'Movil', style: TextStyle(
                          fontFamily: 'Roboto',
                          color: Color(0xff007FFF),
                          height: 12.0,
                        ))
                      ]
                    )),
                    SizedBox(height: 40.0,),
                    FlatButton(onPressed: (){
                      _login();
                    }, child: Image.asset('assets/images/google.png', height: 50.0,)),
                    SizedBox(height: 40.0,),
                    RichText(text: TextSpan(
                      children: <TextSpan> [
                        TextSpan(text: 'Ingresa a la ', style: TextStyle(
                          fontFamily: 'Roboto',
                          color: Colors.black54,
                          height: 12.0,
                        )),
                        TextSpan(text: 'APP ', style: TextStyle(
                          fontFamily: 'Roboto',
                          color: Color(0xff007FFF),
                          height: 12.0,
                        )),
                        TextSpan(text: 'con tu cuenta de ', style: TextStyle(
                          fontFamily: 'Roboto',
                          color: Colors.black54,
                          height: 12.0,
                        )),
                        TextSpan(text: 'Google', style: TextStyle(
                          fontFamily: 'Roboto',
                          color: Color(0xff007FFF),
                          height: 12.0,
                        ))
                      ]
                    )),
                  ],
                ),
              )
          )
        )
      )
    );
  }
}

