import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
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
    // TODO: implement build
    // Prueba Git
    return MaterialApp(
      home: Scaffold(
        body: Center(
            child: _isLoggedIn
                ? 
                Column(
                    
                    children: <Widget>[
                      Divider(height: 75,),
                      Image.network(_googleSignIn.currentUser.photoUrl, height: 100.0, width: 100.0,),
                      Divider(),
                      Text(_googleSignIn.currentUser.displayName, style: TextStyle(
                        fontFamily: 'Roboto',
                        color: Color(0xff007FFF),
                      ),
                      ),
                      Text(_googleSignIn.currentUser.email, style: TextStyle(
                        fontFamily: 'Roboto',
                        color: Color(0xff898989),
                      ),
                      ),
                      Divider(height: 10.0,),
                      ConstrainedBox(
                        constraints: new BoxConstraints(
                          minHeight: 350,
                          maxHeight: 351,
                        ),
                        child: new ListView(
                          shrinkWrap: true,
                          children: <Widget>[
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Column(
                            children: <Widget>[
                            Image.asset('assets/nuevo.png', height: 50,),
                            Divider(height: 5.0,),
                            Text('Nuevo Proyecto', style: TextStyle(
                              fontFamily: 'Roboto',
                              color: Color(0xff007FFF),
                            ),)
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Image.asset('assets/delta.png', height: 50.0,),
                            Text('Navegar red \npasiva Igac', style: TextStyle(
                              fontFamily: 'Roboto',
                              color: Color(0xff007FFF),
                            ),)
                          ],
                        )
                      ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset('assets/borrar.png', height: 50.0,),
                            Text('Borrar Proyecto', style: TextStyle(
                              fontFamily: 'Roboto',
                              color: Color(0xff007FFF),
                            ),)
                        ],
                      ),
                      Divider(height: 10),
                      FlatButton( child: Text('Cerrar Sesión',style: TextStyle(
                        fontFamily: 'Roboto',
                        color: Colors.white,
                      )
                      ),
                      color: Color(0xff007FFF),
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(15.0)
                      ),
                      onPressed: (){
                        _logout();
                      },)
                    ],
                  )
                : Container(
                  child: ConstrainedBox(
                  constraints: BoxConstraints.expand(),
                  child: FlatButton(
                  onPressed: () {
                    _login();
                  },
                  padding: EdgeInsets.all(0.0),
                  child: 
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Image.asset('assets/logo.png', height: 120.0,),
                      RichText(
                        text: TextSpan(
                          style: DefaultTextStyle.of(context).style,
                          children: <TextSpan> [
                            TextSpan(
                              text: 'Tu cartera de ', style: TextStyle(
                                fontFamily: 'Roboto',
                                color: Color(0xff898989),
                              )
                            ),
                            TextSpan(text: 'Topografía ', style:  TextStyle(
                              fontFamily: 'Roboto',
                              color: Color(0xff007FFF),
                            )),
                            TextSpan(text: 'ahora en tu dispositivo ', style: TextStyle(
                                fontFamily: 'Roboto',
                                color: Color(0xff898989),
                              )
                              ),
                            TextSpan(text: 'Movil', style:  TextStyle(
                              fontFamily: 'Roboto',
                              color: Color(0xff007FFF),
                            )),
                          ],
                        )
                      ),
                      Image.asset('assets/google.png', height: 50.0),
                      RichText(
                        text: TextSpan(
                          style: DefaultTextStyle.of(context).style,
                          children: <TextSpan> [
                            TextSpan(
                              text: 'Ingresa a la ', style: TextStyle(
                                fontFamily: 'Roboto',
                                color: Color(0xff898989),
                              )
                            ),
                            TextSpan(text: 'APP ', style:  TextStyle(
                              fontFamily: 'Roboto',
                              color: Color(0xff007FFF),
                            )),
                            TextSpan(text: 'con tu cuenta de ', style: TextStyle(
                                fontFamily: 'Roboto',
                                color: Color(0xff898989),
                              )
                              ),
                            TextSpan(text: 'Google', style:  TextStyle(
                              fontFamily: 'Roboto',
                              color: Color(0xff007FFF),
                            )),
                          ],
                        )
                      ),
                    ],
                  ),
                  
                  )
                  )  
                  )
                ), 
                ),
      );
  }
}