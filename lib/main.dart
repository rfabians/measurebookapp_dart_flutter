import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'pages/proyecto_nuevo.dart';

void main() => runApp(MeasureBookAPP());

//
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
        backgroundColor: Color(0xff292929),
        body: Center(
          child: SingleChildScrollView(
            child: _isLoggedIn
                ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    // Implementación de Interfaz cuando el usuario ya está logeado
                    children: <Widget>[
                      SizedBox (height: 50.0),
                      Image.network(_googleSignIn.currentUser.photoUrl, height: 100.0,),
                      SizedBox(height: 10.0,),
                      Text(_googleSignIn.currentUser.email, style: TextStyle(
                        fontFamily: 'Roboto',
                        color: Color(0xffBEBEBE),
                        fontSize: 14.0,
                      ),),
                      SizedBox(height: 10.0,),
                      Text(_googleSignIn.currentUser.displayName, style: TextStyle(
                        fontFamily: 'Roboto',
                        color: Color(0xff007FFF),
                        fontSize: 15.0,
                      ),),
                      SizedBox(height: 20.0,),
                      Divider(),
                      Container(
                        height: 400,
                        child: ListView(

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
                        child: Text('Nueva Pantalla', style: TextStyle(
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
                          color: Color(0xffBEBEBE),
                        )),
                        TextSpan(text: 'Topografía', style: TextStyle(
                          fontFamily: 'Roboto',
                          color: Color(0xff007FFF),
                          height: 12.0,
                        )),
                        TextSpan(text: ', ahora en tu dispositivo ', style: TextStyle(
                          fontFamily: 'Roboto',
                          color: Color(0xffBEBEBE),
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
                          color: Color(0xffBEBEBE),
                          height: 12.0,
                        )),
                        TextSpan(text: 'APP ', style: TextStyle(
                          fontFamily: 'Roboto',
                          color: Color(0xff007FFF),
                          height: 12.0,
                        )),
                        TextSpan(text: 'con tu cuenta de ', style: TextStyle(
                          fontFamily: 'Roboto',
                          color: Color(0xffBEBEBE),
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
