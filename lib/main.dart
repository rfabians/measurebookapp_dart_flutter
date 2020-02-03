import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
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
        body: Center(
          child: SingleChildScrollView(
            child: _isLoggedIn
                ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    // Implementación de Interfaz cuando el usuario ya está logeado
                    children: <Widget>[
                      Image.network(_googleSignIn.currentUser.photoUrl, height: 100.0,),
                      SizedBox(height: 10.0,),
                      Text(_googleSignIn.currentUser.email, style: TextStyle(
                        fontFamily: 'Roboto',
                        color: Color(0xff898989),
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
                      })
                    ],
                  ),
                )
              :Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  // Implementación de Interfaz para Login
                  children: <Widget>[
                    Image.asset('assets/logo.png', height: 100,),
                    SizedBox(height: 40.0,),
                    RichText(text: TextSpan(
                      children: <TextSpan> [
                        TextSpan(text: 'Tu Cartera de ', style: TextStyle(
                          fontFamily: 'Roboto',
                          height: 12.0,
                          color: Color(0xff898989),
                        )),
                        TextSpan(text: 'Topografía', style: TextStyle(
                          fontFamily: 'Roboto',
                          color: Color(0xff007FFF),
                          height: 12.0,
                        )),
                        TextSpan(text: ', ahora en tu dispositivo ', style: TextStyle(
                          fontFamily: 'Roboto',
                          color: Color(0xff898989),
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
                    }, child: Image.asset('assets/google.png', height: 50.0,)),
                    SizedBox(height: 40.0,),
                    RichText(text: TextSpan(
                      children: <TextSpan> [
                        TextSpan(text: 'Ingresa a la ', style: TextStyle(
                          fontFamily: 'Roboto',
                          color: Color(0xff898989),
                          height: 12.0,
                        )),
                        TextSpan(text: 'APP ', style: TextStyle(
                          fontFamily: 'Roboto',
                          color: Color(0xff007FFF),
                          height: 12.0,
                        )),
                        TextSpan(text: 'con tu cuenta de ', style: TextStyle(
                          fontFamily: 'Roboto',
                          color: Color(0xff898989),
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