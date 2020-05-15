import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:measurebookapp/modelos/departamentos.dart';
import 'package:measurebookapp/modelos/origenesCartesianos.dart';
import 'package:measurebookapp/modelos/origenesGauss.dart';
import 'package:measurebookapp/clases/database.dart';
import 'package:measurebookapp/pages/menuPrincipal.dart';

class SeleccionSistemaCoordendas  extends StatefulWidget {
final String nombreProyectoMB,ubicacionMB, clienteMB, empresaMB, proyeccionMB, decripcionMB, id_Usuario;
final bool gauss;
final int fk_Municipio;
SeleccionSistemaCoordendas({Key key, this.nombreProyectoMB, this.ubicacionMB, this.decripcionMB, this.clienteMB, this.empresaMB, this.proyeccionMB, this.gauss, this.fk_Municipio, this.id_Usuario}) : super (key: key);

  @override
  _SeleccionSistemaCoordendasState createState() => _SeleccionSistemaCoordendasState();

}

bool _gauss;

class _SeleccionSistemaCoordendasState extends State<SeleccionSistemaCoordendas> {


  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: SafeArea(
        child: Center(
        child: SingleChildScrollView(
        child: widget.gauss
        ? 
    // Planas Gauss
    Container(
        decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        height: 650,
        width: 350,
        child: Scaffold(
          body:FutureBuilder<List<origenesGauss>>(
            future: gestorMBDatabase.db.getGauss(),
            builder: (BuildContext context, AsyncSnapshot<List<origenesGauss>> snapshot) {
              if(snapshot.hasData){
                return Swiper(
                  loop: false,
                  pagination: SwiperPagination(
                    builder: SwiperPagination.dots
                  ),
                  layout: SwiperLayout.STACK,
                  itemHeight: 560,
                  itemWidth: 320,
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index){
                    origenesGauss listaOrigenes = snapshot.data[index];
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        boxShadow: [
                          BoxShadow(
                          color: Colors.black45,
                          blurRadius: 5.0, // has the effect of softening the shadow
                          spreadRadius: 3.0, // has the effect of extending the shadow
                          offset: Offset(
                            10.0, // horizontal, move right 10
                            40.0, // vertical, move down 10
                          ),
                        )
                      ],
                      ),
                      key: UniqueKey(),
                      child: Card(
                        elevation: 14.0,
                        child: Container(
                          height: 520,
                          decoration: BoxDecoration(
                          image: DecorationImage(image: AssetImage('assets/images/fondo_sistemas.png'),
                          fit: BoxFit.cover,
                           ), 
                           borderRadius: BorderRadius.all(Radius.circular(10.0)
                           ),
                           boxShadow: [
                              BoxShadow(
                              color: Colors.black45,
                              blurRadius: 5.0, // has the effect of softening the shadow
                              spreadRadius: 3.0, // has the effect of extending the shadow
                              offset: Offset(
                                10.0, // horizontal, move right 10
                                10.0, // vertical, move down 10
                              ),
                            )
                           ]
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: <Widget>[
                                SizedBox(height: 0.0),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: RichText(text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(text: 'Gauss-Krüger', style: TextStyle(
                                      fontFamily: 'Roboto',
                                      color: Colors.white,
                                      fontSize: 16.0
                                      )),
                                  ]
                                )),
                                ),
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Text(
                                    '${listaOrigenes.NOMBRE}', style: TextStyle(
                                      fontFamily: 'Roboto',
                                      color: Colors.white,
                                      fontSize: 16.0
                                    ),
                                  ),
                                ),
                                SizedBox(height: 70.0),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: RichText(text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(text: 'DATUM: \n ', style: TextStyle(
                                      fontFamily: 'Roboto',
                                      color: Colors.black54,
                                      fontSize: 12.0
                                    )),
                                    TextSpan( text: 'Magna Sirgas', style: TextStyle(
                                      fontFamily: 'Roboto',
                                      color: Color(0xff007FFF),
                                      fontSize: 13.0
                                    ))
                                  ]
                                )),
                                ),
                                Divider(height: 5),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: RichText(text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(text: 'Elipsoide: \n', style: TextStyle(
                                      fontFamily: 'Roboto',
                                      color: Colors.black54,
                                      fontSize: 12.0
                                    )),
                                    TextSpan( text: 'GRS80', style: TextStyle(
                                      fontFamily: 'Roboto',
                                      color: Color(0xff007FFF),
                                      fontSize: 13.0
                                    ))
                                  ]
                                )),
                                ),
                                Divider(height: 5),
                                Align(
                                  alignment: Alignment.center,
                                  child: RichText(text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(text: 'Sistema de Proyección', style: TextStyle(
                                      fontFamily: 'Roboto',
                                      color: Color(0xff007FFF),
                                      fontSize: 14.0
                                    )),
                                  ]
                                )),
                                ),
                                SizedBox(height: 10),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: RichText(text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(text: 'Proyección \n', style: TextStyle(
                                      fontFamily: 'Roboto',
                                      color: Colors.black54,
                                      fontSize: 12.0
                                    )),
                                    TextSpan( text: 'Transversal de Mercator', style: TextStyle(
                                      fontFamily: 'Roboto',
                                      color: Color(0xff007FFF),
                                      fontSize: 13.0
                                    ))
                                  ]
                                )),
                                ),
                                Divider(),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: RichText(text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(text: 'Latitud de Origen \n', style: TextStyle(
                                      fontFamily: 'Roboto',
                                      color: Colors.black54,
                                      fontSize: 12.0
                                    )),
                                    TextSpan( text: '${listaOrigenes.LATITUD.toString()}', style: TextStyle(
                                      fontFamily: 'Roboto',
                                      color: Color(0xff007FFF),
                                      fontSize: 13.0
                                    ))
                                  ]
                                )),
                                ), 
                                Divider(),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: RichText(text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(text: 'Longitud de Origen \n', style: TextStyle(
                                      fontFamily: 'Roboto',
                                      color: Colors.black54,
                                      fontSize: 12.0
                                    )),
                                    TextSpan( text: '${listaOrigenes.LONGITUD.toString()}', style: TextStyle(
                                      fontFamily: 'Roboto',
                                      color: Color(0xff007FFF),
                                      fontSize: 13.0
                                    ))
                                  ]
                                )),
                                ),
                                Divider(),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: RichText(text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(text: 'Falso Norte \n', style: TextStyle(
                                      fontFamily: 'Roboto',
                                      color: Colors.black54,
                                      fontSize: 12.0
                                    )),
                                    TextSpan( text: '${listaOrigenes.NORTE.toString()}00 m', style: TextStyle(
                                      fontFamily: 'Roboto',
                                      color: Color(0xff007FFF),
                                      fontSize: 13.0
                                    ))
                                  ]
                                )),
                                ),
                                Divider(),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: RichText(text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(text: 'Falso Este \n', style: TextStyle(
                                      fontFamily: 'Roboto',
                                      color: Colors.black54,
                                      fontSize: 12.0
                                    )),
                                    TextSpan( text: '${listaOrigenes.ESTE.toString()} m', style: TextStyle(
                                      fontFamily: 'Roboto',
                                      color: Color(0xff007FFF),
                                      fontSize: 13.0
                                    ))
                                  ]
                                )),
                                ),
                                Divider(),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: RichText(text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(text: 'Factor de Escala\n ', style: TextStyle(
                                      fontFamily: 'Roboto',
                                      color: Colors.black54,
                                      fontSize: 12.0
                                    )),
                                    TextSpan( text: '1.000000000', style: TextStyle(
                                      fontFamily: 'Roboto',
                                      color: Color(0xff007FFF),
                                      fontSize: 13.0
                                    ))
                                  ]
                                )),
                                ),
                                Divider(), 
                                Align(
                                  alignment: Alignment.center,
                                  child: Center(
                                    child: Column(
                                      children: <Widget>[
                                        FlatButton(
                                          onPressed: (){
                                            gestorMBDatabase.db.InserDataSQL('INSERT INTO PROYECTOS (ID_USUARIO, Nombre_Proyecto, Tipo_Proyeccion, ID_Proyeccion, Ubicacion, Empresa, Cliente, Descripcion) VALUES ("${widget.id_Usuario}", "${widget.nombreProyectoMB}", "Gauss-Krüger", "${listaOrigenes.NOMBRE}", "${widget.ubicacionMB}", "${widget.empresaMB}", "${widget.clienteMB}",  "${widget.decripcionMB}")');
                                                    Navigator.push(context, MaterialPageRoute(
                                                    builder: (context) => MenuPrincipalMB(
                                                     clienteMB: widget.clienteMB,
                                                     decripcionMB: widget.decripcionMB,
                                                     empresaMB: widget.empresaMB,
                                                     id_proyeccion: listaOrigenes.NOMBRE,
                                                     id_usuario: widget.id_Usuario,
                                                     nombreProyectoMB: widget.nombreProyectoMB,
                                                     proyeccionMB: 'Gauss-Krüger',
                                                     ubicacionMB: widget.ubicacionMB,
                                                     ),
                                                     ));
                                                     }, 
                                                     child: Column(
                                                        children: <Widget>[
                                                        Image.asset('assets/images/seleccionar.png', height: 40,),
                                                        Text('Seleccionar',style: TextStyle(color: Colors.blueAccent, fontSize: 14))
                                                        ],
                                                      ))
                                                     ],
                                                     ),
                                                     ),
                                                     )
                                                     ],
                                                     ),
                                                    ),
                                                   ),
                                                   ));
                                                   }
                                                   );
                                                   }else {
                                                   return Center(
                                                   child: CircularProgressIndicator(),
                                                   );
                                                   }
                                                   },
                                                  ),
                                                )
                                                )
                                              
                                              // Planas cartesianas
                                              : Container(
                                                decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(Radius.circular(10.0)
                                                )
                                                ),
                                                height: 650,
                                                width: 350,
                                                child: Scaffold(
                                                  body:FutureBuilder<List<origenesCartesianos>>(
                                                    future: gestorMBDatabase.db.getCartesianas(widget.fk_Municipio),
                                                    builder: (BuildContext context, AsyncSnapshot<List<origenesCartesianos>> snapshot) {
                                                      if(snapshot.hasData){             
                                                        if (snapshot.data.length>1) {
                                                          return Swiper(
                                                          loop: false,
                                                          pagination: SwiperPagination(
                                                            builder: SwiperPagination.dots
                                                          ),
                                                          layout: SwiperLayout.STACK,
                                                          itemWidth: 320,
                                                          itemHeight: 550,
                                                          itemCount: snapshot.data.length,
                                                          itemBuilder: (BuildContext context, int index){
                                                            origenesCartesianos listaOrigenes = snapshot.data[index];
                                                            return Container(
                                                              decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                  color: Colors.black45,
                                                                  blurRadius: 5.0, // has the effect of softening the shadow
                                                                  spreadRadius: 3.0, // has the effect of extending the shadow
                                                                  offset: Offset(
                                                                    10.0, // horizontal, move right 10
                                                                    40.0, // vertical, move down 10
                                                                  ),
                                                                )
                                                              ],
                                                              ),
                                                              key: UniqueKey(),
                                                              child: Card(
                                                                elevation: 14.0,
                                                                child: Container(
                                                                  decoration: BoxDecoration(
                                                                  image: DecorationImage(image: AssetImage('assets/images/fondo_sistemas.png'),
                                                                  fit: BoxFit.cover,
                                                                   ), 
                                                                   borderRadius: BorderRadius.all(Radius.circular(10.0)
                                                                   ),
                                                                   boxShadow: [
                                                                        BoxShadow(
                                                                        color: Colors.black45,
                                                                        blurRadius: 5.0, // has the effect of softening the shadow
                                                                        spreadRadius: 3.0, // has the effect of extending the shadow
                                                                        offset: Offset(
                                                                          10.0, // horizontal, move right 10
                                                                          10.0, // vertical, move down 10
                                                                        ),
                                                                      )
                                                                    ],
                                                                   ),
                                                                  child: Padding(
                                                                    padding: const EdgeInsets.all(10.0),
                                                                    child: Column(
                                                                      children: <Widget>[
                                                                        SizedBox(height: 0.0),
                                                                        Align(
                                                                          alignment: Alignment.centerLeft,
                                                                          child: RichText(text: TextSpan(
                                                                          children: <TextSpan>[
                                                                            TextSpan(text: 'Plano Cartesiano', style: TextStyle(
                                                                              fontFamily: 'Roboto',
                                                                              color: Colors.white,
                                                                              fontSize: 16.0
                                                                              )),
                                                                          ]
                                                                        )),
                                                                        ),
                                                                        Align(
                                                                          alignment: Alignment.bottomLeft,
                                                                          child: Text(
                                                                            '${listaOrigenes.NOMBRE}', style: TextStyle(
                                                                              fontFamily: 'Roboto',
                                                                              color: Colors.white,
                                                                              fontSize: 16.0
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        SizedBox(height: 50.0),
                                                                        Align(
                                                                          alignment: Alignment.centerLeft,
                                                                          child: RichText(text: TextSpan(
                                                                          children: <TextSpan>[
                                                                            TextSpan(text: 'DATUM \n', style: TextStyle(
                                                                              fontFamily: 'Roboto',
                                                                              color: Colors.black54,
                                                                              fontSize: 12.0
                                                                            )),
                                                                            TextSpan( text: 'Magna Sirgas', style: TextStyle(
                                                                              fontFamily: 'Roboto',
                                                                              color: Color(0xff007FFF),
                                                                              fontSize: 14.0
                                                                            ))
                                                                          ]
                                                                        )),
                                                                        ),
                                                                        Divider(),
                                                                        Align(
                                                                          alignment: Alignment.centerLeft,
                                                                          child: RichText(text: TextSpan(
                                                                          children: <TextSpan>[
                                                                            TextSpan(text: 'Elipsoide\n', style: TextStyle(
                                                                              fontFamily: 'Roboto',
                                                                              color: Colors.black54,
                                                                              fontSize: 12.0
                                                                            )),
                                                                            TextSpan( text: 'GRS80', style: TextStyle(
                                                                              fontFamily: 'Roboto',
                                                                              color: Color(0xff007FFF),
                                                                              fontSize: 13.0
                                                                            ))
                                                                          ]
                                                                        )),
                                                                        ),
                                                                        SizedBox(height: 5.0,),
                                                                        Align(
                                                                          alignment: Alignment.center,
                                                                          child: RichText(text: TextSpan(
                                                                          children: <TextSpan>[
                                                                            TextSpan(text: 'Sistema de Proyección ', style: TextStyle(
                                                                              fontFamily: 'Roboto',
                                                                              color: Color(0xff007FFF),
                                                                              fontSize: 14.0
                                                                            )),
                                                                          ]
                                                                        )),
                                                                        ),
                                                                        SizedBox(height: 5.0),
                                                                        Align(
                                                                          alignment: Alignment.centerLeft,
                                                                          child: RichText(text: TextSpan(
                                                                          children: <TextSpan>[
                                                                            TextSpan(text: 'Proyección\n', style: TextStyle(
                                                                              fontFamily: 'Roboto',
                                                                              color: Colors.black54,
                                                                              fontSize: 12.0
                                                                            )),
                                                                            TextSpan( text: 'Plano Cartesiano IGAC', style: TextStyle(
                                                                              fontFamily: 'Roboto',
                                                                              color: Color(0xff007FFF),
                                                                              fontSize: 13.0
                                                                            ))
                                                                          ]
                                                                        )),
                                                                        ),
                                                                        Divider(),
                                                                        Align(
                                                                          alignment: Alignment.centerLeft,
                                                                          child: RichText(text: TextSpan(
                                                                          children: <TextSpan>[
                                                                            TextSpan(text: 'Latitud de Origen\n', style: TextStyle(
                                                                              fontFamily: 'Roboto',
                                                                              color: Colors.black54,
                                                                              fontSize: 12.0
                                                                            )),
                                                                            TextSpan( text: '${listaOrigenes.LATITUD.toString()}', style: TextStyle(
                                                                              fontFamily: 'Roboto',
                                                                              color: Color(0xff007FFF),
                                                                              fontSize: 13.0
                                                                            ))
                                                                          ]
                                                                        )),
                                                                        ), 
                                                                        Divider(),
                                                                        Align(
                                                                          alignment: Alignment.centerLeft,
                                                                          child: RichText(text: TextSpan(
                                                                          children: <TextSpan>[
                                                                            TextSpan(text: 'Longitud de Origen\n', style: TextStyle(
                                                                              fontFamily: 'Roboto',
                                                                              color: Colors.black54,
                                                                              fontSize: 12.0
                                                                            )),
                                                                            TextSpan( text: '${listaOrigenes.LONGITUD.toString()}', style: TextStyle(
                                                                              fontFamily: 'Roboto',
                                                                              color: Color(0xff007FFF),
                                                                              fontSize: 13.0
                                                                            ))
                                                                          ]
                                                                        )),
                                                                        ),
                                                                        Divider(),
                                                                        Align(
                                                                          alignment: Alignment.centerLeft,
                                                                          child: RichText(text: TextSpan(
                                                                          children: <TextSpan>[
                                                                            TextSpan(text: 'Falso Norte\n', style: TextStyle(
                                                                              fontFamily: 'Roboto',
                                                                              color: Colors.black54,
                                                                              fontSize: 12.0
                                                                            )),
                                                                            TextSpan( text: '${listaOrigenes.NORTE.toString()} m', style: TextStyle(
                                                                              fontFamily: 'Roboto',
                                                                              color: Color(0xff007FFF),
                                                                              fontSize: 13.0
                                                                            ))
                                                                          ]
                                                                        )),
                                                                        ),
                                                                        Divider(),
                                                                        Align(
                                                                          alignment: Alignment.centerLeft,
                                                                          child: RichText(text: TextSpan(
                                                                          children: <TextSpan>[
                                                                            TextSpan(text: 'Falso Este\n ', style: TextStyle(
                                                                              fontFamily: 'Roboto',
                                                                              color: Colors.black54,
                                                                              fontSize: 12.0
                                                                            )),
                                                                            TextSpan( text: '${listaOrigenes.ESTE.toString()} m', style: TextStyle(
                                                                              fontFamily: 'Roboto',
                                                                              color: Color(0xff007FFF),
                                                                              fontSize: 13.0
                                                                            ))
                                                                          ]
                                                                        )),
                                                                        ),
                                                                        Divider(),
                                                                        Align(
                                                                          alignment: Alignment.centerLeft,
                                                                          child: RichText(text: TextSpan(
                                                                          children: <TextSpan>[
                                                                            TextSpan(text: 'Altura del Plano\n ', style: TextStyle(
                                                                              fontFamily: 'Roboto',
                                                                              color: Colors.black54,
                                                                              fontSize: 12.0
                                                                            )),
                                                                            TextSpan( text: '${listaOrigenes.PLANO_PROY} m', style: TextStyle(
                                                                              fontFamily: 'Roboto',
                                                                              color: Color(0xff007FFF),
                                                                              fontSize: 13.0
                                                                            ))
                                                                          ]
                                                                        )),
                                                                        ),  
                                                                        Divider(),
                                                                        Align(
                                                                          alignment: Alignment.center,
                                                                          child: Center(
                                                                            child: Column(
                                                                              children: <Widget>[
                                                                                FlatButton(
                                                                                  onPressed: (){
                                                                                    gestorMBDatabase.db.InserDataSQL('INSERT INTO PROYECTOS (ID_USUARIO, Nombre_Proyecto, Tipo_Proyeccion, ID_Proyeccion, Ubicacion, Empresa, Cliente, Descripcion) VALUES (${widget.id_Usuario}, "${widget.nombreProyectoMB}", "Plano Cartesiano", "${listaOrigenes.NOMBRE}", "${widget.ubicacionMB}", "${widget.empresaMB}", "${widget.clienteMB}", "${widget.decripcionMB}")');
                                                                                    Navigator.push(context, MaterialPageRoute(
                                                                                    builder: (context) => MenuPrincipalMB(
                                                                                    clienteMB: widget.clienteMB,
                                                                                    decripcionMB: widget.decripcionMB,
                                                                                    empresaMB: widget.empresaMB,
                                                                                    id_proyeccion: listaOrigenes.NOMBRE,
                                                                                    id_usuario: widget.id_Usuario,
                                                                                    nombreProyectoMB: widget.nombreProyectoMB,
                                                                                    proyeccionMB: 'Plano Cartesiano',
                                                                                    ubicacionMB: widget.ubicacionMB,
                                                                                   ),
                                                                                  ));
                                                                                  }, 
                                                                                  child: Column(
                                                                                    children: <Widget>[
                                                                                    Image.asset('assets/images/seleccionar.png', height: 40,),
                                                                                    Text('Seleccionar',style: TextStyle(color: Colors.blueAccent, fontSize: 14))
                                                                                    ],
                                                                                  )
                                                                                  ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ));
                                                          }
                                                          );
                                                        } else {
                                                          return Swiper(
                                                          loop: false,
                                                          itemHeight: 550,
                                                          itemWidth: 320,
                                                          layout: SwiperLayout.STACK,
                                                          pagination: SwiperPagination(
                                                            builder: SwiperPagination.dots
                                                          ),
                                                          itemCount: snapshot.data.length,
                                                          itemBuilder: (BuildContext context, int index){
                                                            origenesCartesianos listaOrigenes = snapshot.data[index];
                                                            return Scaffold(
                                                              body: Container(
                                                                decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                                                ),
                                                                key: UniqueKey(),
                                                                child: Center(
                                                                  child: Card(
                                                                    elevation: 14.0,
                                                                    child: Container(
                                                                      height: 600,
                                                                      width: 300,
                                                                      decoration: BoxDecoration(
                                                                      image: DecorationImage(image: AssetImage('assets/images/fondo_sistemas.png'),
                                                                      fit: BoxFit.cover,
                                                                       ), 
                                                                       borderRadius: BorderRadius.all(Radius.circular(10.0)
                                                                       ),
                                                                       boxShadow: [
                                                                            BoxShadow(
                                                                            color: Colors.black45,
                                                                            blurRadius: 5.0, // has the effect of softening the shadow
                                                                            spreadRadius: 3.0, // has the effect of extending the shadow
                                                                            offset: Offset(
                                                                              10.0, // horizontal, move right 10
                                                                              10.0, // vertical, move down 10
                                                                            ),
                                                                          )
                                                                        ],
                                                                       ),
                                                                      child: Padding(
                                                                        padding: const EdgeInsets.all(15.0),
                                                                        child: Column(
                                                                          children: <Widget>[
                                                                            Align(
                                                                              alignment: Alignment.centerLeft,
                                                                              child: RichText(text: TextSpan(
                                                                              children: <TextSpan>[
                                                                                TextSpan(text: 'Plano Cartesiano', style: TextStyle(
                                                                                  fontFamily: 'Roboto',
                                                                                  color: Colors.white,
                                                                                  fontSize: 14.0
                                                                                  )),
                                                                              ]
                                                                            )),
                                                                            ),
                                                                            Align(
                                                                              alignment: Alignment.bottomLeft,
                                                                              child: Text(
                                                                                '${listaOrigenes.NOMBRE}', style: TextStyle(
                                                                                  fontFamily: 'Roboto',
                                                                                  color: Colors.white,
                                                                                  fontSize: 14.0
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            SizedBox(height: 45.0),
                                                                            Align(
                                                                              alignment: Alignment.centerLeft,
                                                                              child: RichText(text: TextSpan(
                                                                              children: <TextSpan>[
                                                                                TextSpan(text: 'DATUM \n', style: TextStyle(
                                                                                  fontFamily: 'Roboto',
                                                                                  color: Colors.black54,
                                                                                  fontSize: 12.0
                                                                                )),
                                                                                TextSpan( text: 'Magna Sirgas', style: TextStyle(
                                                                                  fontFamily: 'Roboto',
                                                                                  color: Color(0xff007FFF),
                                                                                  fontSize: 13.0
                                                                                ))
                                                                              ]
                                                                            )),
                                                                            ),
                                                                            Divider(),
                                                                            Align(
                                                                              alignment: Alignment.centerLeft,
                                                                              child: RichText(text: TextSpan(
                                                                              children: <TextSpan>[
                                                                                TextSpan(text: 'Elipsoide\n', style: TextStyle(
                                                                                  fontFamily: 'Roboto',
                                                                                  color: Colors.black54,
                                                                                  fontSize: 12.0
                                                                                )),
                                                                                TextSpan( text: 'GRS80', style: TextStyle(
                                                                                  fontFamily: 'Roboto',
                                                                                  color: Color(0xff007FFF),
                                                                                  fontSize: 13.0
                                                                                ))
                                                                              ]
                                                                            )),
                                                                            ),
                                                                            SizedBox(height: 5.0,),
                                                                            Align(
                                                                              alignment: Alignment.center,
                                                                              child: RichText(text: TextSpan(
                                                                              children: <TextSpan>[
                                                                                TextSpan(text: 'Sistema de Proyección ', style: TextStyle(
                                                                                  fontFamily: 'Roboto',
                                                                                  color: Color(0xff007FFF),
                                                                                  fontSize: 13.0
                                                                                )),
                                                                              ]
                                                                            )),
                                                                            ),
                                                                            Divider(),
                                                                            Align(
                                                                              alignment: Alignment.centerLeft,
                                                                              child: RichText(text: TextSpan(
                                                                              children: <TextSpan>[
                                                                                TextSpan(text: 'Proyección\n', style: TextStyle(
                                                                                  fontFamily: 'Roboto',
                                                                                  color: Colors.black54,
                                                                                  fontSize: 12.0
                                                                                )),
                                                                                TextSpan( text: 'Plano Cartesiano IGAC', style: TextStyle(
                                                                                  fontFamily: 'Roboto',
                                                                                  color: Color(0xff007FFF),
                                                                                  fontSize: 13.0
                                                                                ))
                                                                              ]
                                                                            )),
                                                                            ),
                                                                            Divider(),
                                                                            Align(
                                                                              alignment: Alignment.centerLeft,
                                                                              child: RichText(text: TextSpan(
                                                                              children: <TextSpan>[
                                                                                TextSpan(text: 'Latitud de Origen\n', style: TextStyle(
                                                                                  fontFamily: 'Roboto',
                                                                                  color: Colors.black54,
                                                                                  fontSize: 12.0
                                                                                )),
                                                                                TextSpan( text: '${listaOrigenes.LATITUD.toString()}', style: TextStyle(
                                                                                  fontFamily: 'Roboto',
                                                                                  color: Color(0xff007FFF),
                                                                                  fontSize: 13.0
                                                                                ))
                                                                              ]
                                                                            )),
                                                                            ), 
                                                                            Divider(),
                                                                            Align(
                                                                              alignment: Alignment.centerLeft,
                                                                              child: RichText(text: TextSpan(
                                                                              children: <TextSpan>[
                                                                                TextSpan(text: 'Longitud de Origen\n', style: TextStyle(
                                                                                  fontFamily: 'Roboto',
                                                                                  color: Colors.black54,
                                                                                  fontSize: 12.0
                                                                                )),
                                                                                TextSpan( text: '${listaOrigenes.LONGITUD.toString()}', style: TextStyle(
                                                                                  fontFamily: 'Roboto',
                                                                                  color: Color(0xff007FFF),
                                                                                  fontSize: 13.0
                                                                                ))
                                                                              ]
                                                                            )),
                                                                            ),
                                                                            Divider(),
                                                                            Align(
                                                                              alignment: Alignment.centerLeft,
                                                                              child: RichText(text: TextSpan(
                                                                              children: <TextSpan>[
                                                                                TextSpan(text: 'Falso Norte\n', style: TextStyle(
                                                                                  fontFamily: 'Roboto',
                                                                                  color: Colors.black54,
                                                                                  fontSize: 12.0
                                                                                )),
                                                                                TextSpan( text: '${listaOrigenes.NORTE.toString()} m', style: TextStyle(
                                                                                  fontFamily: 'Roboto',
                                                                                  color: Color(0xff007FFF),
                                                                                  fontSize: 13.0
                                                                                ))
                                                                              ]
                                                                            )),
                                                                            ),
                                                                            Divider(),
                                                                            Align(
                                                                              alignment: Alignment.centerLeft,
                                                                              child: RichText(text: TextSpan(
                                                                              children: <TextSpan>[
                                                                                TextSpan(text: 'Falso Este\n', style: TextStyle(
                                                                                  fontFamily: 'Roboto',
                                                                                  color: Colors.black54,
                                                                                  fontSize: 12.0
                                                                                )),
                                                                                TextSpan( text: '${listaOrigenes.ESTE.toString()} m', style: TextStyle(
                                                                                  fontFamily: 'Roboto',
                                                                                  color: Color(0xff007FFF),
                                                                                  fontSize: 13.0
                                                                                ))
                                                                              ]
                                                                            )),
                                                                            ),
                                                                            Divider(),
                                                                            Align(
                                                                              alignment: Alignment.centerLeft,
                                                                              child: RichText(text: TextSpan(
                                                                              children: <TextSpan>[
                                                                                TextSpan(text: 'Altura del Plano\n', style: TextStyle(
                                                                                  fontFamily: 'Roboto',
                                                                                  color: Colors.black54,
                                                                                  fontSize: 12.0
                                                                                )),
                                                                                TextSpan( text: '${listaOrigenes.PLANO_PROY} m', style: TextStyle(
                                                                                  fontFamily: 'Roboto',
                                                                                  color: Color(0xff007FFF),
                                                                                  fontSize: 13.0
                                                                                ))
                                                                              ]
                                                                            )),
                                                                            ),  
                                                                            Divider(),
                                                                            Align(
                                                                              alignment: Alignment.center,
                                                                              child: Center(
                                                                                child: Column(
                                                                                  children: <Widget>[
                                                                                    FlatButton(
                                                                                      onPressed: (){
                                                                                        gestorMBDatabase.db.InserDataSQL('INSERT INTO PROYECTOS (ID_USUARIO, Nombre_Proyecto, Tipo_Proyeccion, ID_Proyeccion, Ubicacion, Empresa, Cliente, Descripcion) VALUES ("${widget.id_Usuario}", "${widget.nombreProyectoMB}", "Plano Cartesiano", "${listaOrigenes.NOMBRE}", "${widget.ubicacionMB}", "${widget.empresaMB}", "${widget.clienteMB}",  "${widget.decripcionMB}")');
                                                                                        Navigator.push(context, MaterialPageRoute(
                                                                                        builder: (context) => MenuPrincipalMB(
                                                                                        clienteMB: widget.clienteMB,
                                                                                        decripcionMB: widget.decripcionMB,
                                                                                        empresaMB: widget.empresaMB,
                                                                                        id_proyeccion: listaOrigenes.NOMBRE,
                                                                                        id_usuario: widget.id_Usuario,
                                                                                        nombreProyectoMB: widget.nombreProyectoMB,
                                                                                        proyeccionMB: 'Plano Cartesiano',
                                                                                        ubicacionMB: widget.ubicacionMB,
                                                                                       ),
                                                                                      ));
                                          
                                                                                      }, 
                                                                                      child: Column(
                                                                                        children: <Widget>[
                                                                                        Image.asset('assets/images/seleccionar.png', height: 38,),
                                                                                        Text('Seleccionar',style: TextStyle(color: Colors.blueAccent, fontSize: 14))
                                                                                        ],
                                                                                      )
                                                                                      ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                )),
                                                            );
                                                          }
                                                          );
                                                       
                                                        }
                                          
                                                      }else {
                                                        return Center(
                                                          child: CircularProgressIndicator(),
                                                        );
                                                      }
                                                    },
                                                  ),
                                                )
                                                )
                                              )
                                          
                                              ),
      ),
                                              
                                            );
                                          }
}