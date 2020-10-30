import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:measurebookapp/clases/database.dart';
import 'package:measurebookapp/modelos/proyectos.dart';
import 'package:measurebookapp/modelos/usuario.dart';
import 'package:measurebookapp/pages/acercaDe.dart';
import 'package:measurebookapp/pages/menuPrincipal.dart';
import 'pages/proyecto_nuevo.dart';
import 'pages/menuPrincipal.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:measurebookapp/pages/redPasivaIGAC.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MeasureBookAPP());
}

gestorMBDatabase datos = datos.mbBasedeDatos();

class MeasureBookAPP extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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

class _MyAppState extends State<IniciarSesion> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Center(
                  child: SingleChildScrollView(
                      child: Container(
                child: Column(
                  // Implementación Pantalla Inicial
                  children: <Widget>[
                    Image.asset(
                      'assets/images/logo.png',
                      height: 80,
                    ),
                    RichText(
                        text: TextSpan(children: <TextSpan>[
                      TextSpan(
                          text: 'Utiliza la red Geodesica del ',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            height: 12.0,
                            color: Colors.black54,
                          )),
                      TextSpan(
                          text: 'IGAC ',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            color: Color(0xff007FFF),
                            height: 12.0,
                          )),
                      TextSpan(
                          text: 'y convierte tus Coordenadas',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            color: Colors.black54,
                            height: 12.0,
                          )),
                    ])),
                    FlatButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MenuPrincipalMB()));
                        },
                        child: Container(
                          child: Column(
                            children: [
                              Icon(
                                Icons.navigate_next,
                                color: Colors.blueAccent,
                                size: 80,
                              ),
                              Text(
                                'Ingresar a la APP',
                                style: TextStyle(
                                    fontFamily: 'Roboto',
                                    color: Colors.black54,
                                    height: 12),
                              ),
                            ],
                          ),
                        )),
                    FlatButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AcercaDe()));
                        },
                        child: Text(
                          'Acerca de ...',
                          style: TextStyle(
                              fontFamily: 'Roboto',
                              color: Colors.blueAccent,
                              height: 14),
                        ))
                  ],
                ),
              ))),
            )));
  }
}
