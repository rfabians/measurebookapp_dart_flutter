import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:measurebookapp/clases/database.dart';
import 'package:measurebookapp/modelos/proyectos.dart';
import 'package:measurebookapp/modelos/usuario.dart';
import 'package:measurebookapp/pages/menuPrincipal.dart';
import 'pages/proyecto_nuevo.dart';
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
  bool _isLoggedIn = false;
  String idUser = '/*/';
  Usuario usuario = Usuario();

  GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);

  login() async {
    try {
      await googleSignIn.signIn();
      gestorMBDatabase.db.InserDataSQL(
          "INSERT INTO USUARIOS (ID_GOOGLE_USER, NOMBRE_USER, FOTO_URL, EMAIL_USER) VALUES ('${googleSignIn.currentUser.id}', '${googleSignIn.currentUser.displayName}', '${googleSignIn.currentUser.photoUrl}', '${googleSignIn.currentUser.email}')");
      setState(() {
        _isLoggedIn = true;
        idUser = googleSignIn.currentUser.id;
        usuario.ID_GOOGLE_USER = googleSignIn.currentUser.id;
        usuario.EMAIL_USER = googleSignIn.currentUser.email;
        usuario.FOTO_URL = googleSignIn.currentUser.photoUrl;
        usuario.NOMBRE_USER = googleSignIn.currentUser.displayName;
      });
    } catch (err) {
      print(err);
    }
  }

  logout() {
    googleSignIn.signOut();
    setState(() {
      _isLoggedIn = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Center(
                  child: SingleChildScrollView(
                      child: _isLoggedIn
                          ? Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                // Implementación de Interfaz cuando el usuario ya está logeado
                                children: <Widget>[
                                  Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        SizedBox(width: 15.0),
                                        Image.network(
                                          googleSignIn.currentUser.photoUrl,
                                          height: 75.0,
                                        ),
                                        SizedBox(
                                          width: 20.0,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              googleSignIn
                                                  .currentUser.displayName,
                                              style: TextStyle(
                                                fontFamily: 'Roboto',
                                                color: Color(0xff007FFF),
                                                fontSize: 15.0,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5.0,
                                            ),
                                            Text(
                                              googleSignIn.currentUser.email,
                                              style: TextStyle(
                                                fontFamily: 'Roboto',
                                                color: Colors.black54,
                                                fontSize: 14.0,
                                              ),
                                            )
                                          ],
                                        )
                                      ]),
                                  Container(
                                    child: Container(
                                      height: 460,
                                      child: Scaffold(
                                        body: FutureBuilder<List<proyectos>>(
                                            future: gestorMBDatabase.db
                                                .getProyectos(),
                                            builder: (BuildContext context,
                                                AsyncSnapshot<List<proyectos>>
                                                    snapshot) {
                                              if (snapshot.hasData) {
                                                if (snapshot.data.length == 0) {
                                                  return Center(
                                                    child: Container(
                                                      height: 450,
                                                      child: FlareActor(
                                                        'assets/images/sin_proyectos.flr',
                                                        animation:
                                                            'Search location',
                                                      ),
                                                    ),
                                                  );
                                                } else {
                                                  if (snapshot.data.length >
                                                      1) {
                                                    return Swiper(
                                                        loop: false,
                                                        itemCount: snapshot
                                                            .data.length,
                                                        itemWidth: 280.0,
                                                        layout: SwiperLayout
                                                            .DEFAULT,
                                                        pagination:
                                                            SwiperPagination(
                                                                builder:
                                                                    SwiperPagination
                                                                        .dots),
                                                        itemBuilder:
                                                            (BuildContext
                                                                    context,
                                                                int index) {
                                                          proyectos
                                                              listaProyectos =
                                                              snapshot
                                                                  .data[index];
                                                          return Center(
                                                              child: Container(
                                                            width: 280.0,
                                                            height: 430.0,
                                                            decoration:
                                                                BoxDecoration(
                                                              image:
                                                                  DecorationImage(
                                                                image: AssetImage(
                                                                    'assets/images/fondo_sistemas.png'),
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          25.0)),
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  color: Colors
                                                                      .black
                                                                      .withOpacity(
                                                                          .5),
                                                                  blurRadius:
                                                                      5.0,
                                                                  spreadRadius:
                                                                      3.0,
                                                                  offset:
                                                                      Offset(
                                                                    8.0,
                                                                    30.0,
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                            child:
                                                                SingleChildScrollView(
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        5.0),
                                                                child: Column(
                                                                  children: <
                                                                      Widget>[
                                                                    Text(
                                                                      '${listaProyectos.Nombre_Proyecto}',
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              'Roboto',
                                                                          color: Colors
                                                                              .white,
                                                                          fontSize:
                                                                              16.0),
                                                                    ),
                                                                    SizedBox(
                                                                        height:
                                                                            30.0),
                                                                    Text(
                                                                        'Datos del Proyecto',
                                                                        style: TextStyle(
                                                                            fontFamily:
                                                                                'Roboto',
                                                                            color:
                                                                                Colors.blueAccent,
                                                                            fontSize: 16.0)),
                                                                    Divider(),
                                                                    Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .centerLeft,
                                                                      child: RichText(
                                                                          text: TextSpan(children: <TextSpan>[
                                                                        TextSpan(
                                                                            text:
                                                                                'Ubicación: \n',
                                                                            style: TextStyle(
                                                                                fontFamily: 'Roboto',
                                                                                color: Colors.black54,
                                                                                fontSize: 12.0)),
                                                                        TextSpan(
                                                                            text:
                                                                                '${listaProyectos.Ubicacion}',
                                                                            style: TextStyle(
                                                                                fontFamily: 'Roboto',
                                                                                color: Color(0xff007FFF),
                                                                                fontSize: 12.0))
                                                                      ])),
                                                                    ),
                                                                    Divider(),
                                                                    Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .centerLeft,
                                                                      child: RichText(
                                                                          text: TextSpan(children: <TextSpan>[
                                                                        TextSpan(
                                                                            text:
                                                                                'Descripción: \n',
                                                                            style: TextStyle(
                                                                                fontFamily: 'Roboto',
                                                                                color: Colors.black54,
                                                                                fontSize: 12.0)),
                                                                        TextSpan(
                                                                            text:
                                                                                '${listaProyectos.Descripcion}',
                                                                            style: TextStyle(
                                                                                fontFamily: 'Roboto',
                                                                                color: Color(0xff007FFF),
                                                                                fontSize: 12.0))
                                                                      ])),
                                                                    ),
                                                                    Divider(),
                                                                    Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .centerLeft,
                                                                      child: RichText(
                                                                          text: TextSpan(children: <TextSpan>[
                                                                        TextSpan(
                                                                            text:
                                                                                'Cliente: \n',
                                                                            style: TextStyle(
                                                                                fontFamily: 'Roboto',
                                                                                color: Colors.black54,
                                                                                fontSize: 12.0)),
                                                                        TextSpan(
                                                                            text:
                                                                                '${listaProyectos.Cliente}',
                                                                            style: TextStyle(
                                                                                fontFamily: 'Roboto',
                                                                                color: Color(0xff007FFF),
                                                                                fontSize: 12.0))
                                                                      ])),
                                                                    ),
                                                                    Divider(),
                                                                    Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .centerLeft,
                                                                      child: RichText(
                                                                          text: TextSpan(children: <TextSpan>[
                                                                        TextSpan(
                                                                            text:
                                                                                'Empresa: \n',
                                                                            style: TextStyle(
                                                                                fontFamily: 'Roboto',
                                                                                color: Colors.black54,
                                                                                fontSize: 12.0)),
                                                                        TextSpan(
                                                                            text:
                                                                                '${listaProyectos.Empresa}',
                                                                            style: TextStyle(
                                                                                fontFamily: 'Roboto',
                                                                                color: Color(0xff007FFF),
                                                                                fontSize: 12.0))
                                                                      ])),
                                                                    ),
                                                                    Divider(),
                                                                    Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .centerLeft,
                                                                      child: RichText(
                                                                          text: TextSpan(children: <TextSpan>[
                                                                        TextSpan(
                                                                            text:
                                                                                'Proyeccion: \n',
                                                                            style: TextStyle(
                                                                                fontFamily: 'Roboto',
                                                                                color: Colors.black54,
                                                                                fontSize: 12.0)),
                                                                        TextSpan(
                                                                            text:
                                                                                '${listaProyectos.Tipo_Proyeccion}',
                                                                            style: TextStyle(
                                                                                fontFamily: 'Roboto',
                                                                                color: Color(0xff007FFF),
                                                                                fontSize: 12.0))
                                                                      ])),
                                                                    ),
                                                                    Divider(),
                                                                    Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .centerLeft,
                                                                      child: RichText(
                                                                          text: TextSpan(children: <TextSpan>[
                                                                        TextSpan(
                                                                            text:
                                                                                'Nombre Origen: \n',
                                                                            style: TextStyle(
                                                                                fontFamily: 'Roboto',
                                                                                color: Colors.black54,
                                                                                fontSize: 12.0)),
                                                                        TextSpan(
                                                                            text:
                                                                                '${listaProyectos.ID_Proyeccion}',
                                                                            style: TextStyle(
                                                                                fontFamily: 'Roboto',
                                                                                color: Color(0xff007FFF),
                                                                                fontSize: 12.0))
                                                                      ])),
                                                                    ),
                                                                    Divider(),
                                                                    FlatButton(
                                                                        onPressed:
                                                                            () {
                                                                          proyectos
                                                                              datosProyecto =
                                                                              proyectos();
                                                                          datosProyecto =
                                                                              listaProyectos;
                                                                          Navigator.push(
                                                                              context,
                                                                              MaterialPageRoute(
                                                                                builder: (context) => MenuPrincipalMB(
                                                                                  datosProyecto: datosProyecto,
                                                                                ),
                                                                              ));
                                                                        },
                                                                        child:
                                                                            Column(
                                                                          children: <
                                                                              Widget>[
                                                                            Image.asset(
                                                                              'assets/images/seleccionar.png',
                                                                              height: 40,
                                                                            ),
                                                                            Text('Seleccionar',
                                                                                style: TextStyle(color: Colors.blueAccent, fontSize: 14))
                                                                          ],
                                                                        ))
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ));
                                                        });
                                                  } else {
                                                    // Interfaz para cuando solo se tiene un proyecto creado
                                                    return Swiper(
                                                        pagination:
                                                            SwiperPagination(
                                                                builder:
                                                                    SwiperPagination
                                                                        .dots),
                                                        loop: false,
                                                        itemCount: snapshot
                                                            .data.length,
                                                        itemBuilder:
                                                            (BuildContext
                                                                    context,
                                                                int index) {
                                                          proyectos
                                                              listaProyectos =
                                                              snapshot
                                                                  .data[index];
                                                          return Center(
                                                              child: Container(
                                                            width: 280.0,
                                                            height: 420.0,
                                                            decoration:
                                                                BoxDecoration(
                                                              image:
                                                                  DecorationImage(
                                                                image: AssetImage(
                                                                    'assets/images/fondo_sistemas.png'),
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          25.0)),
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  color: Colors
                                                                      .black45,
                                                                  blurRadius:
                                                                      5.0, // has the effect of softening the shadow
                                                                  spreadRadius:
                                                                      3.0, // has the effect of extending the shadow
                                                                  offset:
                                                                      Offset(
                                                                    10.0, // horizontal, move right 10
                                                                    10.0, // vertical, move down 10
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                            child:
                                                                SingleChildScrollView(
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        5.0),
                                                                child: Column(
                                                                  children: <
                                                                      Widget>[
                                                                    Text(
                                                                      '${listaProyectos.Nombre_Proyecto}',
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              'Roboto',
                                                                          color: Colors
                                                                              .white,
                                                                          fontSize:
                                                                              16.0),
                                                                    ),
                                                                    SizedBox(
                                                                        height:
                                                                            10.0),
                                                                    Text(
                                                                        'Datos del Proyecto',
                                                                        style: TextStyle(
                                                                            fontFamily:
                                                                                'Roboto',
                                                                            color:
                                                                                Colors.blueAccent,
                                                                            fontSize: 16.0)),
                                                                    Divider(),
                                                                    Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .centerLeft,
                                                                      child: RichText(
                                                                          text: TextSpan(children: <TextSpan>[
                                                                        TextSpan(
                                                                            text:
                                                                                'Ubicación: \n',
                                                                            style: TextStyle(
                                                                                fontFamily: 'Roboto',
                                                                                color: Colors.black54,
                                                                                fontSize: 12.0)),
                                                                        TextSpan(
                                                                            text:
                                                                                '${listaProyectos.Ubicacion}',
                                                                            style: TextStyle(
                                                                                fontFamily: 'Roboto',
                                                                                color: Color(0xff007FFF),
                                                                                fontSize: 12.0))
                                                                      ])),
                                                                    ),
                                                                    Divider(),
                                                                    Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .centerLeft,
                                                                      child: RichText(
                                                                          text: TextSpan(children: <TextSpan>[
                                                                        TextSpan(
                                                                            text:
                                                                                'Descripción: \n',
                                                                            style: TextStyle(
                                                                                fontFamily: 'Roboto',
                                                                                color: Colors.black54,
                                                                                fontSize: 12.0)),
                                                                        TextSpan(
                                                                            text:
                                                                                '${listaProyectos.Descripcion}',
                                                                            style: TextStyle(
                                                                                fontFamily: 'Roboto',
                                                                                color: Color(0xff007FFF),
                                                                                fontSize: 12.0))
                                                                      ])),
                                                                    ),
                                                                    Divider(),
                                                                    Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .centerLeft,
                                                                      child: RichText(
                                                                          text: TextSpan(children: <TextSpan>[
                                                                        TextSpan(
                                                                            text:
                                                                                'Cliente: \n',
                                                                            style: TextStyle(
                                                                                fontFamily: 'Roboto',
                                                                                color: Colors.black54,
                                                                                fontSize: 12.0)),
                                                                        TextSpan(
                                                                            text:
                                                                                '${listaProyectos.Cliente}',
                                                                            style: TextStyle(
                                                                                fontFamily: 'Roboto',
                                                                                color: Color(0xff007FFF),
                                                                                fontSize: 12.0))
                                                                      ])),
                                                                    ),
                                                                    Divider(),
                                                                    Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .centerLeft,
                                                                      child: RichText(
                                                                          text: TextSpan(children: <TextSpan>[
                                                                        TextSpan(
                                                                            text:
                                                                                'Empresa: \n',
                                                                            style: TextStyle(
                                                                                fontFamily: 'Roboto',
                                                                                color: Colors.black54,
                                                                                fontSize: 12.0)),
                                                                        TextSpan(
                                                                            text:
                                                                                '${listaProyectos.Empresa}',
                                                                            style: TextStyle(
                                                                                fontFamily: 'Roboto',
                                                                                color: Color(0xff007FFF),
                                                                                fontSize: 12.0))
                                                                      ])),
                                                                    ),
                                                                    Divider(),
                                                                    Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .centerLeft,
                                                                      child: RichText(
                                                                          text: TextSpan(children: <TextSpan>[
                                                                        TextSpan(
                                                                            text:
                                                                                'Proyeccion: \n',
                                                                            style: TextStyle(
                                                                                fontFamily: 'Roboto',
                                                                                color: Colors.black54,
                                                                                fontSize: 12.0)),
                                                                        TextSpan(
                                                                            text:
                                                                                '${listaProyectos.Tipo_Proyeccion}',
                                                                            style: TextStyle(
                                                                                fontFamily: 'Roboto',
                                                                                color: Color(0xff007FFF),
                                                                                fontSize: 12.0))
                                                                      ])),
                                                                    ),
                                                                    Divider(),
                                                                    Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .centerLeft,
                                                                      child: RichText(
                                                                          text: TextSpan(children: <TextSpan>[
                                                                        TextSpan(
                                                                            text:
                                                                                'Nombre Origen: \n',
                                                                            style: TextStyle(
                                                                                fontFamily: 'Roboto',
                                                                                color: Colors.black54,
                                                                                fontSize: 12.0)),
                                                                        TextSpan(
                                                                            text:
                                                                                '${listaProyectos.ID_Proyeccion}',
                                                                            style: TextStyle(
                                                                                fontFamily: 'Roboto',
                                                                                color: Color(0xff007FFF),
                                                                                fontSize: 12.0))
                                                                      ])),
                                                                    ),
                                                                    Divider(
                                                                      height:
                                                                          20,
                                                                    ),
                                                                    FlatButton(
                                                                        onPressed:
                                                                            () {
                                                                          proyectos
                                                                              datosProyecto =
                                                                              listaProyectos;
                                                                          Navigator.push(
                                                                              context,
                                                                              MaterialPageRoute(
                                                                                builder: (context) => MenuPrincipalMB(
                                                                                  datosProyecto: datosProyecto,
                                                                                ),
                                                                              ));
                                                                        },
                                                                        child:
                                                                            Column(
                                                                          children: <
                                                                              Widget>[
                                                                            Image.asset(
                                                                              'assets/images/seleccionar.png',
                                                                              height: 40,
                                                                            ),
                                                                            Text('Seleccionar',
                                                                                style: TextStyle(color: Colors.blueAccent, fontSize: 14))
                                                                          ],
                                                                        ))
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ));
                                                        });
                                                  }
                                                }
                                              } else {
                                                return Center(
                                                    // Cargando Datos de Base de Datos Indicador de Progreso Infinito
                                                    child:
                                                        CircularProgressIndicator());
                                              }
                                            }),
                                      ),
                                    ),
                                  ),
                                  Divider(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      FlatButton(
                                          shape: new RoundedRectangleBorder(
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      20.0)),
                                          child: Text(
                                            'Cerrar Sesión',
                                            style: TextStyle(
                                              fontFamily: 'Roboto',
                                              fontSize: 12.0,
                                              color: Colors.white,
                                            ),
                                          ),
                                          color: Color(0xff007FFF),
                                          onPressed: () {
                                            logout();
                                          }),
                                      SizedBox(width: 10.0),
                                      FlatButton(
                                          shape: new RoundedRectangleBorder(
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      20.0)),
                                          child: Text(
                                            'Nuevo proyecto',
                                            style: TextStyle(
                                              fontFamily: 'Roboto',
                                              fontSize: 12.0,
                                              color: Colors.white,
                                            ),
                                          ),
                                          color: Color(0xff007FFF),
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      NuevoProyecto(
                                                    idUsuario: idUser,
                                                  ),
                                                ));
                                          }),
                                    ],
                                  ),
                                  FlatButton(
                                      shape: new RoundedRectangleBorder(
                                          borderRadius:
                                              new BorderRadius.circular(20.0)),
                                      child: Text(
                                        'Red Pasiva IGAC',
                                        style: TextStyle(
                                          fontFamily: 'Roboto',
                                          fontSize: 12.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                      color: Color(0xff007FFF),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  RedPasivaIgac(),
                                            ));
                                      }),
                                ],
                              ),
                            )
                          : Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                // Implementación de Interfaz para Login
                                children: <Widget>[
                                  Image.asset(
                                    'assets/images/logo.png',
                                    height: 80,
                                  ),
                                  SizedBox(
                                    height: 40.0,
                                  ),
                                  RichText(
                                      text: TextSpan(children: <TextSpan>[
                                    TextSpan(
                                        text: 'Tu Cartera de ',
                                        style: TextStyle(
                                          fontFamily: 'Roboto',
                                          height: 12.0,
                                          color: Colors.black54,
                                        )),
                                    TextSpan(
                                        text: 'Topografía',
                                        style: TextStyle(
                                          fontFamily: 'Roboto',
                                          color: Color(0xff007FFF),
                                          height: 12.0,
                                        )),
                                    TextSpan(
                                        text: ', ahora en tu dispositivo ',
                                        style: TextStyle(
                                          fontFamily: 'Roboto',
                                          color: Colors.black54,
                                          height: 12.0,
                                        )),
                                    TextSpan(
                                        text: 'Movil',
                                        style: TextStyle(
                                          fontFamily: 'Roboto',
                                          color: Color(0xff007FFF),
                                          height: 12.0,
                                        ))
                                  ])),
                                  SizedBox(
                                    height: 40.0,
                                  ),
                                  FlatButton(
                                      onPressed: () {
                                        login();
                                      },
                                      child: Image.asset(
                                        'assets/images/google.png',
                                        height: 50.0,
                                      )),
                                  SizedBox(
                                    height: 40.0,
                                  ),
                                  RichText(
                                      text: TextSpan(children: <TextSpan>[
                                    TextSpan(
                                        text: 'Ingresa a la ',
                                        style: TextStyle(
                                          fontFamily: 'Roboto',
                                          color: Colors.black54,
                                          height: 12.0,
                                        )),
                                    TextSpan(
                                        text: 'APP ',
                                        style: TextStyle(
                                          fontFamily: 'Roboto',
                                          color: Color(0xff007FFF),
                                          height: 12.0,
                                        )),
                                    TextSpan(
                                        text: 'con tu cuenta de ',
                                        style: TextStyle(
                                          fontFamily: 'Roboto',
                                          color: Colors.black54,
                                          height: 12.0,
                                        )),
                                    TextSpan(
                                        text: 'Google',
                                        style: TextStyle(
                                          fontFamily: 'Roboto',
                                          color: Color(0xff007FFF),
                                          height: 12.0,
                                        ))
                                  ])),
                                ],
                              ),
                            ))),
            )));
  }
}
